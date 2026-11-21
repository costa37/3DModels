// Kitchen plate dryer support v2, based on Constantin Ganshin's original.
// Print flat with PLA and the companion Bambu Studio process preset.
// The preset reinforces the shells around the mounting holes and both broad faces.

$fa = 1;
$fs = 0.4;

// Main dimension variables
side_length = 110;    // Length of each side
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
        
        // Mounting holes - centered on two adjacent sides, 10 mm from each edge
        translate([side_length/2, hole_margin, -1])  // Bottom side
            cylinder(d=hole_diameter, h=thickness + 2);
        translate([hole_margin, side_length/2, -1])  // Left side
            cylinder(d=hole_diameter, h=thickness + 2);
    }
}

// Generate the support
rounded_square_support(); 
