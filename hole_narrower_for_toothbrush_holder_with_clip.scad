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
current_walls_thickness = 0.5; // Thickness of current walls
holeForToothbrushD = 19;
protection_factor = 0.1;

// Calculations
gap_between_hole_and_wall_z = (toothbrushHolderLengthWidth / 2) - (holeForToothbrushD / 2); // 1st narrower
standart_narrower_z = (holeForToothbrushD + gap_between_hole_and_wall_z) / 6; // standart narrower
cube_enlargment_by = current_walls_thickness + protection_factor;

// Main
module hole_narrower(hole_narrower_width_z){
    difference(){
        // Body
        cube([original_plate_thickness + (cube_enlargment_by * 2), toothbrushHolderLengthWidth + (cube_enlargment_by * 2), hole_narrower_width_z]);

        // Hole
        translate([current_walls_thickness, current_walls_thickness, -1])
            cube([original_plate_thickness + (protection_factor * 2), toothbrushHolderLengthWidth + (protection_factor * 2), hole_narrower_width_z + 2]);
    }
}

// Generate the toothbrush holder with clip
// hole_narrower(gap_between_hole_and_wall_z);
hole_narrower(standart_narrower_z);
