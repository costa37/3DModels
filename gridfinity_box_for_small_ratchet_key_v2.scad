/*

Creator
*****************

Constantin Ganshin

Project name:
*****************

gridfinity_box_for_small_ratchet_key_v2
    Note: V2: Extender place changed to vertical orientation similar to bits
              The base gridfinity box change to smaller size 3x1

Based on .stl file for gridfinity type box, creted using https://gridfinity.perplexinglabs.com/

Description:
*************    
    Including:
        •	Cutout for horizontal placement of the small ratchet key
        •	Cutout for the small extender that includes the main bit
        •	Cutout for several additional bits that will be placed vertically

*/

// Resolution variables
$fa = 1;    
$fs = 0.05;

// STL file
gridfinity_box_path = "stl_files/gridfinity_solid_3x1x4_box.stl"; 
gridfinity_box_x = 125.5;
gridfinity_box_y = 41.5;
gridfinity_box_z = 28.0;

// Ratchet key actual measurements
ratchet_key_actual_length_x = 103; // TODO: update the numbers
ratchet_key_actual_width_y = 10; // TODO: update the numbers
ratchet_key_actual_depth_z = 15; // TODO: update the numbers

// Ratchet key cutout
ratchet_key_length_x = 103;
ratchet_key_width_y = 10;
ratchet_key_depth_z = 15;
ratchet_key_start_x = 11;
ratchet_key_start_y = gridfinity_box_y - ratchet_key_width_y - 14;

// Cutout for the fingers
fingers_cutout_width_x = 20;
fingers_cutout_length_y = ratchet_key_width_y + 21;
fingers_cutout_depth_z = ratchet_key_depth_z / 2;
fingers_cutout_start_x = ratchet_key_length_x / 2;
fingers_cutout_start_y = ratchet_key_start_y - 12;

// Bits cutout (use cylinder(h=20, r=10, $fn=6);)
bits_diameter = 7.6; // ¼-inch (tested)
bits_depth_z = 9;
bits_start_y = fingers_cutout_start_y + 2;

module gridfinity_box_for_small_ratchet_key() {
    difference() {
        // Importing the STL file
        translate([gridfinity_box_x / 2, gridfinity_box_y / 2, 0])
            rotate(90)
                import(gridfinity_box_path);
        union(){
            // Ratchet key cutout
            translate([ratchet_key_start_x, ratchet_key_start_y, gridfinity_box_z - ratchet_key_depth_z])
            minkowski(){ // For making rounded corners
                cube([ratchet_key_length_x, ratchet_key_width_y, ratchet_key_depth_z + 1]);
                sphere(2);
            }
            
        // Cutout for the fingers
        translate([fingers_cutout_start_x, fingers_cutout_start_y, gridfinity_box_z - fingers_cutout_depth_z])
            minkowski(){
                cube([fingers_cutout_width_x, fingers_cutout_length_y, fingers_cutout_depth_z + 1]);
                sphere(2);
            }
        }

        // Bits cutout - part one
        for(i = [1 : 4]){
            translate([ratchet_key_start_x + ((i - 1) * 11), bits_start_y, gridfinity_box_z - bits_depth_z])
                cylinder(h=bits_depth_z + 1, d=bits_diameter, $fn=6);
        }

        // Bits cutout - part two
        for(i = [1 : 4]){
            translate([fingers_cutout_start_x +fingers_cutout_width_x + bits_diameter + ((i - 1) * 11), bits_start_y, gridfinity_box_z - bits_depth_z])
                cylinder(h=bits_depth_z + 1, d=bits_diameter, $fn=6);
        }
        
    }
}

gridfinity_box_for_small_ratchet_key();