// Cover Plate Generator
//
// This generates cover plates for empty switch locations on the Ben Peoples Industries Prospero Cue Light unit.
// https://benpeoples.com/stock-products/prospero-cue-light-system/
//
// OpenSCAD by Kevin McCoy. www.kevin-mccoy.com - @kevinrmccoy on github
//

include <BOSL2/std.scad>;

/* [User Parameters] */
// Number of "units" (empty switch panels) wide.
number_of_units = 1; // [1:10]

// Make only the corner mounting holes, rather than for every plate position?
corner_holes_only = false;

// Enable to cut holes for the switch and LED (for a single switch configuration.)
electronics_holes = false;

// LED hole diameter. (6.15 for mounting the LED to this plate, 7.62 is default for slipping this plate over the LED lens.) [mm]
led_hole_diameter = 7.62; // 0.001

// Total thickness of the plate [mm]. (1.2 default for blank plates, try 0.6 for a label that goes over an existing plate (hold in place using the switch nut.))
plate_thickness = 1.2; // [0.6:0.05:2.0]

/* [Full Plate Text Parameters] */
// Set to true to add text to the full plate, false to disable.
enable_text_full = false;

// How the text interacts with the plate. (Emboss raises text, deboss lowers text.)
text_full_effect = "emboss"; // [emboss, deboss]

// Make multi-color print? (When effect is "deboss" this will fill the debossed part with a separate color.)
text_full_separate = true;

// The text to display on the plate.
text_full_string = "Prospero";

// Font size. [mm]
text_full_size = 4; // [1:0.1:20]

// Font name and style.
text_full_font_mw = "Liberation Sans"; // font

// Depth/height for deboss/emboss [mm].
text_full_effect_depth = 0.4; // [0.1:0.05:2.0]

// Text baseline orientation on the plate.
text_full_rotation = 0; // [0:45:360]

// Horizontal offset from plate center for text's center point [mm].
text_full_center_width_offset = 0; // [-40:0.1:40]

// Vertical offset from plate center for text's center point [mm]. (0 is default, try 15 for switch plates.)
text_full_center_height_offset = 0; // [-50:0.1:50]

// Horizontal alignment of text string relative to its center point.
text_full_halign = "center"; // ["left", "center", "right"]

// Vertical alignment of text string relative to its center point.
text_full_valign = "baseline"; // ["top", "center", "baseline", "bottom"]

// Text spacing between characters.
text_full_spacing = 1; // [1:0.05:5]

// Add a backing rectangle the width of the plate around the text.
enable_text_full_backing = false;

// Tweak the size of the backing rectangle (from its default which is based on the size of the text.)
text_full_backing_size = 0; // [-2:0.1:2]

// Tweak the vertical position of the backing rectangle (from its default which is based on the text's center.)
text_full_backing_height_adjust = 0; // [-6:0.1:6]

// Depth of backing rectangle [mm]. (Default is 0.4 mm.)
text_full_backing_depth = 0.4; // [0.2:0.1:2]

/* [Per Switch Text Parameters] */
// Set to true to add text per switch, false to disable.
enable_text_ps = false;

// How the text interacts with the plate. (Emboss raises text, deboss lowers text.)
text_ps_effect = "emboss"; // [emboss, deboss]

// Make multi-color print? (When effect is "deboss" this will fill the debossed part with a separate color.)
text_ps_separate = true;

// A comma-delimited list of text to show for each switch, for example "a, b, c".  Any leading or trailing spaces will be removed.  Excess items will be ignored.  
text_ps_string = "a, b, c";

// Font size. [mm]
text_ps_size = 4; // [1:0.1:20]

// Font name and style.
text_ps_font_mw = "Liberation Sans"; // font

// Depth/height for deboss/emboss [mm].
text_ps_effect_depth = 0.4; // [0.1:0.05:2.0]

// Text baseline orientation on the plate.
text_ps_rotation = 0; // [0:45:360]

// Horizontal offset from plate center for text's center point [mm].
text_ps_center_width_offset = 0; // [-40:0.1:40]

// Vertical offset from plate center for text's center point [mm]. (6 is a decent option for use with the switch cutout.)
text_ps_center_height_offset = 6; // [-50:0.1:50]

// Horizontal alignment of text string relative to its center point.
text_ps_halign = "center"; // ["left", "center", "right"]

// Vertical alignment of text string relative to its center point.
text_ps_valign = "baseline"; // ["top", "center", "baseline", "bottom"]

// Text spacing between characters.
text_ps_spacing = 1; // [1:0.05:5]

// Add backing rectangles the width of each switch plate around the text. See the description or readme for color info.
enable_text_ps_backing = false;

// Tweak the size of the backing rectangles (from its default which is based on the size of the text.)
text_ps_backing_size = 0; // [-2:0.1:2]

// Tweak the vertical position of the backing rectangles (from its default which is based on the text's center.)
text_ps_backing_height_adjust = 0; // [-6:0.1:6]

// Depth of backing rectangles [mm]. (Default is 0.4 mm.)
text_ps_backing_depth = 0.4; // [0.2:0.1:2]

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

/* [Stiffener Parameters] */
// Set to true to add a pattern on the back of a plate that can strengthen the plate for mounting a switch and LED.  SEE README FOR CAUTIONS.
enable_stiffener = false;

// If this plate will be mounted first (left-most) or last (right-most) on the unit, select the appropriate option to allow for frame clearance.
end_plate = "none"; // [none, first, last]

// Thickness of stiffener backing [mm]. (3.0 default)
stiffener_depth = 3.0; // 0.1

/* [Advanced User Parameters] */
// Diameter of mounting holes [mm]. (3.25 default)
hole_diameter = 3.25; // [1:0.01:5]

// Nominal size of the chamfer on edges [mm]. Makes edges not sharp.  0.4 is a good number.
edge_chamfer_size = 0.4; // [0:0.05:1]

// Radius for the filleted corners of the overall plate [mm]. Makes corners not sharp.  0.5 is a good number.
corner_fillet_radius = 0.5; // [0:0.05:1]

// Resolution of curves. Higher values give smoother curves but increase rendering time.
resolution = 100; //[10, 20, 30, 50, 100]

/* [Prospero Fit Parameters] */
// Don't change these unless you're having fit issues.

// Height of the plate (79.5 default) [mm].
plate_height = 79.5; // 0.1

// Distance between the centers of a pair of mounting holes for a single unit (71.438 default) [mm].
hole_spacing = 71.438; // 0.001

// Width for a single unit. (19 default) [mm].
single_unit_width = 19; // 0.001

// Center distance for holes from unit to unit (19.304 default) [mm].
inter_unit_spacing = 19.304; // 0.001

// Distance from the bottom of the plate to the center of the switch hole. (30.35 default) [mm].
switch_hole_spacing = 30.35; // 0.001

// Switch hole diameter. (12.30 default) [mm].
switch_hole_diameter = 12.30; // 0.01

// Distance from the top of the plate to the center of the LED hole. (11.975 default) [mm].
led_hole_spacing = 11.975; // 0.001

// Space in stiffener for switch width [mm]. (16.2 default)
switch_width_clearance = 16.2; // 0.01

// Space in stiffener for switch height [mm]. (30.2 default)
switch_height_clearance = 30.2; // 0.01

// Space in stiffener for LED width [mm]. (16.2 default)
led_width_clearance = 16.2; // 0.01

// Space in stiffener for LED height [mm]. (10.15 default)
led_height_clearance = 10.15; // 0.01

// Height of side stiffener (functionally, the height of clear area between the upper and lower mounting rails) [mm]. (60.5 default)
stiffener_height = 60.5; // 0.01

/* [Hidden] */

test_mode = false;
$fn = resolution; // Rendering quality
thin_dim = 0.01; // A small value used for making hulls or ensuring cuts.
text_full_font_name = text_full_font_mw;
text_full_effect_depth_effective = ( (text_full_effect == "deboss") && (text_full_effect_depth > plate_thickness)) ? plate_thickness : text_full_effect_depth;
svg_effect_depth_effective = ( (svg_effect == "deboss") && (svg_effect_depth > plate_thickness)) ? plate_thickness : svg_effect_depth;
png_effect_depth_effective = ( (png_effect == "deboss") && (png_effect_depth > plate_thickness)) ? plate_thickness : png_effect_depth;
safe_bound_height = plate_thickness + 2 * max(0, text_full_effect_depth_effective, svg_effect_depth_effective, png_effect_depth_effective) + 2 * thin_dim;
plate_color = "Black";
text_full_color = "White";
text_full_backing_color = "Blue";
text_ps_color = "SaddleBrown";
svg_color = "Yellow";
png_color = "Pink";
png_depth_scale = png_effect_depth / 100;
inter_unit_extra = inter_unit_spacing - single_unit_width;

// --- Calculate Overall Plate Width ---
generated_plate_width =
  (number_of_units <= 0) ? single_unit_width
  : // Make single plate for unit values below 1.
  (number_of_units == 1) ? single_unit_width
  : (single_unit_width + (number_of_units - 1) * inter_unit_spacing);

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
          translate(
            [
              sx * (generated_plate_width / 2 - corner_fillet_radius),
              sy * (plate_height / 2 - corner_fillet_radius),
            ]
          )
            circle(r=corner_fillet_radius);
        }
      }
    }
  } else {
    square(size=[generated_plate_width, plate_height], center=true);
  }
}

// Sketch for the plan view of the top and bottom surface (to create chamfer) (at z=0 and z=plate_thickness).
// This profile is smaller than the main body cross-section.
module tapered_edge_plan_sketch() {
  xy_offset_for_taper = edge_chamfer_size;
  offset(delta=-xy_offset_for_taper) {
    main_body_plan_sketch(); // Offset from the main body profile
  }
}

module stiffener_body() {
  difference() {
    translate([0, 0, (-1 * ( (stiffener_depth - thin_dim) / 2))]) {
      cube([generated_plate_width, stiffener_height, stiffener_depth], center=true);
    }
    led_hole_center = (plate_height / 2) - led_hole_spacing;
    switch_hole_center = (plate_height / 2) - switch_hole_spacing;
    for (i = [0:max(0, number_of_units - 1)]) {
      current_unit_width_center = (number_of_units == 1) ? 0 : (i - (number_of_units - 1) / 2) * inter_unit_spacing;
      translate([current_unit_width_center, led_hole_center, (-1 * ( (stiffener_depth - thin_dim) / 2))]) {
        cube(size=[led_width_clearance, led_height_clearance, stiffener_depth + thin_dim], center=true);
      }
      translate([current_unit_width_center, -switch_hole_center, (-1 * ( (stiffener_depth - thin_dim) / 2))]) {
        cube(size=[switch_width_clearance, switch_height_clearance, stiffener_depth + thin_dim], center=true);
      }
    }
  }
}

// Module to create the 3D plate body with tapered edges.
module plate_body() {
  union() {
    hull() {
      // Make bottom of plate
      linear_extrude(height=thin_dim) {
        tapered_edge_plan_sketch();
      }
      translate([0, 0, actual_taper_z_dim_calc])
        linear_extrude(height=thin_dim) {
          main_body_plan_sketch();
        }
    }
    middle_height = plate_thickness - (actual_taper_z_dim_calc * 2);
    if (middle_height > thin_dim) {
      // Make middle of plate (Only need to extrude this bit if the overall plate is thicker than the chamfer.)
      translate([0, 0, actual_taper_z_dim_calc])
        linear_extrude(height=middle_height) main_body_plan_sketch();
    }

    hull() {
      // Make top of plate
      translate([0, 0, plate_thickness - actual_taper_z_dim_calc])
        linear_extrude(height=thin_dim) {
          main_body_plan_sketch();
        }
      translate([0, 0, plate_thickness])
        linear_extrude(height=thin_dim) {
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
  for (i = [0:max(0, number_of_units - 1)]) {
    // Calculate Y offset for the center of the current unit's hole pattern.
    // The pattern of unit centers is itself centered around Y=0.
    current_unit_width_center =
      (number_of_units == 1) ? 0
      : (i - (number_of_units - 1) / 2) * inter_unit_spacing;

    // Create the pair of holes (spaced along long axis by hole_spacing) for the current unit at its calculated center.
    if ( (i == 0) || (i == (number_of_units - 1)) || (corner_holes_only == false)) {
      translate([current_unit_width_center, hole_spacing / 2, hole_cut_height / 2])
        cylinder(r=hole_radius, h=hole_cut_height, center=true);
      translate([current_unit_width_center, -hole_spacing / 2, hole_cut_height / 2])
        cylinder(r=hole_radius, h=hole_cut_height, center=true);
    }
  }
}

module electronics_holes() {
  led_hole_radius = led_hole_diameter / 2;
  led_hole_center = (plate_height / 2) - led_hole_spacing;
  switch_hole_radius = switch_hole_diameter / 2;
  switch_hole_center = (plate_height / 2) - switch_hole_spacing;
  hole_cut_height = safe_bound_height;

  for (i = [0:max(0, number_of_units - 1)]) {
    // Calculate Y offset for the center of the current unit's hole pattern.
    // The pattern of unit centers is itself centered around Y=0.
    current_unit_width_center =
      (number_of_units == 1) ? 0
      : (i - (number_of_units - 1) / 2) * inter_unit_spacing;

    // Create the electronics holes for the current unit at its calculated center.
    translate([current_unit_width_center, led_hole_center, hole_cut_height / 2])
      cylinder(r=led_hole_radius, h=hole_cut_height, center=true);
    translate([current_unit_width_center, -switch_hole_center, hole_cut_height / 2])
      cylinder(r=switch_hole_radius, h=hole_cut_height, center=true);
  }
}

module text_full(in_color = false) {
  if (in_color) {
    color(text_full_color) {
      text_object(
        string=text_full_string,
        size=text_full_size,
        font=text_full_font_name,
        halign=text_full_halign,
        valign=text_full_valign,
        spacing=text_full_spacing,
        rotation=text_full_rotation,
        pos_w=text_full_center_width_offset,
        pos_h=text_full_center_height_offset,
        effect=text_full_effect,
        depth=text_full_effect_depth
      );
    }
  } else {
    text_object(
      string=text_full_string,
      size=text_full_size,
      font=text_full_font_name,
      halign=text_full_halign,
      valign=text_full_valign,
      spacing=text_full_spacing,
      rotation=text_full_rotation,
      pos_w=text_full_center_width_offset,
      pos_h=text_full_center_height_offset,
      effect=text_full_effect,
      depth=text_full_effect_depth
    );
  }
}

module text_full_backing() {
  translate([0, (text_full_center_height_offset + (text_full_size * 0.4) + text_full_backing_height_adjust), ( (plate_thickness + thin_dim) - (text_full_backing_depth / 2))]) {
    cube(size=[(generated_plate_width - 1), ( (text_full_size * 1.4) + text_full_backing_size), (text_full_backing_depth + (thin_dim))], center=true);
  }
}

module text_per_switch(in_color = false) {
  // Split the text_ps_string by commas into an array
  text_labels = str_split(text_ps_string, ",");
  num_labels = len(text_labels);
  for (i = [0:max(0, min(number_of_units - 1, num_labels - 1))]) {
    // Calculate X position for each unit (centered)
    current_unit_width_center =
      (number_of_units == 1) ? 0
      : (i - (number_of_units - 1) / 2) * inter_unit_spacing;
    // Get the label for this unit (trim whitespace)
    label = str_strip(text_labels[i], " ");
    // Place the text object for this unit
    if (in_color) {
      t_r = 1;
      t_g = ( (i * 10) / 255);
      t_b = 1;
      color([t_r, t_g, t_b]) {
        echo("text ps clr", this_color);
        text_object(
          string=label,
          size=text_ps_size,
          font=text_ps_font_mw,
          halign=text_ps_halign,
          valign=text_ps_valign,
          spacing=text_ps_spacing,
          rotation=text_ps_rotation,
          pos_w=current_unit_width_center + text_ps_center_width_offset,
          pos_h=text_ps_center_height_offset,
          effect=text_ps_effect,
          depth=text_ps_effect_depth
        );
      }
    } else {
      text_object(
        string=label,
        size=text_ps_size,
        font=text_ps_font_mw,
        halign=text_ps_halign,
        valign=text_ps_valign,
        spacing=text_ps_spacing,
        rotation=text_ps_rotation,
        pos_w=current_unit_width_center + text_ps_center_width_offset,
        pos_h=text_ps_center_height_offset,
        effect=text_ps_effect,
        depth=text_ps_effect_depth
      );
    }
  }
}

module text_per_switch_backing(in_color = false) {
  for (i = [0:max(0, min(number_of_units - 1))]) {
    // Calculate X position for each unit (centered)
    current_unit_width_center =
      (number_of_units == 1) ? 0
      : (i - (number_of_units - 1) / 2) * inter_unit_spacing;
    if (in_color) {
      t_r = 0.25;
      t_g = ( (i * 10) / 255);
      t_b = ( (i * 10) / 255);
      color([t_r, t_g, t_b]) {
        echo("backing ps clr", this_color);
        translate([current_unit_width_center, (text_ps_center_height_offset + (text_ps_size * 0.4) + text_ps_backing_height_adjust), ( (plate_thickness + thin_dim) - (text_ps_backing_depth / 2))]) {
          cube(size=[(single_unit_width - .4), ( (text_ps_size * 1.4) + text_ps_backing_size), (text_ps_backing_depth + (thin_dim))], center=true);
        }
      }
    } else {
      translate([current_unit_width_center, (text_ps_center_height_offset + (text_ps_size * 0.4) + text_ps_backing_height_adjust), ( (plate_thickness + thin_dim) - (text_ps_backing_depth / 2))]) {
        cube(size=[(single_unit_width - .4), ( (text_ps_size * 1.4) + text_ps_backing_size), (text_ps_backing_depth + (thin_dim))], center=true);
      }
    }
  }
}
module text_object(string, size, font, halign, valign, spacing, rotation, pos_w, pos_h, effect, depth) {
  // Z-level of the main flat top surface of the plate (this is below the top taper)
  // Text will be placed relative to this surface.
  front_face_z_level = plate_thickness;
  text_effect_depth_effective = ( (effect == "deboss") && (depth > plate_thickness)) ? plate_thickness : depth;

  text_extrude_val = (effect == "deboss") ? text_effect_depth_effective + 2 * thin_dim : text_effect_depth_effective;
  z_pos_text_base_val = (effect == "emboss") ? front_face_z_level : front_face_z_level - text_effect_depth_effective;

  translate([pos_w, pos_h, z_pos_text_base_val]) {
    // Apply rotation for vertical text orientation
    text_object_rotation = [0, 0, rotation];

    rotate(text_object_rotation) {
      linear_extrude(height=text_extrude_val) {
        text(
          string,
          size=size,
          font=font,
          halign=halign,
          valign=valign,
          spacing=spacing
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
        linear_extrude(height=svg_extrude_val) {
          import(file=svg_file, center=true);
        }
      }
    }
  }
}

module png_object() {
  front_face_z_level = plate_thickness;
  z_pos_png_base_val = (png_effect == "emboss") ? front_face_z_level : front_face_z_level + 2 * thin_dim;
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
            difference() {
              // This cuts off the 1 unit "footprint" imposed under the image by the surface cmd.
              surface(file=png_file, center=true, invert=false);
              translate([0, 0, -0.50]) {
                cube(size=[scaled_plate_width * 2, scaled_plate_height * 2, 1], center=true);
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
  box_height = enable_stiffener ? (stiffener_depth + safe_bound_height + 2 * thin_dim) : safe_bound_height;
  box_depth = enable_stiffener ? (stiffener_depth + 2 * thin_dim) : 0;
  difference() {
    translate([0, 0, -1 * box_depth]) {
      linear_extrude(height=box_height) {
        tapered_edge_plan_sketch();
      }
    }
    mounting_holes();
    if (electronics_holes) {
      electronics_holes();
    }
  }
}

module plate_end_cutoff(direction = "first") {
  end_direction = direction == "first" ? -1 : 1;
  cutoff_center = (generated_plate_width / 2) - 1;
  translate([end_direction * cutoff_center, 0, -1 * ( (stiffener_depth + thin_dim) / 2)]) {
    cube(size=[2, plate_height, stiffener_depth], center=true);
  }
}

module null_object() {
  // Makes a thin object out of the way used as a placeholder
  z_distance = plate_thickness;
  translate(0, 0, -z_distance) {
    linear_extrude(height=thin_dim);
  }
}

// --- Main Assembly ---
if (test_mode) {
  echo("test mode");
  stiffener_body();
} else if (number_of_units > 0) {
  color(plate_color) {
    difference() {
      // Start with plate body with embossed non-separate items
      union() {
        plate_body();
        if (enable_stiffener) {
          intersection() {
            stiffener_body();
            decoration_bounding_box();
          }
        }
        if (enable_text_full && (text_full_effect == "emboss") && !text_full_separate) {
          intersection() {
            text_full();
            decoration_bounding_box();
          }
        }
        if (enable_text_ps && (text_ps_effect == "emboss") && !text_ps_separate) {
          intersection() {
            text_per_switch(in_color=false);
            decoration_bounding_box();
          }
        }
        if (enable_svg && (svg_effect == "emboss") && !svg_separate) {
          intersection() {
            svg_object();
            decoration_bounding_box();
          }
        }
        if (enable_png && (png_effect == "emboss") && !png_separate) {
          intersection() {
            png_object();
            decoration_bounding_box();
          }
        }
      }
      // Subtract mounting holes
      mounting_holes();
      // Subtract electronics holes
      if (electronics_holes) {
        electronics_holes();
      }
      if ( (enable_stiffener) && (end_plate != "none")) {
        plate_end_cutoff(direction=end_plate);
      }
      // Subtract debossed items
      if (enable_text_full && (text_full_effect == "deboss")) {
        intersection() {
          text_full();
          decoration_bounding_box();
        }
      }
      if (enable_text_ps && (text_ps_effect == "deboss")) {
        intersection() {
          text_per_switch(in_color=false);
          decoration_bounding_box();
        }
      }
      if (enable_svg && (svg_effect == "deboss")) {
        intersection() {
          svg_object();
          decoration_bounding_box();
        }
      }
      if (enable_png && (png_effect == "deboss")) {
        intersection() {
          png_object();
          decoration_bounding_box();
        }
      }
      if ( (enable_text_full_backing) && (enable_text_full)) {
        intersection() {
          text_full_backing();
          decoration_bounding_box();
        }
      }
      if ( (enable_text_ps_backing) && (enable_text_ps)) {
        intersection() {
          text_per_switch_backing();
          decoration_bounding_box();
        }
      }
    }
  }
  if ( (enable_text_full) && (text_full_separate)) {
    intersection() {
      text_full(in_color=true);
      decoration_bounding_box();
    }
  }
  if ( (enable_text_ps) && (text_ps_separate)) {
    intersection() {
      text_per_switch(in_color=true);
      decoration_bounding_box();
    }
  }
  if ( (enable_svg) && (svg_separate)) {
    color(svg_color) {
      intersection() {
        svg_object();
        decoration_bounding_box();
      }
    }
  }
  if ( (enable_png) && (png_separate)) {
    color(png_color) {
      intersection() {
        png_object();
        decoration_bounding_box();
      }
    }
  }
  if ( (enable_text_full_backing) && (enable_text_full)) {
    color(text_full_backing_color) {
      intersection() {
        difference() {
          text_full_backing();
          text_full();
        }
        decoration_bounding_box();
      }
    }
  }
  if ( (enable_text_ps_backing) && (enable_text_ps)) {
    intersection() {
      difference() {
        text_per_switch_backing(in_color = true);
        text_per_switch();
      }
      decoration_bounding_box();
    }
  }
} else {
  %cube(1); // Show a small cube if number_of_units is invalid, to indicate an issue.
  // The % highlights it in purple in OpenSCAD preview.
  echo("Warning: number_of_units is not positive, generating a placeholder.");
}
