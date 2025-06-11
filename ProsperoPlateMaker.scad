// Cover Plate Generator
//
// This generates cover plates for empty switch locations on the Ben Peoples Industries Prospero Cue Light unit.
// https://benpeoples.com/stock-products/prospero-cue-light-system/
//
// OpenSCAD by Kevin McCoy. www.kevin-mccoy.com - @kevinrmccoy on github
//

/* [User Parameters] */
// Number of "units" (empty switch panels) wide.
number_of_units = 1; // [1:10]

//Resolution of curves. Higher values give smoother curves but increase rendering time.
resolution = 100; //[10, 20, 30, 50, 100]

/* [Text Parameters] */
// Set to true to add text, false to disable.
enable_text = false;       

// How the text interacts with the plate. (Emboss raises text, deboss lowers text.)
text_effect = "emboss"; // [emboss, deboss]

// Make multi-color print? (When effect is "deboss" this will fill the debossed part with a separate color.)
text_separate = false;

// [The text to display on the plate.
text_string = "Prospero";

// Font size. [mm]
text_size = 4; // [1:0.1:20]

// Font name and style.
text_font_mw = "Liberation Sans"; // font

// Depth/height for deboss/emboss [mm].
text_effect_depth = 0.4; // [0.1:0.05:2.0]

// Text baseline orientation on the plate.
text_rotation = 90; // [0:45:360]

// Horizontal offset from plate center for text's center point [mm].
text_center_width_offset = 0; // [-40:0.1:40]

// Vertical offset from plate center for text's center point [mm].
text_center_height_offset = 0; // [-50:0.1:50]

// Horizontal alignment of text string relative to its center point.
text_halign = "center"; // ["left", "center", "right"]

// Vertical alignment of text string relative to its center point.
text_valign = "center"; // ["top", "center", "baseline", "bottom"]

// Text spacing between characters.
text_spacing = 1; // [1:0.05:5]

/* [SVG Parameters] */
// Set to true to include an SVG.
enable_svg = false;

// SVG file -- see notes for file info.
svg_file = "default.svg";

// How the SVG interacts with the plate.
svg_effect = "emboss"; // [emboss, deboss]

// Make multi-color print? (When effect is "deboss" this will fill the debossed part with a separate color.)
svg_separate = false;

// Depth/height for deboss/emboss [mm].
svg_effect_depth = 0.4; // [0.1:0.05:2.0]

// SVG orientation on the plate.
svg_rotation = 90; // [0:45:360]

// SVG size
svg_scale = 0.1; // [0.01:0.01:3]

// Horizontal offset from plate center for SVG's center point [mm].
svg_center_width_offset = 0; // [-40:0.1:40]

// Vertical offset from plate center for SVG's center point [mm].
svg_center_height_offset = 0; // [-50:0.1:50]

/* [PNG Parameters] */
// Set to true to include a PNG.
enable_png = false;

// PNG file -- see notes for file info.
png_file = "default.png";

// How the PNG interacts with the plate.
png_effect = "emboss"; // [emboss, deboss]

// Make multi-color print? (When effect is "deboss" this will fill the debossed part with a separate color.)
png_separate = false;

// Max depth/height for deboss/emboss [mm].
png_effect_depth = 0.4; // [0.1:0.05:2.0]

// PNG size (at scale 0.1, 10 pixels is 1 mm).
png_scale = 0.1; // [0.01:0.01:3]

// PNG orientation on the plate.
png_rotation = 90; // [0:45:360]

// Horizontal offset from plate center for png's center point [mm].
png_center_width_offset = 0; // [-40:0.1:40]

// Vertical offset from plate center for png's center point [mm].
png_center_height_offset = 0; // [-50:0.1:50]

/* [Advanced User Parameters] */
// Total thickness of the plate [mm]. (1.2 default)
plate_thickness = 1.2; // [0.8:0.05:2.0]

// Diameter of mounting holes [mm]. (3.25 default)
hole_diameter = 3.25; // [1:0.01:5]

// Nominal size of the chamfer on edges [mm]. Makes edges not sharp.  0.4 is a good number.
edge_chamfer_size = 0.4; // [0:0.05:1]

// Radius for the filleted corners of the overall plate [mm]. Makes corners not sharp.  0.5 is a good number.
corner_fillet_radius = 0.5; // [0:0.05:1]

/* [Prospero Fit Parameters] */
// Don't change these unless you're having fit issues.

// Height of the plate (79.5 default) [mm]. (Don't change this unless you're having fit issues.)
plate_height = 79.5; // 0.1

// Distance between the centers of a pair of mounting holes for a single unit (71.438 default) [mm]. (Don't change this unless you're having fit issues.)
hole_spacing = 71.438; // 0.001

// Width for a single unit. (19 default) [mm]. (Don't change this unless you're having fit issues.)
single_unit_width = 19; // 0.001

// Center distance for holes from unit to unit (19.304 default) [mm]. (Don't change this unless you're having fit issues.)
inter_unit_spacing = 19.304; // 0.001

/* [Non-MakerWorld Text Options] */

// Use this font and font styling instead of the MakerWorld chooser above (Use this option if you're not running on MakerWorld).
local_font = false;

// Font name. Ensure it's installed on your system. 
text_font = "Liberation Sans"; // [Liberation Mono, Liberation Sans, Liberation Serif]

// Font style, not all fonts support all styles.
text_font_style = "Regular"; // [Regular, Italic, Bold, Bold Italic]

/* [Hidden] */

$fn = resolution; // Rendering quality
thin_dim = 0.01; // A small value used for making hulls or ensuring cuts.
text_full_font = local_font ? str(text_font , ":style=", text_font_style) : text_font_mw;
text_effect_depth_effective = ((text_effect == "deboss") && (text_effect_depth > plate_thickness)) ? plate_thickness : text_effect_depth;
svg_effect_depth_effective = ((svg_effect == "deboss") && (svg_effect_depth > plate_thickness)) ? plate_thickness : svg_effect_depth;
png_effect_depth_effective = ((png_effect == "deboss") && (png_effect_depth > plate_thickness)) ? plate_thickness : png_effect_depth;
safe_bound_height = plate_thickness + 2 * max(0,text_effect_depth_effective, svg_effect_depth_effective, png_effect_depth_effective) + 2 * thin_dim;
plate_color = "DarkSlateGrey";
text_color = "White";
svg_color = "Yellow";
png_color = "Pink";
png_depth_scale = png_effect_depth / 100;

// --- Calculate Overall Plate Width ---
generated_plate_width = (number_of_units <= 0) ? single_unit_width : // Make single plate for unit values below 1.
						(number_of_units == 1) ? single_unit_width :
						(single_unit_width + (number_of_units - 1) * inter_unit_spacing);

// --- Calculated Taper Z-Dim ---
// Z-height of the tapered/chamfered edge portion.
actual_taper_z_dim_calc = min(edge_chamfer_size, plate_thickness / 2); // If half the plate is thinner than the chamfer, use the half plate for the height.

// --- Modules ---

// Sketch of main plate body plan view (centered at origin).
// Dimensions are (generated_plate_width (X) by plate_height (Y)) with filleted corners.
// Uses hull command by placing four fillet circles at the corners and then filling in the area in between.
module main_body_plan_sketch() {
	if (corner_fillet_radius > 0) {
		hull() {
			for (sx = [-1, 1]) {
				for (sy = [-1, 1]) {
					translate([
						sx * (generated_plate_width/2 - corner_fillet_radius),
						sy * (plate_height/2 - corner_fillet_radius)
					]) 
					circle(r = corner_fillet_radius);
				}
			}
		}
	} else {
		square(size = [generated_plate_width, plate_height], center=true);
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

// Module to create the 3D plate body with tapered edges.
module plate_body() {
	union() {
		hull() { // Make bottom of plate
			linear_extrude(height = thin_dim) {
				tapered_edge_plan_sketch();
			}
			translate([0,0,actual_taper_z_dim_calc])
				linear_extrude(height = thin_dim) {
					main_body_plan_sketch();
				}
		}
		middle_height = plate_thickness - (actual_taper_z_dim_calc * 2);
		if (middle_height > thin_dim) { // Make middle of plate (Only need to extrude this bit if the overall plate is thicker than the chamfer.)
			translate([0,0,actual_taper_z_dim_calc])
				linear_extrude(height = middle_height) main_body_plan_sketch();
		}
		
		hull() { // Make top of plate
			translate([0,0,plate_thickness - actual_taper_z_dim_calc]) 
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
	hole_cut_height = safe_bound_height;
	
	// Loop through each unit to place its pair of holes
	for (i = [0 : max(0, number_of_units - 1)]) { 
		// Calculate Y offset for the center of the current unit's hole pattern.
		// The pattern of unit centers is itself centered around Y=0.
		current_unit_width_center = (number_of_units == 1) ? 0 : 
								(i - (number_of_units - 1) / 2) * inter_unit_spacing;

		// Create the pair of holes (spaced along long axis by hole_spacing) for the current unit at its calculated center.
		translate([current_unit_width_center, hole_spacing/2, hole_cut_height/2]) 
			cylinder(r = hole_radius, h = hole_cut_height, center=true);
		translate([current_unit_width_center, -hole_spacing/2, hole_cut_height/2]) 
			cylinder(r = hole_radius, h = hole_cut_height, center=true);
	}
}

module text_object() {
	// Z-level of the main flat top surface of the plate (this is below the top taper)
	// Text will be placed relative to this surface.
	front_face_z_level = plate_thickness;

	text_extrude_val = (text_effect == "deboss") ? text_effect_depth_effective + 2 * thin_dim : text_effect_depth_effective;
	z_pos_text_base_val = (text_effect == "emboss") ? front_face_z_level : front_face_z_level - text_effect_depth_effective;

	translate([text_center_width_offset, text_center_height_offset, z_pos_text_base_val]) {
		// Apply rotation for vertical text orientation
		text_object_rotation = [0, 0, text_rotation];

		rotate(text_object_rotation) {
			linear_extrude(height = text_extrude_val) {
				text(text_string, 
					size = text_size, 
					font = text_full_font, 
					halign = text_halign, 
					valign = text_valign,
					spacing = text_spacing
					);
			}
		}
	}
}

module svg_object() {
	front_face_z_level = plate_thickness;

	svg_extrude_val = (svg_effect == "deboss") ? svg_effect_depth_effective + 2 * thin_dim : svg_effect_depth_effective;
	z_pos_svg_base_val = (svg_effect == "emboss") ? front_face_z_level : front_face_z_level - svg_effect_depth_effective;

	translate([svg_center_width_offset, svg_center_height_offset, z_pos_svg_base_val]) {
		svg_object_rotation = [0, 0, svg_rotation];
		svg_object_scaling = [svg_scale, svg_scale, 1];

		rotate(svg_object_rotation) {
			scale(svg_object_scaling) {
				linear_extrude(height = svg_extrude_val) {
					import(file = svg_file, center=true);
				}
			}
		}
	}

}

module png_object() {
	front_face_z_level = plate_thickness;
	z_pos_png_base_val = (png_effect == "emboss") ? front_face_z_level : front_face_z_level + 2*thin_dim;
	png_mirroring = [0, 0, png_effect == "deboss" ? 1 : 0];
	scaled_plate_width = generated_plate_width / png_scale;
	scaled_plate_height = plate_height / png_scale;
	png_object_rotation = png_rotation;
	png_object_scaling = [png_scale, png_scale, png_depth_scale];

	intersection() {
		translate([png_center_width_offset, png_center_height_offset, z_pos_png_base_val]) {
			rotate(png_object_rotation) {
				scale(png_object_scaling) {
					mirror(png_mirroring) {
						difference() { // This cuts off the 1 unit "footprint" imposed under the image by the surface cmd.
							surface(file = png_file, center = true, invert = false);
							translate([0,0,-0.50]) {
								cube(size = [scaled_plate_width*2, scaled_plate_height*2, 1], center = true);
							}
						}
					}
				}
			}
		}
		decoration_bounding_box();
	}
}

module decoration_bounding_box() {
	// Makes a bounding box for allowable text placement.
	box_height = safe_bound_height;
	difference() {
		linear_extrude(height = box_height) {
			tapered_edge_plan_sketch();
		}
		mounting_holes();
	}
}

module null_object() {
	// Makes a thin object out of the way used as a placeholder
	z_distance = plate_thickness;
	translate(0,0,-z_distance) {
		linear_extrude(height = thin_dim);
	}
}

// --- Main Assembly ---
if (test_branch) {
	echo("test branch");
//	#plate_body();
	png_object();
} else if (number_of_units > 0) {
	color(plate_color) {
		difference() {
			// Start with plate body with embossed non-separate items
			union() {
				plate_body();
				if (enable_text && (text_effect == "emboss") && !text_separate) {
					intersection() {
						// Make text object that exists only above the plate
						text_object();
						decoration_bounding_box();
					}
				}
				if (enable_svg && (svg_effect == "emboss") && !svg_separate) {
					intersection() {
						// Make svg object that exists only above the plate
						svg_object();
						decoration_bounding_box();
					}
				}
				if (enable_png && (png_effect == "emboss") && !png_separate) {
					intersection() {
						// Make png object that exists only above the plate
						png_object();
						decoration_bounding_box();
					}
				}

			}
			// Subtract mounting holes
			mounting_holes();
			// Subtract debossed items
			if (enable_text && (text_effect == "deboss")) {
				text_object();
			}
			if (enable_svg && (svg_effect == "deboss")) {
				svg_object();
			}
			if (enable_png && (png_effect == "deboss")) {
				png_object();
			}

		}
	}
	if ((enable_text) && (text_separate)) {
		color(text_color) {
			intersection() { // Make text object that exists only above the plate
				text_object();
				decoration_bounding_box();
			}
		} 
	}
	if ((enable_svg) && (svg_separate)) {
		color(svg_color) {
			intersection() { // Make svg object that exists only above the plate
				svg_object();
				decoration_bounding_box();
			}
		} 
	}
	if ((enable_png) && (png_separate)) {
		color(png_color) {
			intersection() { // Make png object that exists only above the plate
				png_object();
				decoration_bounding_box();
			}
		} 
	}

} else {
	%cube(1); // Show a small cube if number_of_units is invalid, to indicate an issue.
			  // The % highlights it in purple in OpenSCAD preview.
	echo("Warning: number_of_units is not positive, generating a placeholder.");
}