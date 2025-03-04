// threaded_length = 6 ; thread radius18.9
use <threads.scad>  // Ensure you have this library installed

// Tube dimensions
outside_radius = 16.5;
inside_radius = 14;
length = 20;
threaded_length = length / 2;
thread_pitch = 1.5; // Adjust as needed

module threaded_tube() {
    difference() {
        // Outer cylinder
        cylinder(h=length, r=outside_radius, center=true);
        
        // Inner hollow space
        translate([0, 0, -length / 2])
            cylinder(h=length, r=inside_radius, center=false);
        
        // Internal threading (for half the length)
        translate([0, 0, -length / 2])
            metric_thread(d=inside_radius * 2, pitch=thread_pitch, length=threaded_length);
    }
}

threaded_tube();