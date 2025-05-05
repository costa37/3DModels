/*
Creator
*****************
Constantin Ganshin

Project name:
*****************
Tooth_brush_Holder_With_Clip_V2

Description:
****************************************

With square toothbrush holder and a clip that intent to be on top of metal frame of the shampoo holder

            -----------------|----------|----
            |         |            
            |         |
            |         |
            |         |
            |         |
            |         |
            |         |
            |         |
            |         |
            |         |
            |         |


*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Main dimension variables

hightZ = 43;
holderGapX = 5; //The place that will on top of the metal bar
toothbrushHolderLengthWidth = 30;
wallThikness = 2;
holeForToothbrushD = 19;
clip_opennig_gap_x = holderGapX - 3;
fullBodyLengthX = (wallThikness * 2) + holderGapX + toothbrushHolderLengthWidth;
holeForToothbrushR = holeForToothbrushD / 2;

// Main

module toothbrushHolderWithClip(){
    difference(){
        cube([fullBodyLengthX, toothbrushHolderLengthWidth, hightZ]);

        // Clip
        translate([wallThikness, -1, wallThikness])
            cube([holderGapX, toothbrushHolderLengthWidth * 2, hightZ - (wallThikness * 2)]);
        
        // Clip openning gap
        translate([wallThikness, -1, hightZ - (wallThikness * 2) -1])
            cube([clip_opennig_gap_x, toothbrushHolderLengthWidth + 2, (wallThikness * 2) + 2]);

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