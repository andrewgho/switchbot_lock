// thumbturn.scad - thumbturn on Marvin door lockset
// Andrew Ho <andrew@zeuscat.com>
//
// Lockset surface on door is origin x-y plane, up is either x-axis direction.

// TODO: model handleset plate separately (just recording measured values here)
handleset_width = 196.85;  // Overall side to side width without radius
handleset_top_to_thumbturn_bottom = 282.90;

thumbturn_shaft_diameter = 18.6;   // Diameter of central shaft
thumbturn_shaft_height   = 25.75;  // Outer plane of thumbturn to lockset plate
thumbturn_length         = 50.0;   // Overall top to bottom length
thumbturn_wing_length    = 16.25;  // Very approximate individual wing (unused)
thumbturn_wing_width     =  6.0;   // Thickness of individual thumb wings
thumbturn_height         = 17.25;  // Outer plane of thumbturn to back of wing

// TODO: measure set screw location more precisely
thumbturn_set_screw_diameter = 6.5;  // Protrusion coming out of shaft side

module thumbturn() {
  // Shaft (TODO: round edges)
  cylinder(d = thumbturn_shaft_diameter, h = thumbturn_shaft_height, $fn = 90);

  // Thumbturn wings (TODO: round edges)
  translate([-thumbturn_length / 2, -thumbturn_wing_width / 2,
             thumbturn_shaft_height - thumbturn_height]) {
    cube([thumbturn_length, thumbturn_wing_width, thumbturn_height]);
  }

  // TODO: render set screw
}
