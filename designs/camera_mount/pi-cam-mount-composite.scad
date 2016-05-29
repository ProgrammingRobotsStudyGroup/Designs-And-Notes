$fa = 3;
$fs = .5;

inch = 25.4;

hexNutWidthAcrossFlats = 1/4 * inch;
hexNutDiameter = 2 * hexNutWidthAcrossFlats/2 / sqrt(3) * 2;
hexNutHeight = 1/8 * inch;
hexNutHoleDiameter = 0.112 * inch;

module hexNut() {
  difference() {
    cylinder(h=hexNutHeight, d=hexNutDiameter, center=true, $fn=6);
  
    roundHole(radius = hexNutHoleDiameter/2);
  }
}

module squareHole(dx, dy) {
  cube(size=[dx, dy, 100], center=true);
}

module roundHole(radius) {
  cylinder(h=100, r=radius, center=true);
}

module grid(dx, dy, nx, ny) {
  for (i = [0:nx-1]) {
    for (j = [0:ny-1]) {
      x = i*dx;
      y = j*dy;
      translate([x, y, 0])
        children();
    }
  }
}

// Case front
union() {
  import("raspberri_pi_camera_case_front_v0.4.2.STL");

  translate([1.5/2 + 30 - 1.7, -.7, 3])
  rotate([0, 90, 0])
  rotate([0, 0, -90])
  union() {
    difference() {
      union() {
        translate([-6.5, -7, -1.5/2])
        cube(size=[10, 10, 1.5]);
        translate([3.5, -2, 0])
        cylinder(h=1.5, r=5, center=true);
      }
      
      translate([3.5, -2, 0])
      roundHole(radius=1.5);
    }
  }
    
  translate([1.5/2, -.7, 3])
  rotate([0, 90, 0])
  rotate([0, 0, -90])
  union() {
    difference() {
      union() {
        translate([-6.5, -7, -1.5/2])
        cube(size=[10, 10, 1.5]);
        translate([3.5, -2, 0])
        cylinder(h=1.5, r=5, center=true);
      }
      
      translate([3.5, -2, 0])
      roundHole(radius=1.5);
    }
    
    %translate([3.5, -2, hexNutHeight/2 + 1.5/2])
    rotate([0, 0, 30])
    hexNut();
  }
}

// Case back
translate([0, -40, 0])
difference() {
  import("raspberri_pi_camera_case_back_v0.4.STL");
  
  translate([6.5, 6, 0])
  grid(5.5, 5.5, 4, 4) {
  squareHole(3, 3);
  }
}

module support() {
  translate([0, 1, 0])
  rotate([90, 0, 0])
  linear_extrude(height=1.5)
  polygon([[0, 0], [10, 0], [0, 10]]);
}

// Stand
module stand() {
  translate([0, 0, 1])
  union () {
    translate([0, 0, -1])
    linear_extrude(height=2) {
      polygon([[2,0], [2,-8], [20,-5], [20,5], [2,8]]);
    }
    
    translate([1, 0, .5])
    rotate([0, 90, 0])
    cylinder(h=40, r=1.5);
    
    translate([30, 0, 0])
    difference() {
      union() {
        cube(size=[60, 10, 2], center=true);
        
        translate([30, 0, 0])
        cylinder(h=2, r=5, center=true);
      }
      
      translate([23, 0, 0])
      union() {
        cube(size=[15, 3, 100], center=true);
    
        translate([-7.5, 0, 0])
        cylinder(d=3, h=100, center=true);
        
        translate([7.5, 0, 0])
        cylinder(d=3, h=100, center=true);
      }
    }
    
    translate([1, 0, 6.5])
    rotate([0, 90, 0])
    difference() {
      cube(size=[15, 16, 2], center=true);
      
      cube(size=[6, 3, 100], center=true);
      translate([-3, 0, 0])
      cylinder(d=3, h=100, center=true);
      translate([3, 0, 0])
      cylinder(d=3, h=100, center=true);
    }
    
    translate([2, 5, 1])
    support();
    
    translate([2, -5.5, 1])
    support();
  }
}

translate([0, -50, 0])
stand();

translate([0, -70, 0])
stand();