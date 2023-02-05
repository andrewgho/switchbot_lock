// adapter.scad - adapter to mate SwitchBot Lock with Marvin deadbolt thumbturn
// Andrew Ho <andrew@zeuscat.com>
//
// Origin x-y plane faces door, up is either x-axis direction.

include <thumbturn.scad>
include <spindle.scad>

adapter_thickness = 2;
adapter_post_hole_height = spindle_post_diameter * (3 / 2);
adapter_height =
  thumbturn_height + adapter_thickness + adapter_post_hole_height;

adapter_slop = 0.5;
adapter_inner_radius = (thumbturn_shaft_diameter / 2) + adapter_slop;
adapter_inner_width = thumbturn_wing_width + (2 * adapter_slop);

e = 0.1;
e2 = e * 2;

module adapter() {
  module post_hole() {
    // Conical hat so hole can print without supports
    cylinder(d1 = 0, d2 = spindle_post_diameter, h = spindle_post_diameter / 2);
    translate([0, 0, spindle_post_diameter / 2]) {
      cylinder(d = spindle_post_diameter, h = spindle_post_height + e);
    }
  }

  bracket_hole_height = spindle_bracket_height + (spindle_bracket_width / 2);
  module bracket_hole_right() {
    translate([0, -spindle_bracket_depth / 2, 0]) {
      hull() {
        // Ridgeline that forms a 45° roof so hole can print without supports
        translate([(spindle_bracket_width - 0.1) / 2, 0, 0]) {
          cube([0.1, spindle_bracket_depth, 0.1]);
        }
        translate([0, 0, spindle_bracket_width / 2]) {
          cube([spindle_bracket_width, spindle_bracket_depth,
                spindle_bracket_height + e]);
        }
      }
    }
  }
  module bracket_hole_left() {
    mirror([1, 0, 0]) bracket_hole_right();
  }

  difference() {
    cylinder(d = spindle_diameter, h = adapter_height, $fn = 90);

    // Cut out thumbturn
    translate([0, 0, -e]) {
      cylinder(r = adapter_inner_radius, h = thumbturn_height + e, $fn = 90);
      translate([0, 0, thumbturn_height / 2]) {
        cube([spindle_diameter + e2, adapter_inner_width, thumbturn_height + e],
             center = true);
      }
    }

    // Cut out holes for spindle posts
    translate([0, 0, adapter_height - adapter_post_hole_height]) {
      translate([ spindle_post_inner_width / 2, 0, 0]) post_hole();
      translate([-spindle_post_inner_width / 2, 0, 0]) post_hole();
    }

    // Cut out holes for brackets
    translate([0, 0, adapter_height - bracket_hole_height]) {
      translate([-spindle_bracket_x, -spindle_bracket_y]) bracket_hole_left();
      translate([-spindle_bracket_x,  spindle_bracket_y]) bracket_hole_left();
      translate([ spindle_bracket_x,  spindle_bracket_y]) bracket_hole_right();
      translate([ spindle_bracket_x, -spindle_bracket_y]) bracket_hole_right();
    }
  }
}
