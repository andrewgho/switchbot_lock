include <spindle.scad>
include <thumbturn.scad>

// Measurements of SwitchBot Lock unit and parts
switchbot_top_width      =  58.3;  // width at top (bottom measures 58.0)
switchbot_top_depth      =  59.0;  // depth from front surface to rear top
switchbot_padded_depth   =  61.6;  // depth including adhesive pad and plate
switchbot_top_height     =  54.0;  // height of the top overhang only
switchbot_total_height   = 111.8;  // total height including bottom portion
switchbot_bottom_depth   =  21.7;  // from front surface to rear bottom
switchbot_plate_depth    =  35.8;  // from front surface to spindle plate rear
switchbot_plate_bottom_y = 101.4;  // from top to the bottom of spindle plate

// Measurements of Marvin backplate and parts
backplate_width          =  50.5;
backplate_depth          =  10.7;
backplate_total_height   = 240;    // (approximate/irrelevant) backplate height
backplate_screw_y        =  14.8;  // distance from top to center of screw
backplate_screw_diameter =   8.0;
thumbturn_bottom_y       =  72.3;  // from backplate top to bottom of thumbturn

// Approximate measurements between door, backplate, and SwitchBot Lock unit
switchbot_front_to_door_depth = 18.5;
switchbot_front_to_backplate_depth = 7.5;
switchbot_top_to_backplate_top = 17.5;

switchbot_center_x = switchbot_top_width / 2;
spindle_center_z =
  (switchbot_total_height - switchbot_plate_bottom_y) + (spindle_diameter / 2);

module switchbot() {
  translate([-switchbot_top_width / 2, 0, 0]) {
    translate([0, 0, switchbot_total_height - switchbot_top_height]) {
      cube([switchbot_top_width, switchbot_top_depth, switchbot_top_height]);
    }
    cube([switchbot_top_width, switchbot_bottom_depth, switchbot_total_height]);
    translate([switchbot_center_x,
               switchbot_plate_depth - spindle_height,
               spindle_center_z]) {
      rotate(90, [-1, 0, 0]) spindle();
    }
  }
}

module phillips_screwhead() {
  screw_head_depth = 0.75;
  screw_protrusion = 1.5;
  screw_drive_depth = 0.8 * screw_head_depth;
  screw_drive_length = 0.7 * backplate_screw_diameter;
  screw_drive_width = 1;
  e = 0.1;
  difference() {
    union() {
      cylinder(d1 = 0.92 * backplate_screw_diameter,
               d2 = backplate_screw_diameter,
               h = screw_protrusion - screw_head_depth);
      translate([0, 0, screw_protrusion - screw_head_depth]) {
        cylinder(d = backplate_screw_diameter, h = screw_head_depth);
      }
    }
    rotate(45, [0, 0, 1]) {
     translate([0, 0, screw_protrusion - (screw_drive_depth / 2)]) {
        cube([screw_drive_length, screw_drive_width, screw_drive_depth + e],
             center = true);
        cube([screw_drive_width, screw_drive_length, screw_drive_depth + e],
             center = true);
      }
    }
  }
}

module backplate() {
  translate([-backplate_width / 2, 0, backplate_width / 2]) {
    hull() {
      // Top round off
      translate([backplate_width / 2, 0,
                 backplate_total_height - backplate_width]) {
        rotate(90, [-1, 0, 0]) {
          cylinder(d = backplate_width, h = backplate_depth);
        }
      }
      // Bottom round off
      translate([backplate_width / 2, 0, 0]) {
        rotate(90, [-1, 0, 0]) {
          cylinder(d = backplate_width, h = backplate_depth);
        }
      }
    }
  }
  translate([0, 0, backplate_total_height - backplate_screw_y]) {
    rotate(90, [1, 0, 0]) phillips_screwhead();
  }
  translate([0, 0, backplate_total_height - thumbturn_bottom_y]) {
    rotate(90, [0, 1, 0]) rotate(90, [1, 0, 0]) thumbturn();
  }
}

translate([0, -(switchbot_padded_depth + switchbot_front_to_backplate_depth),
           switchbot_top_to_backplate_top - switchbot_total_height])
  #switchbot();

translate([0, 0, -backplate_total_height]) backplate();
