/*

Creator
*****************

Constantin Ganshin

Project name:
*****************
Toothpaste_Squeezer_3_Rails

Description:

    Toothpaste squeezer with 3 open spaces for folding the toothpaste tube into 3
                                  
             -----------------------------
            |                             |
            |  ************************   |
            |                             |
            |  ************************   |
            |                             |
            |  ************************   |
            |                             |
             -----------------------------                   
*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Toothpaste Squeezer Configuration
cube_width = 77;
cube_height = 50;
cube_depth = 5;

slot_width = 65;  
slot_hight = 0.78;
slot_padding_sides = (cube_width - slot_width) / 2;
slot_padding_top_buttom = 10;

side_slot_width = 1;
side_slot_hight = 6;

slot_spacing = (cube_height - (2 * slot_padding_top_buttom)) / 3;  // spacing between openings

module toothpaste_squeezer() {
    difference() {
        // Base cube
        cube([cube_width, cube_depth, cube_height]);

        // Slot through one face (for tube entry)
        translate([0, (cube_depth - slot_depth) / 2, (cube_height - slot_height) / 2])
            cube([cube_width, slot_depth, slot_height]);

        // Create 3 rectangular openings centered in the cube
        for (i = [-1, 0, 1]) {
            translate([
                cube_width / 2 + i * (opening_width + opening_spacing),
                cube_depth / 2 - 0.1,  // slight offset to fully cut
                (cube_height - opening_height) / 2
            ])
                cube([opening_width, cube_depth + 0.2, opening_height]); // 0.2 ensures full cut
        }
    }
}

toothpaste_squeezer();