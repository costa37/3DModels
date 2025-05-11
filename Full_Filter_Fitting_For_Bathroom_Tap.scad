/*
Creator
*****************
Constantin Ganshin

Project name:
*****************
Full_Filter_Fitting_For_Bathroom_Tap

Description:
****************************************
V2.0 - Changed the filter to regular, store buy filter (iso of special from Ikea)

Sketch:
****************************************

Notes:
****************************************
- Important Note: In case that the filter has larger diameter then of the tap additional fitting will be require to be put on the tap before scrowing the filter fitting on top of it
- Should be printed with PETG for better watter resistance
*/

use <libraries/threads-library-by-cuiso-v1.scad>;

// Resolution variables
$fa = 1;    
$fs = 0.05;

// Main dimension variables

// Tube inside diameters - Three parts: buttom part without threads, middle part for the gasket and the head of the filter and uper part with threads
filter_d = 20 + 0.3; //Added 0.3 for less tightness
gasket_d = 20.7 + 0.3; //Added 0.3 for less tightness
threaded_d = 18.9; // Changed from 18.9 (for better fitting with the filter part)

// Tube hight for each part
filter_h = 11.1; // The hight of the filter
gasket_h = 1.2 + 0.25 - 0.01; // The hight of the gasket and filter head - 0.25 for the gasket that has the same diameter as a top part of the filter, 0.01 removed for tighter feat
threaded_h = 7; // The hight of the threaded part (changed from 6 to accommodate more space for the gasket) 

// Settings for the threads
thread_pitch = 0.5;   // Adjust as needed

// Calcullations
outside_d = max(filter_d, gasket_d, threaded_d) + 2; // The outside diameter of the tube
fitting_h = filter_h + gasket_h + threaded_h;
threads_start_h = filter_h + gasket_h;
thread_module_length = threaded_h + (gasket_h / 2) + 2;

module filter_fitting(){
    difference(){
        cylinder(d = outside_d, h = fitting_h);
        
        // Openning the filter tube
        translate([0, 0, -2])
            cylinder(d = filter_d, h = filter_h + (gasket_h / 2) + 2);
        
        // Openning the gasket tube *****TODO: should be extended to include threaded_d as well*****
        translate([0, 0, filter_h])
            thread_for_nut_fullparm(diameter = gasket_d, length = gasket_h + threaded_h + 1, pitch = thread_pitch);
    }
}

module tap_fitting(){
    difference(){
        translate([outside_d * 1.2, 0, 0])
            thread_for_screw_fullparm(diameter = gasket_d + 0.15, length = threaded_h, pitch = thread_pitch);
        translate([outside_d * 1.2, 0, - 1])
            thread_for_nut_fullparm(diameter = threaded_d, length = threaded_h + 2, pitch = thread_pitch);
    }
}

// Calliing for the needed modules
// filter_fitting();
tap_fitting();

