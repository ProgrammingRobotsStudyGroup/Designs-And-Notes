include <MCAD/units.scad>

$fs = .05;
$fa = 1;

showIRSensorLocations = false;
includeMotorCutouts = true;

baseDiameter = 9*inch;
cutoutWidth = 13/16*inch;
cutoutHeight = 2.25*inch;

module smallRectangle() {
  translate([9/2*inch - .5*inch, -1, 0])
  square(size=[.4*inch, 2]);
}

difference() {
  circle(d=baseDiameter);
  
  if (showIRSensorLocations) {
    for (a = [0 : 45 : 359]) {
      rotate(a) smallRectangle();
    }
  }
  
  if (includeMotorCutouts) {
    translate([baseDiameter/2 - cutoutWidth, -cutoutHeight/2, 0])
    square(size=[cutoutWidth, cutoutHeight]);
    
    translate([-baseDiameter/2, -cutoutHeight/2, 0])
    square(size=[cutoutWidth, cutoutHeight]);
  }
}

