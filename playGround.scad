/*
Magnet Fit Test Plate - Multiple Sizes
Based on partitioned_sloped_box.scad backplate
*/

// --- Parameters from partitioned_sloped_box.scad ---
back_wall = 5;               // back wall thickness
magnet_depth_param = 4;      // pocket depth
magnet_gap = 5;              // gap between holes
magnet_margin = 5;           // margin around holes

// --- Test Configuration ---
// Diameters to test (final hole size).
// Standard box uses 17.5 + 0.1 = 17.6mm
// Adjust these values to find the perfect fit for your printer/magnet.
test_diameters = [17.6, 17.7, 17.8];

// Derived calculations
// Ensure we leave at least 0.2mm wall thickness at the bottom of the hole
depth_cut = min(magnet_depth_param, max(back_wall - 0.2, 0.1));

module magnet_test_plate() {
    num_holes = len(test_diameters);
    max_d = max(test_diameters);
    
    // Calculate total dimensions
    // Pitch is distance between centers
    pitch = max_d + magnet_gap;
    
    // Total width: 
    // Margin + (Radius of first) + (Pitch * (n-1)) + (Radius of last) + Margin
    // Approximated safely by using max_d for all slots
    total_width = magnet_margin * 2 + (num_holes - 1) * pitch + max_d;
    
    // Height: Diameter + margins + text space
    text_size = 5;
    total_height = max_d + magnet_margin * 2 + text_size + 1;
    
    difference() {
        // Backplate body - Vertical orientation to match the box printing direction
        cube([total_width, back_wall, total_height]);
        
        // Holes
        for (i = [0 : num_holes - 1]) {
            d = test_diameters[i];
            
            // Center position
            cx = magnet_margin + (max_d / 2) + i * pitch;
            // Keep hole centered in the bottom section (ignoring text space)
            cz = (max_d + magnet_margin * 2) / 2;
            
            // Cutout
            // Positioned on the back face (Y = back_wall), going inwards (-Y)
            translate([cx, back_wall, cz])
            rotate([90, 0, 0])
            cylinder(
                h = depth_cut, 
                d = d, 
                center = false, 
                $fn = max(24, ceil(d * 6)) // Smooth circle
            );

            // Text indicator
            translate([cx, back_wall, cz + d/2 + 1])
            rotate([90, 0, 0])
            linear_extrude(height = 0.6)
            mirror([1,0])
            text(str(d), size = text_size, halign = "center", valign = "bottom");
        }
    }
}

magnet_test_plate();
