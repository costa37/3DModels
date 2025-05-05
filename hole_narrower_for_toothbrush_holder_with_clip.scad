/*

Creator
*****************

Constantin Ganshin

Project name:
*****************
hole_narrower_for_toothbrush_holder_with_clip

Description:
****************************************
Making the hole for toothbrush (the tothbrash holder) adjustable, designed for Tooth_brush_Holder_With_Clip_V2.scad and Tooth_brush_Holder_With_Clip.scad

Printed in PETG (for water resistance)

*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Main dimension variables
toothbrushHolderLengthWidth = 30;
original_plate_thickness = 2; // Thickness of the original plate/wall
current_walls_thickness = 1; // Thickness of current walls
holeForToothbrushD = 19;
protection_factor_final = 0.10; // This is the currect protection factor

// Calculations
gap_between_hole_and_wall_z = ((toothbrushHolderLengthWidth / 2) - (holeForToothbrushD / 2)) * 1.5; // narrower could have been just ~5/6 (without any calculations)

// Main
module hole_narrower(protection_factor){
    additional_cube_thickness = current_walls_thickness + protection_factor;
    difference(){
        // Body
        cube([original_plate_thickness + (additional_cube_thickness * 2), toothbrushHolderLengthWidth + (additional_cube_thickness * 2), gap_between_hole_and_wall_z]);

        // Hole
        translate([current_walls_thickness, current_walls_thickness, -1])
            cube([original_plate_thickness + (protection_factor * 2), toothbrushHolderLengthWidth + (protection_factor * 2), gap_between_hole_and_wall_z + 2]);
    }
}

// Generate the module
hole_narrower(protection_factor_final);
