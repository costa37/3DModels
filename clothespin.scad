/*
clothespin
**********************

Finishing instructions:
Should be cut and add connectoris on top of the legs
CutZ = legsZ = 23
Connectors length should be: specialBottomForCuttingLegsZ = 8 = Depth Ratio & size = 8
*/

// The resolution variables:
$fa = 1;
$fs = 0.4;

// Main dimensions
mainBodyX = 230;
mainBodyY = 90;
mainBoxBodyZ = 146;
legsZ = 23;
legThicknessY = 15;
legOneOffsetY = 8; // Distance from y=0 till the start of the first leg
legTwoOffsetY = 45; // Distance from y=0 till the start of 2nd leg
specialBottomForCuttingLegsZ = 8; 
wallThikness = 2;
bottomWallZ = wallThikness + specialBottomForCuttingLegsZ;
mainBodyZ = mainBoxBodyZ + legsZ + bottomWallZ;
distanceBetweenTwoLegsY = legTwoOffsetY - legOneOffsetY - legThicknessY; // = 22

// Main body
difference(){
    cube([mainBodyX,mainBodyY,mainBodyZ]);

    // Top - box hole
    translate([wallThikness, wallThikness, legsZ + bottomWallZ])
        cube([mainBodyX - (wallThikness * 2), mainBodyY - (wallThikness * 2), mainBoxBodyZ * 2]);
    
    // Bottom - 1/3 legs holes (from y=0 till legOne)
    translate([-2, -1, -2])
        cube([mainBodyX * 2, legOneOffsetY + 1, legsZ + 2]);
    
    // Bottom - 2/3 legs holes (between two legs)
    translate([-2, legOneOffsetY + legThicknessY, -2])
        cube([mainBodyX * 2, distanceBetweenTwoLegsY, legsZ + 2]);

    // Bottom - 3/3 legs holes (from legTwo till the edge)
    translate([-2, legTwoOffsetY + legThicknessY, -2])
        cube([mainBodyX * 2, legTwoOffsetY * 2, legsZ + 2]);
}