// printable.scad - models in printable orientation
// Andrew Ho <andrew@zeuscat.com>

include <adapter.scad>

gap = 5;

translate([0, 0, adapter_height]) mirror([0, 0, 1]) adapter();

translate([(spindle_diameter / 2) + gap + adapter_peg_base_radius, 0, 0]) {
  adapter_peg();
}
