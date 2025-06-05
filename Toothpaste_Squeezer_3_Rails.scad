/*

Creator
*****************
Constantin Ganshin

Project name:
*****************
Toothpaste_Squeezer_3_Rails

V2: Removed 2 of the slots and making it more wide

Description:

    Toothpaste squeezer with 1 open spaces for folding the toothpaste tube into 1
                                  
             -----------------------------
            |                             |
            |     |
            |                             |
            |  ************************   |
            |                             |
            |    |
            |                             |
             -----------------------------                   
*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Toothpaste Squeezer Configuration
cube_width_x = 77;
cube_height_y = 15;
cube_depth_z = 6;

slot_width_x = 65;  
slot_hight_y = 0.78;
slot_padding_sides_x = (cube_width_x - slot_width_x) / 2;
slot_padding_top_buttom_y = 5;

side_slot_width_x = 1;
side_slot_hight_y = 6;

slot_spacing_y = (cube_height_y - (2 * slot_padding_top_buttom_y)) / 3 + 3;  // spacing between openings
echo(str("slot_spacing_y = ", slot_spacing_y));

module toothpaste_squeezer() {
    difference() {
        minkowski(){
            cube([cube_width_x, cube_height_y, cube_depth_z]); // Base cube
            sphere(2);
        }
        for (i = [0:0]){
            translate([slot_padding_sides_x, slot_padding_top_buttom_y + (slot_spacing_y * i), -2])
                cube([side_slot_width_x, side_slot_hight_y, cube_depth_z + 4]); // Side slot left
            translate([slot_padding_sides_x + side_slot_width_x, slot_padding_top_buttom_y + (side_slot_hight_y / 2) - (slot_hight_y/2) + (slot_spacing_y * i), -2])
                cube([slot_width_x, slot_hight_y, cube_depth_z + 4]); // Main slot
            translate([slot_padding_sides_x + side_slot_width_x + slot_width_x, slot_padding_top_buttom_y + (slot_spacing_y * i), -2])
                cube([side_slot_width_x, side_slot_hight_y, cube_depth_z + 4]); // Side slot right    
        }
    }
}

toothpaste_squeezer();