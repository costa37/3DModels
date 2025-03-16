use <libraries/threads-library-by-cuiso-v1.scad>;

/*

V2.0 - Changed the filter to regular, store buy filter (iso for specially thin from Ikea)

fullFilterFittingForBathroomTap
****************************************
*/

// Resolution variables
$fa = 1;    
$fs = 0.05;

// Main dimension variables

inside_radius_threded = 18.9 / 2;
inside_radius_non_threded = (20 + 0.3) / 2; //Added 0.3 for less tightness
inside_radius_top = (20.7 + 0.3) / 2; //Added 0.3 for less tightness

// lengh of threated part = 6; hight of standart foset filter = 11.1 in the buttom part and 1.2 in the top part (threaded part); lenght of gasket = 0.25
buttom_part_hight = 11.1;
top_part_hight_non_threaded = 1.2 + 0.25 - 0.01; // 0.25 for the gasket that has the same diameter as a top part of the filter, 0.01 removed for tighter feat

// Thread settings
threaded_hight = 6;  
thread_pitch = 0.5;   // Adjust as needed
thread_tolerance = 0.2;  // Adjust as needed

// Calculated vareables
hight = buttom_part_hight + threaded_hight + top_part_hight_non_threaded;
outside_radius = max(inside_radius_threded, inside_radius_non_threded, inside_radius_top) + 2;
non_threaded_hight = hight - threaded_hight;

module threaded_tube() {
    difference() {
        // Outer tube
        cylinder(h=hight, r=outside_radius);

        // Creating the hollow space for the part that will have internal threading
        translate([0, 0, non_threaded_hight])  // Position at one end
            cylinder(h=hight + 2, r=inside_radius_threded);
        
        // Creating the hollow space for the buttom part that without internal threading
        translate([0, 0, - 4])  // Position at one end
            cylinder(h=non_threaded_hight * 2, r=inside_radius_non_threded);
        
        // Creating the hollow space for the top part (without threading)
        translate([0, 0, buttom_part_hight])  // Position at one end
            cylinder(h=top_part_hight_non_threaded, r=inside_radius_top);
    }
}

module add_threads(){
    // Create threads 
    translate([0, 0, non_threaded_hight + top_part_hight_non_threaded])
        thread_for_nut_fullparm(diameter=inside_radius_threded * 2, length=threaded_hight, pitch=thread_pitch);
}

// Generate the hollow tube with internal threads on one side
union(){
    threaded_tube();
    add_threads();
}

