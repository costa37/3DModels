// Creator:
// Constantin Ganshin
//
// Project name:
// box_with_lid
//
// Description:
//****************************************
// Parametric Box with Lid and Hinges for M2x30mm screws

/* [Box Dimensions] */
width = 100;
depth = 80;
height = 50;
wall = 2;
corner_radius = 3;

/* [Lid Dimensions] */
lid_thickness = 3; // Thickness of the top plate of the lid
lid_lip_depth = 3; // How deep the lip goes into the box
lid_clearance = 0.2; // Clearance for lid fitting onto box

/* [Hinge Parameters] */
hinge_screw_length = 30; // M2x30mm
hinge_screw_diameter = 2.4; // Loose clearance for M2 to act as a pin
hinge_outer_diameter = 7;
hinge_knuckle_clearance = 0.4; // Axial clearance between knuckles
num_hinges = 2; // Fixed at 2 as requested, but logic handles positioning

/* [Magnet Parameters] */
magnet_d = 5.2; // Diameter of magnet hole (5mm magnet + clearance)
magnet_h = 2;   // Thickness/Depth of the magnet
magnet_wall = 1; // Minimum wall thickness around magnet

/* [Display] */
show_box = true;
show_lid = true;
lid_open_angle = 120; // Degrees to rotate lid for preview

$fn = 60;

// Derived values
hinge_width_total = hinge_screw_length - 2; // Use slightly less than screw length to ensure nut/head fits
// Hinge configuration: Box has outer knuckles, Lid has inner knuckle (or vice versa).
// Let's do: Box = 2 outer parts (approx 1/4 width each), Lid = 1 center part (approx 1/2 width).
knuckle_w_side = (hinge_width_total - 2*hinge_knuckle_clearance) / 4;
knuckle_w_center = (hinge_width_total - 2*hinge_knuckle_clearance) / 2;

module rounded_rect(w, d, h, r) {
    hull() {
        translate([r, r, 0]) cylinder(r=r, h=h);
        translate([w-r, r, 0]) cylinder(r=r, h=h);
        translate([r, d-r, 0]) cylinder(r=r, h=h);
        translate([w-r, d-r, 0]) cylinder(r=r, h=h);
    }
}

module hinge_shape(len) {
    rotate([0, 90, 0])
    cylinder(d=hinge_outer_diameter, h=len, center=false);
}

module hinge_cutout(len) {
    rotate([0, 90, 0])
    cylinder(d=hinge_screw_diameter, h=len + 2, center=false); // +2 for clean cut
    
    // Optional: Nut trap or head recess could be added here
}

module make_box() {
    difference() {
        union() {
            // Outer shell
            rounded_rect(width, depth, height, corner_radius);
            
            // Magnet Boss (Box side)
            // Center front (y=0), top edge
            translate([width/2, wall/2, height - magnet_h - 2]) // Positioned slightly down
            hull() {
                 translate([0, 0, 0]) cylinder(d=magnet_d + 2*magnet_wall, h=magnet_h + 2);
                 translate([0, wall, 0]) cylinder(d=magnet_d + 2*magnet_wall, h=magnet_h + 2);
            }
        }
        
        // Inner cavity
        translate([wall, wall, wall])
        rounded_rect(width - 2*wall, depth - 2*wall, height, max(corner_radius - wall, 0.1));
        
        // Magnet Hole (Box side)
        translate([width/2, wall/2, height - magnet_h])
        cylinder(d=magnet_d, h=magnet_h + 1); // +1 to cut top surface
    }
    
    // Hinge Mounts (Box side)
    // Position: Back face (y=depth), top edge (z=height)
    // Axis center needs to be outside to allow rotation.
    hinge_y = depth + hinge_outer_diameter/2; 
    hinge_z = height; // Flush with top
    
    hinge_positions = [width/4 - hinge_width_total/2, 3*width/4 - hinge_width_total/2];
    
    for (pos_x = hinge_positions) {
        translate([pos_x, hinge_y, hinge_z]) {
            // Left knuckle
            difference() {
                hull() {
                    hinge_shape(knuckle_w_side);
                    // Connect to box back wall
                    translate([0, -hinge_outer_diameter/2, -hinge_outer_diameter/2])
                    cube([knuckle_w_side, hinge_outer_diameter/2, hinge_outer_diameter]);
                }
                translate([-1, 0, 0]) hinge_cutout(knuckle_w_side);
            }
            
            // Right knuckle
            translate([knuckle_w_side + knuckle_w_center + 2*hinge_knuckle_clearance, 0, 0]) {
                difference() {
                    hull() {
                        hinge_shape(knuckle_w_side);
                         // Connect to box back wall
                        translate([0, -hinge_outer_diameter/2, -hinge_outer_diameter/2])
                        cube([knuckle_w_side, hinge_outer_diameter/2, hinge_outer_diameter]);
                    }
                    translate([-1, 0, 0]) hinge_cutout(knuckle_w_side);
                }
            }
        }
    }
}

module make_lid() {
    // Main Lid Body
    difference() {
        // Top plate (Flat lid)
        rounded_rect(width, depth, lid_thickness, corner_radius);
        
        // Magnet Hole (Lid side)
        // Hole faces DOWN (towards box), embedded in the lid
        translate([width/2, wall/2, -0.01])
        cylinder(d=magnet_d, h=magnet_h + 0.01);
    }
    
    // Hinge Mounts (Lid side)
    // Matches box hinge position relative to the lid
    // Lid rests at z=height (in box coord), so locally z=0 is the interface.
    
    hinge_y = depth + hinge_outer_diameter/2;
    hinge_z = 0; // Interface level
    
    hinge_positions = [width/4 - hinge_width_total/2, 3*width/4 - hinge_width_total/2];

    for (pos_x = hinge_positions) {
        translate([pos_x, hinge_y, hinge_z]) {
            // Center knuckle
            translate([knuckle_w_side + hinge_knuckle_clearance, 0, 0]) {
                difference() {
                    hull() {
                        hinge_shape(knuckle_w_center);
                        // Connect to lid back edge
                        translate([0, -hinge_outer_diameter/2, 0])
                        cube([knuckle_w_center, hinge_outer_diameter/2, lid_thickness]);
                    }
                    translate([-1, 0, 0]) hinge_cutout(knuckle_w_center);
                }
            }
        }
    }
}

// Render
if (show_box) {
    make_box();
}

if (show_lid) {
    // Position the lid flat on the XY plane for printing
    // Offset by box width + gap to avoid overlap if both are shown
    lid_print_offset_x = show_box ? width + 10 : 0;
    
    translate([lid_print_offset_x, 0, lid_thickness]) // Move up by thickness so top is at Z=thickness (bottom at Z=0)? 
    // Wait, typically we print flat side down.
    // The lid has hinges on top/back. The bottom face (interface) is flat.
    // So current orientation (Z=0 is interface) is correct for printing if Z+ is up.
    // Actually, make_lid creates lid from Z=0 to Z=lid_thickness.
    // So just translating it away is sufficient.
    
    translate([lid_print_offset_x, 0, 0])
    make_lid();
}
