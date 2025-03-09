/*
toothbrushHolderWithClip
****************************************

With square toothbrush holder and a clip that intent to be on top of metal frame of the shampoo holder
*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Main dimension variables

hightZ = 40;
holderGapX = 5; //The place that will on top of the metal bar
toothbrushHolderLengthWidth = 20;
wallThikness = 2;
holeForToothbrushD = 13;

// Calculated vareables

fullBodyLengthX = (wallThikness * 2) + holderGapX + toothbrushHolderLengthWidth;
holeForToothbrushR = holeForToothbrushD / 2;

// Main

module toothbrushHolderWithClip(){
    difference(){
        cube([fullBodyLengthX, toothbrushHolderLengthWidth, hightZ]);

        // Clip
        translate([wallThikness, -1, wallThikness])
            cube([holderGapX, toothbrushHolderLengthWidth * 2, hightZ * 2]);

        // Toothbrush holder
        translate([fullBodyLengthX - toothbrushHolderLengthWidth
    , -1, wallThikness])
            cube([toothbrushHolderLengthWidth * 2, toothbrushHolderLengthWidth * 2, hightZ * 2]);

        // Toothbrush holder hole
        translate([fullBodyLengthX - (toothbrushHolderLengthWidth / 2),toothbrushHolderLengthWidth / 2, -1])
            cylinder(r = holeForToothbrushR, h = wallThikness * 2);
    }
}

// Generate the toothbrush holder with clip
toothbrushHolderWithClip();