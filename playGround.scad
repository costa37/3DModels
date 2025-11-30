/*
Magnet Fit Test
****************
Test plate to verify magnet fit using exact parameters from partitioned_sloped_box.scad
Efficient thin wall plate that matches actual wall thickness
*/

// Magnet parameters (exact copy from partitioned_sloped_box.scad)
magnet_d = 17.5;                // magnet diameter
magnet_clearance = 0.1;         // extra diameter for easy fit
magnet_depth_param = 4;         // pocket depth into back wall
wall = 4;                       // wall thickness (from partitioned_sloped_box.scad)

// Calculated values (same as in magnets_cutters module)
d_eff = magnet_d + magnet_clearance;  // 18.0
depth_cut = min(magnet_depth_param, max(wall - 0.2, 0.1)); // 2.8

// Test plate dimensions
test_plate_width = 30;   // Width of the test plate
test_plate_height = 40;  // Height of the test plate

// Test plate with magnet cutout
module magnet_test_plate() {
    difference() {
        // Main test plate - thin wall matching actual wall thickness
        cube([test_plate_width, wall, test_plate_height], center = false);
        
        // Magnet cutout - using exact same parameters and orientation as in partitioned_sloped_box.scad
        // Positioned on the back face (Y = wall), axis along -Y
        translate([test_plate_width/2, wall, test_plate_height/2])
        rotate([90, 0, 0])  // axis along -Y (same as in partitioned_sloped_box.scad)
        cylinder(
            h = depth_cut + 1, 
            d = d_eff, 
            center = false, 
            $fn = max(24, ceil(d_eff*6))
        );
    }
}

// Render the test plate
magnet_test_plate();
