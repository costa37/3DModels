// Disc for Alon
// 12mm radius, height increased to 4mm to accommodate 2.7mm dent
// Stackable with a conical dent on bottom and bump on top

$fn = 100;

radius = 12;
height = 4; // Increased from 2mm to 4mm to fit the 2.7mm dent depth

// Dent: 3.8mm diameter (1.9mm radius) base, 2.4mm diameter (1.2mm radius) top
dent_r_base = 1.9;
dent_r_top = 1.2;
stack_height = 2.7;
clearance = 0.1;

difference() {
    union() {
        // Main body
        cylinder(r = radius, h = height);
        
        // Top bump (truncated cone to fit the dent)
        translate([0, 0, height])
            cylinder(r1 = dent_r_base - clearance, r2 = dent_r_top - clearance, h = stack_height);
    }
    
    // Bottom dent (truncated cone)
    translate([0, 0, -0.01])
        cylinder(r1 = dent_r_base, r2 = dent_r_top, h = stack_height + 0.01);
}
