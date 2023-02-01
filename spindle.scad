// spindle.scad - thumbturn spindle on main Switchbot Lock unit
// Andrew Ho <andrew@zeuscat.com>

// Measured dimensions
spindle_diameter      = 36.7;   // OD of outermost (closest to lock) plate
spindle_height        =  4.0;   // Height/thickness of outermost plate
spindle_hole_diameter =  5.0;   // ID of center hole where thumbturn snaps into
spindle_post_diameter =  3.5;   // OD of post protrusions stabilizing thumbturn
spindle_post_height   =  5;     // Very approximate post height

// Approximately measured distance between inner/outer edges of posts
spindle_post_inner_distance = 22.3;  // 22.1 according to outer distance
spindle_post_outer_distance = 29.1;  // 29.3 according to inner distance

// Rendering parameters
$fn = 90;
e = 0.1;
e2 = e * 2;

module spindle() {
  module post() {
    cylinder(d = spindle_post_diameter, h = spindle_post_height);
  }
  difference() {
    cylinder(d = spindle_diameter, h = spindle_height);
    translate([0, 0, -e]) cylinder(d = spindle_hole_diameter, h = spindle_height + e2);
  }
  translate([0, 0, spindle_height]) {
    translate([ spindle_post_inner_distance / 2, 0, 0]) post();
    translate([-spindle_post_inner_distance / 2, 0, 0]) post();
  }
}

spindle();
