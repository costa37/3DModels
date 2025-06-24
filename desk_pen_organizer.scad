//
// Desk Pen Organizer
//
// This file defines a desk organizer with removable pen/pencil caps.
// The organizer has a grid of compartments, and each compartment can hold one cap.
//

//
// --- Parameters ---
//

// Number of columns and rows for the compartments
cols = 2;
rows = 3;

// Dimensions for the removable caps [width, depth, height]
cap_dims = [70, 70, 120];

// Wall thickness for the organizer and caps
wall_thickness = 2;

// Tolerance for a snug fit of the caps inside the compartments
// This is the extra space around the cap.
tolerance = 1;

// Height of the main organizer base
organizer_height = 60;

// Radius for the outer corners of the organizer
border_radius = 5;


//
// --- Calculated Dimensions ---
// (Usually no need to change these)
//

// Internal dimensions of each compartment
compartment_dims = [
    cap_dims[0] + tolerance, 
    cap_dims[1] + tolerance
];

// Overall dimensions of the organizer
organizer_dims = [
    cols * compartment_dims[0] + (cols + 1) * wall_thickness,
    rows * compartment_dims[1] + (rows + 1) * wall_thickness,
    organizer_height
];


//
// --- Modules ---
//

// Module for the main organizer body
module organizer() {
    difference() {
        // Outer shell of the organizer with rounded corners
        linear_extrude(height = organizer_dims[2]) {
            hull() {
                // Circles at the corners to create the rounded shape
                translate([border_radius, border_radius]) 
                    circle(r = border_radius);
                translate([organizer_dims[0] - border_radius, border_radius]) 
                    circle(r = border_radius);
                translate([border_radius, organizer_dims[1] - border_radius]) 
                    circle(r = border_radius);
                translate([organizer_dims[0] - border_radius, organizer_dims[1] - border_radius]) 
                    circle(r = border_radius);
            }
        }
        
        // Create the cutouts for each compartment
        for (c = [0:cols-1]) {
            for (r = [0:rows-1]) {
                translate([
                    wall_thickness + c * (compartment_dims[0] + wall_thickness),
                    wall_thickness + r * (compartment_dims[1] + wall_thickness),
                    wall_thickness
                ]) {
                    // The cube that creates the hollow space
                    cube([compartment_dims[0], compartment_dims[1], organizer_dims[2]]);
                }
            }
        }
    }
}

// Module for the removable cap/pen holder
module cap() {
    difference() {
        // Outer shape of the cap
        cube(cap_dims);
        
        // Inner hollow part of the cap
        translate([wall_thickness, wall_thickness, wall_thickness]) {
            cube([
                cap_dims[0] - 2 * wall_thickness,
                cap_dims[1] - 2 * wall_thickness,
                cap_dims[2] // Make it slightly taller to ensure it's open at the top
            ]);
        }
    }
}


//
// --- Assembly ---
//
// Uncomment the part you want to render/export.
//

// 1. Render only the organizer
// organizer();

// 2. Render only one cap (for printing separately)
// cap();

// 3. Render the organizer with all caps in place (for visualization)
/*
module assembly() {
    organizer();
    for (c = [0:cols-1]) {
        for (r = [0:rows-1]) {
            translate([
                wall_thickness + c * (compartment_dims[0] + wall_thickness) + tolerance / 2,
                wall_thickness + r * (compartment_dims[1] + wall_thickness) + tolerance / 2,
                wall_thickness
            ]) {
                cap();
            }
        }
    }
}
assembly();
*/

// 4. Render the organizer and one cap side-by-side
organizer();
translate([organizer_dims[0] + 10, 0, 0]) {
    cap();
} 