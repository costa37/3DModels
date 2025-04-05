use <libraries/polyedge.scad>;

/*

playGround
****************************************

*/

// Resolution variables
$fa = 1;    
$fs = 0.05;

// Bits cutout (use cylinder(h=20, r=10, $fn=6);)
bits_diameter_1 = 7.5; // ¼-inch
bits_diameter_2 = 8; // ¼-inch
bits_diameter_3 = 8.5; // ¼-inch
bits_depth_z = 9;

difference(){
    cube([10, 10, 10]);
    
    // Bits cutout
        translate([5, 5, 10 - bits_depth_z])
            #cylinder(h=bits_depth_z + 1, d=bits_diameter_1, $fn=6);
}

difference(){
    translate([15, 0, 0])
        cube([10, 10, 10]);
    
    // Bits cutout
        translate([5 + 15, 5, 10 - bits_depth_z])
            #cylinder(h=bits_depth_z + 1, d=bits_diameter_2, $fn=6);
}

difference(){
    translate([30, 0, 0])
        cube([10, 10, 10]);
    
    // Bits cutout
        translate([5 + 30, 5, 10 - bits_depth_z])
            #cylinder(h=bits_depth_z + 1, d=bits_diameter_3, $fn=6);
}