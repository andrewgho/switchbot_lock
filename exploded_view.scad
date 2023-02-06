// exploded_view.scad - view SwitchBot Lock/Marvin handleset parts in context
// Andrew Ho <andrew@zeuscat.com>

include <thumbturn.scad>
include <adapter.scad>
include <spindle.scad>

gap = 20;  // Gap between exploded view parts

rotate([0, 90, 0]) {

  // TODO: handleset plate

  #thumbturn();

  translate([0, 0, thumbturn_shaft_height + gap]) {
    adapter_peg();

    translate([0, 0, adapter_base_thickness + adapter_peg_shaft_length + gap]) {
      adapter();

      translate([0, 0, adapter_height + gap]) {
        // Shaft is modeled a quarter turn offset, so rotate 90°
        rotate(90, [0, 0, 1]) {
          // Shaft is modeled with SwitchBot surface side up; flip vertically
          translate([0, 0, spindle_height + spindle_post_height]) {
            mirror([0, 0, 1]) #spindle();
          }
        }
      }
    }
  }

}
