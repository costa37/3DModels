use <libraries/polyedge.scad>;

/*

playGround
****************************************

*/

// Resolution variables
$fa = 1;    
$fs = 0.05;

// STL file
gridfinity_box_path = "stl_files/gridfinity_solid_3x1x4_box.stl"; 
gridfinity_box_x = 126;
gridfinity_box_y = 42;gridfinity_box_z = 32.4 - 4.4 + 0.2; //Max cutout 21mm

// Ratchet key cutout
ratchet_key_length_x = 103;
ratchet_key_width_y = 10;
ratchet_key_depth_z = 15;
ratchet_key_start_x = 11;
ratchet_key_start_y = gridfinity_box_y - ratchet_key_width_y - 14;

// Cutout for the fingers
fingers_cutout_length_x = 15 / 2;
fingers_cutout_width_y = ratchet_key_width_y + 18;
fingers_cutout_depth_z = 8;
fingers_cutout_start_x = ratchet_key_length_x / 2;
fingers_cutout_start_y = ratchet_key_start_y - 10;

// Bits cutout (use cylinder(h=20, r=10, $fn=6);)
bits_diameter = 7.6; // ¼-inch (tested)
bits_depth_z = 9;
bits_start_y = fingers_cutout_start_y + 2;

// difference() {
//         // Importing the STL file
//         // translate([63, 42 / 2, 0])
//             import(gridfinity_box_path);

//         // Ratchet key cutout
//         translate([ratchet_key_start_x, ratchet_key_start_y, gridfinity_box_z - ratchet_key_depth_z])
//             cube([ratchet_key_length_x, ratchet_key_width_y, ratchet_key_depth_z]);
// }

difference(){
    import(gridfinity_box_path);
    #cube([5, 5, gridfinity_box_z + 2]);
}
