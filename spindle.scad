// spindle.scad - thumbturn spindle on main Switchbot Lock unit
// Andrew Ho <andrew@zeuscat.com>

// Measured dimensions
spindle_diameter      = 36.7;   // OD of outermost (closest to lock) plate
spindle_height        =  4.0;   // Height/thickness of outermost plate
spindle_hole_diameter =  5.0;   // ID of center hole where thumbturn snaps into
spindle_post_diameter =  4.2;   // OD of post protrusions stabilizing thumbturn
spindle_post_height   =  5;     // Very approximate post height

spindle_post_inner_width = 22.3;  // 22.1 according to outer width
spindle_post_outer_width = 29.1;  // 29.3 according to inner width

spindle_post_y_offset =
  (spindle_post_inner_width +
   ((spindle_post_outer_width - spindle_post_inner_width) / 2)) / 2;

spindle_bracket_width       =  1.9;   // Ranges from 1.8–2.0
spindle_bracket_outer_width = 21.65;  // 21.55 according to inner width
spindle_bracket_inner_width = 17.75;  // 17.85 according to outer width

spindle_bracket_depth       =  4.2;
spindle_bracket_outer_depth = 20.25;  // 20.4 according to inner depth
spindle_bracket_inner_depth = 12.0;   // 11.85 according to outer depth

spindle_bracket_thickness = 1.2;
spindle_bracket_height = 3.3;

// Measured/calculated distances to centers of brackets
spindle_bracket_x = 9.875;
spindle_bracket_y = 8.06;

// Rendering parameters
$fn = 90;
e = 0.1;
e2 = e * 2;

module spindle() {
  module post() {
    cylinder(d = spindle_post_diameter, h = spindle_post_height);
  }
  module bracket_right() {
    translate([-spindle_bracket_width / 2, -spindle_bracket_depth / 2, 0]) {
      difference() {
        cube([spindle_bracket_width,
              spindle_bracket_depth,
              spindle_bracket_height]);
        translate([spindle_bracket_thickness, spindle_bracket_thickness, -e]) {
          cube([(spindle_bracket_width - spindle_bracket_thickness) + e,
                spindle_bracket_depth - (2 * spindle_bracket_thickness),
                spindle_bracket_height + e2]);
        }
      }
    }
  }
  module bracket_left() {
    mirror([1, 0, 0]) bracket_right();
  }
  difference() {
    cylinder(d = spindle_diameter, h = spindle_height);
    translate([0, 0, -e]) {
      cylinder(d = spindle_hole_diameter, h = spindle_height + e2);
    }
  }
  translate([0, 0, spindle_height]) {
    translate([ spindle_post_y_offset, 0, 0]) post();
    translate([-spindle_post_y_offset, 0, 0]) post();
    translate([-spindle_bracket_x, -spindle_bracket_y, 0]) bracket_left();
    translate([-spindle_bracket_x,  spindle_bracket_y, 0]) bracket_left();
    translate([ spindle_bracket_x,  spindle_bracket_y, 0]) bracket_right();
    translate([ spindle_bracket_x, -spindle_bracket_y, 0]) bracket_right();
  }
}
