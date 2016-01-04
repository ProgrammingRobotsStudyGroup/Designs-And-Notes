include <MCAD/units.scad>

$fs = .1;
$fa = 3;

// From the Pololu product page: https://www.pololu.com/product/2474
sensorWidth = 0.41*inch;
sensorLength = 1.3*inch;
sensorThickness = 1/16*inch;
sensorHoleOffset = (1.3 - 1.15)*inch;

// Width across flats for 4-40 hex nut.
// From https://www.boltdepot.com/Product-Details.aspx?product=2536
hexNutWidth = 0.25*inch;

// A hex nut.
hexNutDiameter = 2 * hexNutWidth / sqrt(3);
hexNutHeight = 3/32*inch;

// 4-40 mchine screw hole size.
// From http://www.vaillyaviation.com/images/Hole%20sizes%20for%20screws%20_new_.pdf
machineScrewHoleDiameter = 1/8*inch + 1*mm;

// The height of the head of a pan-head screw, approx.
screwHeadHeight = 0.070*inch;

// Additional space above the screw head before any other fastener;
screwHeadClearance = 1;

// #4 wood screw hole size, to completely accommodate the shank.
// From https://www.pinterest.com/pin/465489311460176894/
woodScrewHoleDiameter = (7/64 + 0.060)*inch;
woodScrewHeadDiameter = 15/64*inch;

// Minimum amount of material for a base.
minMaterialThickness = 2.5;

// Minimum amount of material around a hole.
minHoleMargin = 3;

bracketWidth = sensorWidth;
mountingTabLength = max(minHoleMargin, hexNutHeight+1) + woodScrewHeadDiameter/2 + woodScrewHoleDiameter/2 + minHoleMargin;
sensorTabLength = 1 + hexNutWidth/2 + machineScrewHoleDiameter/2 + minHoleMargin;

mountingHoleX = minMaterialThickness + mountingTabLength - minHoleMargin - woodScrewHoleDiameter/2;

sensorScrewX = minMaterialThickness + sensorTabLength - minHoleMargin - machineScrewHoleDiameter/2;

maxModelDimension = 50;

module hole(x, y, d) {
  translate([x, y, 0])
  cylinder(d=d, h=2*maxModelDimension, center=true);
}

module part() {
// The mounting tab.
translate([minMaterialThickness, 0, 0])
rotate([0, -90, 0]) {
  difference() {
    cube(size=[minMaterialThickness + mountingTabLength, bracketWidth, minMaterialThickness]);
    hole(x=mountingHoleX, y=bracketWidth/2, d=woodScrewHoleDiameter);
  }
  
  // Sample screw head.
  %translate([mountingHoleX, bracketWidth/2, -screwHeadHeight])
  cylinder(d=woodScrewHeadDiameter, h=screwHeadHeight);
}

// The sensor tab.
difference() {
  cube(size=[minMaterialThickness + sensorTabLength, bracketWidth, minMaterialThickness]);
  hole(x=sensorScrewX, y=bracketWidth/2, d=machineScrewHoleDiameter);
}

// Sample hex nut.
%translate([sensorScrewX, bracketWidth/2, minMaterialThickness])
rotate(30)
difference() {
  cylinder(d=hexNutDiameter, h=hexNutHeight, $fn=6);
  hole(x=0, y=0, d=machineScrewHoleDiameter);
}

// The sensor board.
%translate([sensorScrewX - sensorHoleOffset, 0, -sensorThickness])
cube(size=[sensorLength, sensorWidth, sensorThickness]);
}

part();

translate([0, 12, 0])
part();

translate([-14, 0, 0])
part();

translate([-14, 12, 0])
part();

translate([0, -12, 0])
part();