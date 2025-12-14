
// Creator:
// Constantin Ganshin
//
// Project name:
// partitioned_sloped_box
//
// Description:
//****************************************
// Storage for storing stuff on metal door (with magnets)

// Sloped-top box with internal partitions every 50 mm along width.
// Origin at (0,0,0). No center=true anywhere.
//
// Dimensions (default as requested):
//   - width_spec (X): 140 mm (auto-enlarged to nearest multiple of 50 for partitions)
//   - depth_spec (Y): 50 mm
//   - front_height_spec (Z at Y=0): 90 mm
//   - back_height_spec  (Z at Y=depth): 120 mm
//
// Parameters
width_spec = 140;
depth_spec = 50;
front_height_spec = 90;
back_height_spec = 120;

// Construction parameters
wall = 3;                    // outer wall thickness
back_wall = 5;               // back wall thickness (with magnets)
partition_thickness = 2;     // thickness of each partition panel
partition_spacing = 50;      // required spacing between partitions
partition_headroom = 3;      // additional drop below top edge for partitions

// Magnet parameters (back plate)
magnets_enabled = true;      // master toggle
magnet_d = 17.8;                // magnet diameter (adjustable)
magnet_clearance = 0.0;      // extra diameter for easy fit
magnet_depth_param = 4;      // pocket depth into back wall
magnet_margin = 10;           // edge margin from sides/top/bottom
magnet_gap = 20;              // gap between magnet pockets
magnet_center_grid = true;   // center the grid within available area
magnet_cols_override = 0;    // 0 = auto
magnet_rows_override = 0;    // 0 = auto

// Auto-enlarge width to maintain exact 50 mm partition spacing
width_adj = ceil(width_spec / partition_spacing) * partition_spacing;

// Helper: create a wedge prism oriented from (0,0,0)
// - width along +X, depth along +Y, heights along +Z
// - top height varies linearly from front_h at Y=0 to back_h at Y=depth
module wedge_prism(width, depth, front_h, back_h) {
	// Build 2D polygon with axes: x = height, y = depth; extrude along +Z then rotate to align axes
	// After rotate([0,-90,0]): Xfinal = -Z, Yfinal = Y, Zfinal = X
	// translate([width,0,0]) moves X range from [-width,0] to [0,width].
	translate([width,0,0])
	rotate([0,-90,0])
	linear_extrude(height = width, center = false, convexity = 10)
	polygon(points = [
		[0, 0],                // (height=0 at front)
		[0, depth],            // (height=0 at back)
		[back_h, depth],       // back height
		[front_h, 0]           // front height
	]);
}

module shell() {
	// Construct shell from plates: bottom, front, back, left, right
	difference() {
		union() {
			// Bottom plate
			cube([width_adj, depth_spec, wall], center = false);

			// Front plate (Y = 0..wall), height = front_height_spec
			cube([width_adj, wall, front_height_spec], center = false);

			// Back plate (Y = depth_spec - back_wall .. depth_spec), height = back_height_spec
			translate([0, depth_spec - back_wall, 0])
			cube([width_adj, back_wall, back_height_spec], center = false);

			// Left side plate (X = 0..wall), height = front_height_spec
			cube([wall, depth_spec, front_height_spec], center = false);

			// Right side plate (X = width_adj - wall .. width_adj), height = front_height_spec
			translate([width_adj - wall, 0, 0])
			cube([wall, depth_spec, front_height_spec], center = false);
		}

		// Magnet pockets on back plate
		if (magnets_enabled)
			magnets_cutters();
	}
}

module partitions() {
	inner_depth = max(depth_spec - wall - back_wall, 0.1);
	inner_front_h = max(front_height_spec - wall, 0.1);
	inner_back_h  = max(back_height_spec - wall, 0.1);

	// Place vertical partitions every 50 mm along width (avoid placing at the outer walls)
	for (xpos = [partition_spacing : partition_spacing : width_adj - partition_spacing]) {
		translate([xpos - partition_thickness/2, wall, wall])
		cube([
			partition_thickness,
			inner_depth,
			max(inner_front_h - partition_headroom, 0.1)
		], center = false);
	}
}

// Cutters for round magnet seats on the back plate (Y = depth_spec), axis along -Y
module magnets_cutters() {
	d_eff = magnet_d + magnet_clearance;
	pitch = d_eff + magnet_gap;
	depth_cut = min(magnet_depth_param, max(back_wall - 0.2, 0.1)); // keep a ~0.2 mm back wall remainder

	available_x = max(width_adj - 2*magnet_margin, 0);
	available_z = max(back_height_spec - 2*magnet_margin, 0);

	cols_auto = (pitch > 0) ? floor((available_x + magnet_gap) / pitch) : 0;
	rows_auto = (pitch > 0) ? floor((available_z + magnet_gap) / pitch) : 0;

	cols = (magnet_cols_override > 0) ? magnet_cols_override : cols_auto;
	rows = (magnet_rows_override > 0) ? magnet_rows_override : rows_auto;

	if (cols > 0 && rows > 0) {
		grid_w = (cols - 1) * pitch + d_eff;
		grid_h = (rows - 1) * pitch + d_eff;

		offset_x = magnet_center_grid ? max((available_x - grid_w) / 2, 0) : 0;
		offset_z = magnet_center_grid ? max((available_z - grid_h) / 2, 0) : 0;

		for (i = [0 : cols - 1]) {
			for (j = [0 : rows - 1]) {
				xpos = magnet_margin + offset_x + (d_eff/2) + i * pitch;
				zpos = magnet_margin + offset_z + (d_eff/2) + j * pitch;
				translate([xpos, depth_spec, zpos])
				rotate([90,0,0])  // axis along -Y
				cylinder(h = depth_cut, d = d_eff, center = false, $fn = max(24, ceil(d_eff*6)));
			}
		}
	}
}

// Module to test magnet fit
module magnet_test_plate() {
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

// Final model
union() {
	shell();
	partitions();
}

// Test magnet fit
// magnet_test_plate();


