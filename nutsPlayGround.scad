use <libraries/threads-library-by-cuiso-v1.scad>;

/*

nutsPlayGround
****************************************

*/

// Resolution variables
$fa = 1;    
$fs = 0.05;

// difference(){
//     cylinder(d=21, h=20);
//     translate([0, 0, 20 - 6])
//         thread_for_nut_fullparm(diameter=18.90, length=6, pitch=0.5);
// }

difference(){
    cylinder(d=20, h=20);
    translate([0, 0, -2])
        cylinder(d=15, h=14);
    translate([0, 0, 10])
        cylinder(d=14, h=2);
    translate([0, 0, 12])
        thread_for_nut_fullparm(diameter=17, length=12, pitch=0.5);
}
