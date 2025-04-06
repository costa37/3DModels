/*

Creator
*****************

Constantin Ganshin

Project name:
*****************

gridfinity_box_for_small_ratchet_key

Based on .stl file for gridfinity type box, creted using 

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
gridfinity_box_path = "stl_files/need_to_add_new_stl_file.stl";
gridfinity_box_x = 126;
gridfinity_box_y = 84;
gridfinity_box_z = 32.4 - 4.4 + 0.2;

// Ratchet key cutout
ratchet_key_length_x = 103;
ratchet_key_width_y = 10;
ratchet_key_depth_z = 15;
ratchet_key_start_y = gridfinity_box_y - ratchet_key_width_y - 17;

// Extender cutout
extender_length_x = 76;
extender_width_y = 10;
extender_depth_z = 8;
extender_start_x = 11 + 7;
extender_start_y = gridfinity_box_y - ratchet_key_width_y - 17 - extender_width_y - 10;

// Cutout for the fingers
fingers_cutout_length_x = 15;
fingers_cutout_width_y = ratchet_key_width_y + extender_width_y + 17 + 15;
fingers_cutout_depth_z = 8;
fingers_cutout_start_y = gridfinity_box_y - (ratchet_key_width_y + extender_width_y + 17 + 15) - 6;

// Bits cutout (use cylinder(h=20, r=10, $fn=6);)
bits_diameter = 7.7; // ¼-inch (tested)
bits_depth_z = 9;

// Calculations


module gridfinity_box_for_small_ratchet_key() {
    difference() {
        // Importing the STL file
        translate([63, 42, 0])
            import(gridfinity_box_path);
        
        // Ratchet key cutout
        translate([11, ratchet_key_start_y - 2 , gridfinity_box_z - ratchet_key_depth_z])
            #minkowski(){ // For making rounded corners
                cube([ratchet_key_length_x, ratchet_key_width_y, ratchet_key_depth_z]);
                sphere(2);
            }
        
        // Extender cutout
        translate([extender_start_x, extender_start_y - 4, gridfinity_box_z - extender_depth_z])
            #minkowski(){
                #cube([extender_length_x, extender_width_y, extender_depth_z]);
                sphere(2);
            }
            
        // Cutout for the fingers
        translate([11 + 7 + (extender_length_x / 2), fingers_cutout_start_y - 4, gridfinity_box_z - fingers_cutout_depth_z])
            #minkowski(){
                #cube([fingers_cutout_length_x, fingers_cutout_width_y + 2, fingers_cutout_depth_z]);
                sphere(2);
            }

        // Bits cutout
        for(i = [1 : 9 ]){
            translate([extender_start_x + ((i - 1) * 11), fingers_cutout_start_y - 14, gridfinity_box_z - bits_depth_z])
                #cylinder(h=bits_depth_z, d=bits_diameter, $fn=6);
        }
        
    }
}


gridfinity_box_for_small_ratchet_key();