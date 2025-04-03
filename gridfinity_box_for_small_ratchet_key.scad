/*

Creator
*****************

Constantin Ganshin

Project name:
*****************

gridfinity_box_for_small_ratchet_key

Based on .stl file for gridfinity type box, creted using https://gridfinitygenerator.com

Description:
*************    
    Including:
        •	Cutout for horizontal placement of the small ratchet key
        •	Cutout for the small extender that includes the main bit
        •	Cutout for several additional bits that will be placed vertically

*/

use <libraries/polyedge.scad>;

// Resolution variables
$fa = 1;    
$fs = 0.05;

// STL file
gridfinity_box_path = "stl_files/stl_file_name.stl"; //import("/Users/constanting/Downloads/cutout-1-3-5.stl");

// Ratchet key cutout
ratchet_key_length_x = 100;
ratchet_key_width_y = 20;
ratchet_key_depth_z = 20;
ratchet_key_finger_cutout_diameter = 40;

// Extender cutout
extender_length_x = 50;
extender_width_y = 10;
extender_depth_z = 20;
extender_finger_cutout_diameter = 20; // Maybe just make extender_length_x longer instead - but will viggle?????

// Bits cutout (use cylinder(h=20, r=10, $fn=6);)
bits_diameter = 6.35; // ¼-inch
bits_depth_z = 10;

// Calculations