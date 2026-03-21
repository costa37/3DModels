// Disc for Alon
// 10mm radius, 2mm height
// Stackable with a dent on bottom and bump on top

$fn = 100;

radius = 12;
height = 4;
stack_radius = 1.5;
stack_height = 0.4;

difference() {
    union() {
        // Main body
        cylinder(r = radius, h = height);
        
        // Top bump (conical)
        translate([0, 0, height])
            cylinder(r1 = stack_radius - 0.1, r2 = 0, h = stack_height); // Slightly smaller for clearance
    }
    
    // Bottom dent (conical)
    translate([0, 0, -0.01])
        cylinder(r1 = stack_radius, r2 = 0, h = stack_height + 0.01);
}
