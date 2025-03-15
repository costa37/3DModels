// include <threads.scad>;

// nutsPlayGround
// ****************************************

// Resolution variables
$fa = 1;    
$fs = 0.05;

// Nut parameters
nut_diameter = 20;  // Outer diameter of the nut
thread_diameter = 10; // Inner diameter (matches a bolt)
nut_height = 10;    // Nut thickness
thread_pitch = 0.1; //ThreadPitch(thread_diameter); // Auto-detect pitch

// Function to generate a helical thread
module helical_thread(d, pitch, length) {
    // Approximate a helical cut
    for (i = [0:pitch/10:length]) {
        translate([0, 0, i])
        rotate([0, 0, i * 360 / pitch])
        translate([d/2, 0, 0])
        cylinder(d=pitch/2, h=pitch/10, $fn=20);
    }
}

// // Generate threaded nut
// difference() {
//     // Hexagonal nut body
//     cylinder(d=nut_diameter, h=nut_height, $fn=6);
    
//     // Internal threaded hole
//     translate([0, 0, 0])
//     helical_thread(thread_diameter, thread_pitch, nut_height);
// }

module nut(){
    difference() {
        // Hexagonal nut body
        cylinder(d=nut_diameter, h=nut_height, $fn=6);
        
        // Internal threaded hole
        translate([0, 0, 0])
            cylinder(h=nut_height + 2, r=thread_diameter/2);
        translate([0, 0, 0])
        helical_thread(thread_diameter, thread_pitch, nut_height);
    }
}

nut();
