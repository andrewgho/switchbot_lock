// exploded_view.scad - view SwitchBot Lock/Marvin handleset parts in context
// Andrew Ho <andrew@zeuscat.com>

include <thumbturn.scad>
include <spindle.scad>

gap = 10;  // Gap between exploded view parts

// TODO: handleset plate

thumbturn();

translate([0, 0, thumbturn_shaft_height + gap]) {
  // Shaft is modeled with SwitchBot surface side up, so flip vertically
  translate([0, 0, spindle_height + spindle_post_height]) {
    mirror([0, 0, 1]) spindle();
  }
}
