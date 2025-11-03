// Nomad Label Plate Generator
//
// For Twin!
//
// OpenSCAD by Kevin McCoy. www.kevin-mccoy.com - @kevinrmccoy on github
//

include <BOSL2/std.scad>;

/* [Text Parameters] */

// Set to true to add text to the full plate, false to disable.
enable_text = true;

// The text to display on the plate.  You can use backslash (\) as a line separator.
text_string = "Property of\ACT's Tech Dept";

// Make text all caps?
text_caps = false;

// Font size. [mm]
text_size = 4; // [1:0.1:20]

// Font name and style.
text_font = "Liberation Sans"; // font

// Text baseline orientation on the plate.
text_rotation = 0; // [0:45:360]

// Depth for text [mm].  Best is to do it in multiples of your layer size.
text_effect_depth = 0.4; // [0.1:0.01:1.0]

// Horizontal offset from plate center for text's center point [mm].
text_center_width_offset = 0; // [-40:0.1:40]

// Vertical offset from plate center for text's center point [mm].
text_center_height_offset = 0; // [-50:0.1:50]

// Horizontal alignment of text string relative to its center point.
text_halign = "center"; // ["left", "center", "right"]

// Vertical alignment of text string relative to its center point.
text_valign = "baseline"; // ["top", "center", "baseline", "bottom"]

// Text spacing between characters.
text_spacing = 1; // [1:0.05:5]

// Adjustment factor for the space between lines when using multiline text. (1.2 is default.)
multiline_space_factor = 1.2; // [0.1:0.1:2.0]

/* [SVG Parameters] */

// Set to true to include an SVG.
enable_svg = false;

// SVG file -- see notes for file info.
svg_file = "default.svg";

// Depth for SVG [mm].  Best is to do it in multiples of your layer size.
svg_effect_depth = 0.4; // [0.1:0.01:1.0]

// SVG orientation on the plate.
svg_rotation = 0; // [0:45:360]

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

// Depth for PNG [mm].  Best is to do it in multiples of your layer size.
png_effect_depth = 0.4; // [0.1:0.01:1.0]

// PNG size (at scale 0.1, 10 pixels is 1 mm).
png_scale = 0.1; // [0.01:0.01:3]

// PNG orientation on the plate.
png_rotation = 0; // [0:45:360]

// Horizontal offset from plate center for png's center point [mm].
png_center_width_offset = 0; // [-40:0.1:40]

// Vertical offset from plate center for png's center point [mm].
png_center_height_offset = 0; // [-50:0.1:50]

/* [Advanced User Parameters] */

// Height of the plate (23.8 default) [mm].
plate_height = 23.8; // 0.1

// Width of the plate (98.8 default) [mm].
plate_width = 98.8; // 0.1

// Thickness of the plate (1.0 default) [mm].
plate_thickness = 1.0; // 0.1

// Diameter of mounting holes [mm]. (3.10 default)
hole_diameter = 3.10; // [1:0.01:5]

// Distance from long edge of plate to hole center [mm]. (4.90 default)
vertical_hole_offset = 4.9; // 0.01

// Distance from short edge of plate to hole center [mm]. (4.90 default)
horizontal_hole_offset = 4.9; // 0.01

// Safe zone distance for text and images from edge of holes [mm]. (0.6 default)
horizontal_safe_margin = 0.6; // 0.1

// Safe zone distance for text and images from long edge of plate [mm]. (0.6 default)
vertical_safe_margin = 0.6; // 0.1

// Nominal size of the chamfer on edges [mm]. Makes edges not sharp and improves print quality.
edge_chamfer_size = 0.2; // [0:0.05:1]

// Resolution of curves. Higher values give smoother curves but increase rendering time.
resolution = 100; //[10, 20, 30, 50, 100]

/* [Hidden] */

test_mode = false;
$fn = resolution; // Rendering quality
thin_dim = 0.01; // A small value used for making hulls or ensuring cuts.

text_depth_actual = max(text_effect_depth, plate_thickness);
svg_depth_actual = max(svg_effect_depth, plate_thickness);
png_depth_actual = max(png_effect_depth, plate_thickness);

plate_color = "DarkSlateGrey";
text_color = "White";
svg_color = "Yellow";
png_color = "Pink";
png_depth_scale = png_effect_depth / 100;
