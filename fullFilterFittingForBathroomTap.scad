use <threads.scad>  // Ensure you have this library installed

/*

V2.0 - Changed the filter to regular, store buy filter (iso for specially thin from Ikea)

fullFilterFittingForBathroomTap
****************************************
*/

// Resolution variables
$fa = 1;    
$fs = 0.4;

// Main dimension variables

inside_radius_threded = 18.9 / 2;
inside_radius_non_threded = (20 + 0.3) / 2; //Added 0.3 for less tightness
inside_radius_top = (20.7 + 0.3) / 2; //Added 0.3 for less tightness

// lengh of threated part = 6; hight of standart foset filter = 11.1 in the buttom part and 1.2 in the top part (threaded part); lenght of gascet = 0.25
buttom_part_hight = 11.1;
top_part_hight_non_threaded = 1.2; // *********************TODO********************* Cut this hight with inside_radius_top

// Thread settings
threaded_hight = 7.45;  
thread_pitch = 0.5;   // Adjust as needed
thread_tolerance = 1;

// Calculated vareables
hight = buttom_part_hight + threaded_hight + top_part_hight_non_threaded;
outside_radius = inside_radius_threded + 2;
non_threaded_hight = hight - threaded_hight;

module threaded_tube() {
    difference() {
        // Outer tube
        cylinder(h=hight, r=outside_radius);

        // Creating the hollow space for the part that will have internal threading
        translate([0, 0, non_threaded_hight])  // Position at one end
            cylinder(h=hight + 2, r=inside_radius_threded);
        
        // Creating the hollow space for the part that without internal threading
        translate([0, 0, - 4])  // Position at one end
            cylinder(h=non_threaded_hight * 2, r=inside_radius_non_threded);
        
        // Internal threading (subtract to create threads)
        translate([0, 0, non_threaded_hight])  // Position at one end
            ScrewThread(outer_diam=inside_radius_threded * 2,  
                        height=threaded_hight, 
                        pitch=thread_pitch,
                        tolerance = thread_tolerance);
    }
}

// Generate the hollow tube with internal threads on one side
threaded_tube();
