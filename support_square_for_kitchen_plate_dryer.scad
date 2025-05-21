/*

Creator
*****************
Constantin Ganshin

Project name:
*****************
support_square_for_kitchen_plate_dryer

Description:
****************************************
A parametric square support design for kitchen plate dryer racks.
The square provides additional stability and support for plate drying racks.
Features:
- 150mm x 150mm square design
- Rounded corners for safety
- Two mounting holes in the middle of adjacent sides, 20mm from edge
- 6mm thickness for added strength

Recommended to be printed in PETG or ABS for better durability and heat resistance.

*/

// Resolution variables for smoother curves
$fa = 1;
$fs = 0.4;

// Main dimension variables
side_length = 150;    // Length of each side
thickness = 6;       // Thickness of the square
corner_radius = 3;   // Radius for rounded corners
hole_diameter = 4;   // Diameter of mounting holes
hole_margin = 10;    // Distance from edges for mounting holes

module rounded_square_support() {
    difference() {
        // Main square body
        hull() {
            // Four corners
            for(x = [corner_radius, side_length - corner_radius]) {
                for(y = [corner_radius, side_length - corner_radius]) {
                    translate([x, y, 0])
                        cylinder(r=corner_radius, h=thickness);
                }
            }
        }
        
        // Mounting holes - in the middle of sides, 20mm from edge
        translate([side_length/2, hole_margin, -1])  // Bottom side
            cylinder(d=hole_diameter, h=thickness + 2);
        translate([hole_margin, side_length/2, -1])  // Left side
            cylinder(d=hole_diameter, h=thickness + 2);
    }
}

// Generate the support
rounded_square_support(); 