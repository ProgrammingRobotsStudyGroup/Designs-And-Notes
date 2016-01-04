$fs=.1;
$fa = 3;

inch = 25.4;

showWalls = false;
showSquare = false;

showMode = "all"; // "all" or "base" or "top"

motorWidth = 12;
motorHeight = 10;
motorLength = 24;
motorShaftLength = 10;
motorShaftWidth = 3;
motorBackShaftLength = 6.2;
motorBackShaftWidth = 1;

encoderDiskWidth = 2;
encoderDiskDiameter = 7.65;

wheelDiameter = 40;
wheelRadius = wheelDiameter/2;
wheelWidth = 7;
wheelSlotMargin = 3;

// IR sensor
irBodyWidth = 29.5;
irBodyHeight = 13;
irBodyDepth = 13.5;
irMountingHoleOutsideRadius = 3.75;
irTotalWidth = irBodyWidth + 4*irMountingHoleOutsideRadius;
emitterDetectorHeight = 7.2;

// IR bracket
irBracketMountingHoleHeight = 42.7 - 37;
irVerticalOffset = irBracketMountingHoleHeight - irMountingHoleOutsideRadius;
irBracketHeight = 46.4;

irBracketThickness = 0.8;
irBracketDepth = 10.7;
irBracketWidth = 13;

// Tenergy 7.2V LiPo
batteryLength = 2.69 * inch;
batteryWidth = 1.45 * inch;
batteryHeight = 0.7 * inch;

// Tenergy 7.2V NiMH
batteryLength = 2 * inch;
batteryWidth = 1.75 * inch;
batteryHeight = 1.2 * inch;

// Pololu 7.2V NiMH
//batteryLength = 51;
//batteryWidth = 43;
//batteryHeight = 29;

// 6xAA battery holder
//batteryLength = 29;
//batteryWidth = 58;
//batteryHeight = 48;

// Base and top
baseDiameter = 120;
baseRadius = baseDiameter/2;
baseThickness = 1/8 * inch;
baseVerticalOffset = wheelRadius - motorHeight/2 - baseThickness;
baseDeckHeight = baseVerticalOffset + baseThickness;

topBottomMargin = 5;
topVerticalOffset = baseDeckHeight + irBracketHeight + topBottomMargin;
topDeckHeight = topVerticalOffset + baseThickness;

echo((topDeckHeight - baseDeckHeight) / inch);

wheelDisplacement = sqrt(baseRadius*baseRadius - wheelRadius*wheelRadius);

motorAssemblyLength = motorBackShaftLength + motorLength + motorShaftLength;

// Ball caster
casterBallDiameter = 3/8 * inch;
casterTotalHeight = 0.4 * inch;
casterTotalDiameter = 0.5 * inch;
casterBallVerticalOffset = casterTotalHeight - casterBallDiameter;
casterOffset = baseRadius - casterTotalDiameter/2 - 5;

// Raspberry Pi
rpiWidth = 56;
rpiLength = 85.6;
rpiHeight = 21;
rpiVerticalOffset = 0.25 * inch;

module motor() {
  // Back shaft
  rotate([0, 90, 0])
  color("silver", 0.8)
  cylinder(d=motorBackShaftWidth, h=motorBackShaftLength);
  
  // The motor
  translate([motorBackShaftLength, -motorWidth/2, -motorHeight/2])
  color("gray", 0.8)
  cube(size=[motorLength, motorWidth, motorHeight]);
  
  // Front shaft.
  translate([motorBackShaftLength+motorLength, 0, 0])
  rotate([0, 90, 0])
  color("silver", 0.8)
  cylinder(d=motorShaftWidth, h=motorShaftLength);
  
  // Encoder disk.
  rotate([0, 90, 0])
  color("black", 0.8)
  cylinder(d=encoderDiskDiameter, h=encoderDiskWidth);
  
  // The wheel.
  translate([motorBackShaftLength+motorLength+motorShaftLength-wheelWidth, 0, 0])
  color("lightBlue", 0.8)
  wheel();

}

module wheel() {
  rotate([0, 90, 0])
  cylinder(d=wheelDiameter, h=wheelWidth);
}

module robotBase() {
  // The robot base.
  difference() {
    cylinder(d=baseDiameter, h=baseThickness);
    
    translate([wheelDisplacement - wheelWidth - wheelSlotMargin, -(wheelSlotMargin + wheelRadius), -1])
    cube(size=[4*wheelWidth, 2*wheelSlotMargin + wheelDiameter, baseThickness+2]);
    
    translate([-(wheelDisplacement + 4*wheelWidth) + wheelWidth + wheelSlotMargin, -(wheelSlotMargin + wheelRadius), -1])
    cube(size=[4*wheelWidth, 2*wheelSlotMargin + wheelDiameter, baseThickness+2]);
  }
}

module robotTop() {
  cylinder(d=baseDiameter, h=baseThickness);
}

module batteryCube() {
  translate([0, 0, batteryHeight/2])
  cube(size=[batteryWidth, batteryLength, batteryHeight], center=true);
}

module ir() {
  mountingHoleSeparation = 37;
  mountingHoleOutsideRadius = irMountingHoleOutsideRadius;
  mountingHoleOutsideDiameter = 2*mountingHoleOutsideRadius;
  mountingHoleInsideDiameter = 3.2;
  mountingHoleThickness = 2;
  
  bodyWidth = irBodyWidth;
  bodyHeight = irBodyHeight;
  bodyDepth = irBodyDepth;
  bodyStepHeight = 8.4;
  emitterDetectorDepth = 2;
  bodyStepDepth = 6.3 - emitterDetectorDepth;
  bodyMainDepth = bodyDepth - bodyStepDepth - emitterDetectorDepth;
  
  emitterWidth = 7.5;
  emitterDetectorSeparation = 4.15;
  detectorWidth = 16.3;
  
  connectorWidth = 10.1;
  connectorDepth = 1.2;
  connectorHeight = 18.9 - bodyHeight;
  connectorOffset = 3.3;

  translate([0, 0, bodyHeight/2]) {
    color("darkGray", 0.8)
    translate([0, bodyMainDepth/2, 0])
    cube(size=[bodyWidth, bodyMainDepth, bodyHeight], center=true);
    
    color("darkGray", 0.8)
    translate([0, bodyMainDepth + bodyStepDepth/2, 0])
    cube(size=[bodyWidth, bodyStepDepth, bodyStepHeight], center=true);
    
    color("darkGray", 0.8)
    translate([0, bodyMainDepth + bodyStepDepth + emitterDetectorDepth/2], center=true)
    union() {
      translate([-bodyWidth/2 + emitterWidth/2, 0, 0])
      cube(size=[emitterWidth, emitterDetectorDepth, emitterDetectorHeight], center=true);
      
      translate([bodyWidth/2 - detectorWidth/2, 0, 0])
      cube(size=[detectorWidth, emitterDetectorDepth, emitterDetectorHeight], center=true);
    }
    
    color("white", 0.8)  
    translate([0, connectorDepth/2 + connectorOffset, connectorHeight/2 + bodyHeight/2])
    cube(size=[connectorWidth, connectorDepth, connectorHeight], center=true);
  }
  
  module mountingEar() {
    rotate([-90, 0, 0])
    linear_extrude(height=mountingHoleThickness) {
      difference() {
        union() {
          translate([mountingHoleOutsideRadius/2, 0, 0])
          square(size=[mountingHoleOutsideRadius, mountingHoleOutsideDiameter], center=true);
          
          translate([mountingHoleOutsideRadius, 0, 0])
          circle(d=mountingHoleOutsideDiameter);
        }
        
        translate([mountingHoleOutsideRadius, 0, 0])
        circle(d=mountingHoleInsideDiameter);
      }
    }
  }
  
  color("darkGray", 0.8)
  translate([bodyWidth/2, 0, bodyHeight/2])
  mountingEar();
  
  color("darkGray", 0.8)
  translate([-bodyWidth/2, mountingHoleThickness, bodyHeight/2])
  rotate([0, 0, 180])
  mountingEar();
}

module base() {
  color("gray", 0.4)
  translate([0, 0, baseVerticalOffset])
  robotBase();
}

module top() {
  color("gray", 0.4)
  translate([0, 0, topVerticalOffset])
  robotTop();
}

module motors() {
  translate([wheelDisplacement - motorAssemblyLength, 0, wheelRadius])
  motor();
  
  translate([-(wheelDisplacement - motorAssemblyLength), 0, wheelRadius])
  rotate([0, 0, 180])
  motor();
}

// Battery
module battery() {
  color("lightGreen", 1.0)
  translate([0, -32, baseDeckHeight])
  rotate([0, 0, 90])
  batteryCube();
}

// IR sensors

module verticalIRBracket() {
  color("silver", 0.8)
  translate([-irBracketWidth/2, -irBracketThickness, 0])
  cube(size=[irBracketWidth, irBracketThickness, irBracketHeight]);
  
  color("silver", 0.8)
  translate([-irBracketWidth/2, -irBracketDepth, 0])
  cube(size=[irBracketWidth, irBracketDepth, irBracketThickness]);
}

module verticalIRLeft() {
  translate([irBodyHeight/2, 0, irTotalWidth/2 + irVerticalOffset])
  rotate([0, -90, 0])
  ir();
  verticalIRBracket();
}

module verticalIRRight() {
  translate([-irBodyHeight/2, 0, irTotalWidth/2 + irVerticalOffset])
  rotate([0, 90, 0])
  ir();
  verticalIRBracket();
}

irOffset = sqrt(baseRadius*baseRadius - emitterDetectorHeight*emitterDetectorHeight/4)
    - irBodyDepth - 10;

centerIROffset = sqrt(baseRadius*baseRadius - emitterDetectorHeight*emitterDetectorHeight/4) - irBodyDepth;

//translate([0, centerIROffset, baseDeckHeight + irVerticalOffset])
//verticalIRRight();

module sensors() {
  for (angle = [0, 90, 270]) {
    rotate([0, 0, angle])
    translate([-20, irOffset, baseDeckHeight])
    rotate([0, 0, 15])
    verticalIRRight();
  }
  
  for (angle = [0, -90, -270]) {
    rotate([0, 0, angle])
    translate([20, irOffset, baseDeckHeight])
    rotate([0, 0, -15])
    verticalIRLeft();
  }
}

module caster() {
  translate([0, 0, casterBallDiameter/2])
  color("darkGray", 0.8)
  cylinder(d=casterTotalDiameter, h=casterTotalHeight - casterBallDiameter/2);
  
  translate([0, 0, casterBallDiameter/2])
  color("white")
  sphere(d=casterBallDiameter);
}

// Casters
module casters() {
  translate([0, -casterOffset, 0])
  caster();
  
  translate([0, casterOffset, 0])
  caster();
}

// One maze square
module mazeSquare() {
  color("orange", 0.8)
  translate([0, 0, -1/2])
  cube(size=[180, 180, 1], center=true);
}

// Raspberry Pi
module raspberryPi() {
  color("orange", 0.3)
  translate([0, -10, topDeckHeight + rpiHeight/2 + rpiVerticalOffset])
  cube(size=[rpiWidth, rpiLength, rpiHeight], center=true);
}

// Maze walls
module wall() {
  wallWidth = 12;
  wallHeight = 50;
  translate([0, 0, wallHeight/2])
  cube(size=[wallWidth, 180, wallHeight], center=true);
}

module walls() {
  %translate([180/2, 0, 0])
  wall();
  
  %translate([0, -180/2, 0])
  rotate([0, 0, 90])
  wall();
  
  %translate([-180/2, 0, 0])
  wall();
}

if (showMode == "base") {
  projection()
  base();
} else if (showMode == "top") {
  projection()
  top();
} else {
  base();
  motors();
  battery();
  casters();
  sensors();
  
  top();
  raspberryPi();
  
  if (showSquare) {
    mazeSquare();
  }
  if (showWalls) {
    walls();
  }
}

