// Cover Plate Generator
//
// This generates cover plates for the Ben Peoples Industries Prospero Cue Light unit.

/* [ User Parameters ] */
// Number of "units" (empty switch panels) wide.
number_of_units = 1; // [1:10]

// Is this plate going on the end of the unit? (Not yet implemented)
end_plate = false;

//If so, is it going on the left end or right end?
end_position = "left"; // [left, right]

//Resolution of curves. Higher values give smoother curves but increase rendering time.
resolution = 100; //[10, 20, 30, 50, 100]

/* [ Advanced User Parameters ] */
// Total thickness of the plate [mm] (1.2 default)
plate_thickness = 1.2; // [0.8:0.05:2.0]

// Diameter of mounting holes [mm] (3.25 default)
hole_diameter = 3.25; // [1:0.01:5]

// Nominal size of the chamfer on edges [mm]. Makes edges not sharp.  0.4 is a good number.
edge_chamfer_size = 0.4; // [0:0.05:1]

// Radius for the filleted corners of the overall plate [mm] Makes corners not sharp.  0.5 is a good number.
corner_fillet_radius = 0.5; // [0:0.05:1]

/* [ Prospero Fit Parameters ] */
// Don't change these unless you're having fit issues.

// Length of the plate (79.5 default) [mm] (Don't change this unless you're having fit issues.)
plate_length = 79.5; // 0.1

// Distance between the centers of a pair of mounting holes for a single unit (71.438 default) [mm] (Don't change this unless you're having fit issues.)
hole_spacing = 71.438; // 0.001

// Width for a single unit. (19 default) [mm] (Don't change this unless you're having fit issues.)
single_unit_width = 19; // 0.001

// Center distance for holes from unit to unit. (19.304 default.) [mm] (Don't change this unless you're having fit issues.)
inter_unit_spacing = 19.304; // 0.001

// Amount to cut off the end if this panel is going on the first or last slots. (2.0 default.) [mm] (Don't change this unless you're having fit issues.)
end_plate_clearance = 2; // 0.01
// TODO: Reset this number

/* [ Hidden ] */

$fn = resolution; // Rendering quality
thin_dim = 0.01; // A small value used for making hulls.

// --- Calculate Overall Plate Y-Width ---
generated_plate_y_width = (number_of_units <= 0) ? single_unit_width : // Make single plate for unit values below 1.
                         (number_of_units == 1) ? single_unit_width :
                         (single_unit_width + (number_of_units - 1) * inter_unit_spacing);


// --- Modules ---

// Sketch of main plate body plan view (centered at origin).
// Dimensions are plate_length (X) x generated_plate_y_width (Y) with filleted corners.
// Uses hull command by placing four fillet circles at the corners and then filling in the area in between.
// TODO: Needs accommodation for 0 size fillet
module main_body_plan_sketch() {
	if (corner_fillet_radius > 0) {
		hull() {
			for (sx = [-1, 1]) {
				for (sy = [-1, 1]) {
					translate([
						sx * (plate_length/2 - corner_fillet_radius),
						sy * (generated_plate_y_width/2 - corner_fillet_radius)
					]) 
					circle(r = corner_fillet_radius);
				}
			}
		}
	} else {
		square(size = [plate_length, generated_plate_y_width], center=true);
	}
}


// Sketch for the plan view of the top and bottom surface (to create chamfer) (at z=0 and z=plate_thickness).
// This profile is smaller than the main body cross-section.
module tapered_edge_plan_sketch() {
    xy_offset_for_taper = edge_chamfer_size;
    offset(delta = -xy_offset_for_taper) {
        main_body_plan_sketch(); // Offset from the main body profile
    }
}


// Module to create the 3D plate body with tapered edges ("<--->" profile)
module plate_body() {
	actual_taper_z_height = min(edge_chamfer_size, plate_thickness / 2); // If half the plate is thinner than the chamfer, use the half plate for the height.
    
    union() {
        hull() { // Make bottom of plate
            linear_extrude(height = thin_dim) {
				tapered_edge_plan_sketch();
			}
			
            translate([0,0,actual_taper_z_height])
				linear_extrude(height = thin_dim) {
					main_body_plan_sketch();
				}
        }
        
        middle_height = plate_thickness - (actual_taper_z_height * 2);
        if (middle_height > thin_dim) { // Make middle of plate (Only need to extrude this bit if the overall plate is thicker than the chamfer.)
            translate([0,0,actual_taper_z_height])
                linear_extrude(height = middle_height) main_body_plan_sketch();
        }
        
        hull() { // Make top of plate
            translate([0,0,plate_thickness - actual_taper_z_height]) 
				linear_extrude(height = thin_dim) {
					main_body_plan_sketch();
				}
            translate([0,0,plate_thickness]) 
				linear_extrude(height = thin_dim) {
					tapered_edge_plan_sketch(); 
				}
		}
    }
}

// Module to create the mounting holes for all units
module mounting_holes() {
    hole_radius = hole_diameter / 2;
    hole_cut_height = plate_thickness + 2 * thin_dim; // This makes sure it really cuts through
    
    // Loop through each unit to place its pair of holes
    for (i = [0 : max(0, number_of_units - 1)]) { 
        // Calculate Y offset for the center of the current unit's hole pattern.
        // The pattern of unit centers is itself centered around Y=0.
        current_unit_y_center = (number_of_units == 1) ? 0 : 
                                 (i - (number_of_units - 1) / 2) * inter_unit_spacing;

        // Create the pair of holes (spaced along X-axis by hole_spacing) for the current unit at its calculated Y-center.
        translate([hole_spacing/2, current_unit_y_center, plate_thickness/2]) 
            cylinder(r = hole_radius, h = hole_cut_height, center=true);
        translate([-hole_spacing/2, current_unit_y_center, plate_thickness/2]) 
            cylinder(r = hole_radius, h = hole_cut_height, center=true);
    }
}

module end_plate_cutoff() {
    cut_height = plate_thickness + 2 * thin_dim; // This makes sure it really cuts through
	end_plate_y_center = (generated_plate_y_width/2) - (end_plate_clearance/2);
	end_direction = (end_position == "left") ? 1 : -1;
	translate([0, generated_plate_y_width/2*end_direction, plate_thickness/2])
		cube(size=[plate_length, end_plate_clearance, cut_height], center=true);
}

// --- Main Assembly ---
// Subtract mounting holes from the plate body
if (number_of_units > 0) { // Only generate if there's at least one unit
    difference() {
        plate_body();
        mounting_holes();
		if (end_plate) {
			end_plate_cutoff();
		}
    }
} else {
    %cube(1); // Show a small cube if number_of_units is invalid, to indicate an issue.
              // The % highlights it in purple in OpenSCAD preview.
    echo("Warning: number_of_units is not positive, generating a placeholder.");
}