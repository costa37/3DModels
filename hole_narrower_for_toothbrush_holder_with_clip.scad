/*

Creator
*****************

Constantin Ganshin

Project name:
*****************
hole_narrower_for_toothbrush_holder_with_clip

*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Main dimension variables
toothbrushHolderLengthWidth = 30;
original_plate_thickness = 2; // Thickness of the original plate/wall
current_walls_thickness = 1; // Thickness of current walls
holeForToothbrushD = 19;
protection_factor_final = 0.17; // This is probably the c urrect protection factor
protection_factor_1 = 0.17;
protection_factor_2 = 0.15;
protection_factor_3 = 0.13;

// Calculations
gap_between_hole_and_wall_z = (toothbrushHolderLengthWidth / 2) - (holeForToothbrushD / 2); // narrower could have been just ~5/6 (without any calculations)

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

// Generate the toothbrush holder with clip
for(j = [0:1]){
    translate([0, j * toothbrushHolderLengthWidth * 1.2, 0])
        hole_narrower(protection_factor_1);
    translate([8, j * toothbrushHolderLengthWidth * 1.2, 0])
        hole_narrower(protection_factor_2);
    translate([16, j * toothbrushHolderLengthWidth * 1.2, 0])
    hole_narrower(protection_factor_3);         
}    

// hole_narrower(protection_factor_final);
