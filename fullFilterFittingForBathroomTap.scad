use <threads.scad>  // Ensure you have this library installed

/*
fullFilterFittingForBathroomTap
****************************************
*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Main dimension variables

inside_radius_threded = 18.9 / 2;
inside_radius_non_threded = 14.4 / 2;
length = 20;

// Thread settings
threaded_length = 6;  // Only 6mm of internal thread on one side
thread_pitch = 1;   // Adjust as needed

// Calculated vareables

outside_radius = inside_radius_threded + 2;
non_threaded_length = length - threaded_length;

module threaded_tube() {
    difference() {
        // Outer tube
        cylinder(h=length, r=outside_radius);
        
        // Hollow space (fully open on both sides)
        // translate([0, 0, -length / 2 - 0.5])  // Extend slightly to ensure full cut
        //     cylinder(h=length + 1, r=inside_radius_threded);

        // Creating the hollow space for the part that will have internal threading
        translate([0, 0, non_threaded_length])  // Position at one end
            cylinder(h=length + 2, r=inside_radius_threded);
        
        // Creating the hollow space for the part that without internal threading
        translate([0, 0, - 4])  // Position at one end
            cylinder(h=non_threaded_length * 2, r=inside_radius_non_threded);
        
        // Internal threading (subtract to create threads)
        translate([0, 0, non_threaded_length])  // Position at one end
            ScrewThread(outer_diam=inside_radius_threded * 2,  
                        height=threaded_length, 
                        pitch=thread_pitch);
    }
}

// Generate the hollow tube with internal threads on one side
threaded_tube();
