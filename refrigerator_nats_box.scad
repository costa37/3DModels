// Refrigerator Nats Box
// Dimensions in cm converted to mm:
// Width=210
// Depth=90
// Left Side Height=160
// Right Side Height=110

width = 210;
depth = 90;
height_left = 160;
height_right = 110;

wall = 3;       // Wall thickness
radius = 5;     // External corner radius

$fn = 60;       // Resolution for rounding

module rounded_sloped_box(w, d, h_l, h_r, r) {
    hull() {
        // Bottom corners
        translate([r, r, r]) sphere(r=r);
        translate([w-r, r, r]) sphere(r=r);
        translate([r, d-r, r]) sphere(r=r);
        translate([w-r, d-r, r]) sphere(r=r);
        
        // Top corners
        // Left side (X=0) -> h_l
        translate([r, r, h_l-r]) sphere(r=r);
        translate([r, d-r, h_l-r]) sphere(r=r);
        
        // Right side (X=w) -> h_r
        translate([w-r, r, h_r-r]) sphere(r=r);
        translate([w-r, d-r, h_r-r]) sphere(r=r);
    }
}

difference() {
    // Outer shell
    rounded_sloped_box(width, depth, height_left, height_right, radius);
    
    // Inner volume (cutout)
    // 1. Shrink width and depth by 2*wall
    // 2. Reduce radius by wall thickness
    // 3. Extend height significantly to cut through the top open face
    inner_r = max(radius - wall, 0.1);
    
    translate([wall, wall, wall])
    rounded_sloped_box(
        width - 2*wall, 
        depth - 2*wall, 
        height_left + 50, // Extend higher to ensure clean top cut
        height_right + 50, 
        inner_r
    );
}
