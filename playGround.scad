use <libraries/polyedge.scad>;

/*

playGround
****************************************

*/

// Resolution variables
$fa = 1;    
$fs = 0.05;

airpods_y = 67;
airpods_z = 13;

charger_x = 110;
charger_y = 67;
charger_z = 26;

magsafe_cutout_d = 56;
magsafe_cutout_z = 5.4;
magsafe_cort_cutout_x = 2;
magsafe_cort_cutout_y = 20;

round_edge_r = 8;
phone_tilt_angle = 5;

module base(){
    minkowski(){
        cube([charger_x, airpods_y, charger_z]);
        sphere(round_edge_r);
    }
}

module design(){
    difference(){
        base();
        translate([0, charger_y / 2, airpods_z / 2])
            rotate([phone_tilt_angle, 0, 0])
                cube([charger_x + round_edge_r + 2, phone_y * 2, charger_z * 4]);
    }
}

design();
