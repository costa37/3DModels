/*

playGround - Wireless MagSafe Charger Housing
****************************************
Housing: 67x67x12mm square
Charger: d=61.6mm, h=9.8mm
Inner charging area: d=57.9mm, sits 2mm higher
Retention ring: fits between outer and inner diameters

*/

// Parameters
housing_width = 67;
housing_height = 12;
charger_diameter = 61.6;
charger_height = 9.8;
inner_diameter = 57.9;
raised_height = 2; // How much higher the inner part sits
ring_height = 2;
cable_width = 8.5;

// Main housing with cutouts
module charger_housing() {
    difference() {
        // Main square housing
        translate([0,0,housing_height/2])
            cube([housing_width, housing_width, housing_height], center=true);
        
        // Cutout for charger body (outer diameter) - positioned so charger top is flush with housing top
        translate([0, 0, housing_height - charger_height])
            cylinder(d=charger_diameter, h=charger_height + 1, center=false);
        
        // Cutout for the cable
        translate([- cable_width/2, charger_diameter/2 - 2, housing_height - charger_height])
            cube([cable_width, 10, 20]);
    }
}

// Retention ring that fits between outer and inner diameters
module retention_ring() {
    difference() {
        cylinder(d=charger_diameter - 0.2, h=ring_height, center=false); // Slightly smaller for tight fit
        translate([0,0,-1])
            cylinder(d=inner_diameter + 0.2, h=ring_height + 2, center=false); // Slightly larger for clearance
    }
}

// Render the housing
charger_housing();

// Render the retention ring (positioned separately for printing)
translate([80, 0, 0])
    retention_ring();
