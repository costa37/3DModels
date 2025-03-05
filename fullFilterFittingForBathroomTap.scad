use <threads.scad>  // Ensure you have this library installed

// Resolution variables
$fa = 1;
$fs = 0.4;

// Main dimension variables
outside_radius = 16.5;
inside_radius = 14;
length = 20;

// Thread settings
threaded_length = 6;  // Only 6mm of internal thread on one side
thread_pitch = 1.5;   // Adjust as needed

module threaded_tube() {
    difference() {
        // Outer tube
        cylinder(h=length, r=outside_radius, center=true);
        
        // Hollow space (fully open on both sides)
        translate([0, 0, -length / 2 - 0.5])  // Extend slightly to ensure full cut
            cylinder(h=length + 1, r=inside_radius, center=false);
        
        // Internal threading (subtract to create threads)
        translate([0, 0, length / 2 - threaded_length])  // Position at one end
            ScrewThread(outer_diam=inside_radius * 2,  
                        height=threaded_length, 
                        pitch=thread_pitch);
    }
}

// Generate the hollow tube with internal threads on one side
threaded_tube();

// use <threads.scad>  // Ensure you have this library installed

// /*
// fullFilterFittingForBathroomTap
// ****************************************

// // threaded_length = 6 ; thread radius18.9
// */

// // The resolution variables:
// $fa = 1;
// $fs = 0.4;

// // Main dimension vareables

// outside_radius = 16.5;
// inside_radius = 14;
// length = 20;

// // Calculated vareables

// threaded_length = length / 2;
// thread_pitch = 1.5; // Adjust as needed

// module threaded_tube() {
//     difference() {
//         // Outer cylinder
//         cylinder(h=length, r=outside_radius, center=true);
        
//         // Inner hollow space
//         translate([0, 0, -length / 2])
//             cylinder(h=length, r=inside_radius, center=false);
        
//         // Internal threading (for half the length)
//         translate([0, 0, -length / 2])
//             ScrewThread(outer_diam=inside_radius * 2, height=threaded_length, pitch=thread_pitch);
//     }
// }

// threaded_tube();



/*
2nd try:

use <threads.scad>  // Ensure you have this library installed

// The resolution variables:
$fa = 1;
$fs = 0.4;

// Main dimension variables
outside_radius = 16.5;
inside_radius = 14;
length = 20;

// Thread settings
threaded_length = length / 2;
thread_pitch = 1.5; // Adjust as needed

module threaded_tube() {
    difference() {
        // Outer solid tube
        cylinder(h=length, r=outside_radius, center=true);
        
        // Inner hollow space (full length)
        translate([0, 0, -length / 2])
            cylinder(h=length + 1, r=inside_radius, center=false);  // +1 to prevent rendering issues
        
        // Internal threading (only on half the length)
        translate([0, 0, -length / 2])
            ScrewThread(outer_diam=inside_radius * 2 - 0.2,  // Slightly smaller to avoid interference
                        height=threaded_length,
                        pitch=thread_pitch);
    }
}

threaded_tube();

*/