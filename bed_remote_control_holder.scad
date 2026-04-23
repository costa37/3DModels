/*
Creator
*****************
Constantin Ganshin


Project name:
*****************
bed_remote_control_holder


Description:
****************************************
Remote control holder for a bed frame.
The hook slides between the mattress and the bed frame,
and the lower pocket keeps the remote easy to reach
without holding it too tightly.

Notes:
****************************************
Remote control size: 50 x 30 x 140 mm
Pocket height is kept at about 35 percent of the remote height.
Extra clearance is added to avoid scratches and make removal easy.

*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Remote dimensions
remote_width = 50;
remote_depth = 30;
remote_height = 140;

// Bed dimensions
bed_frame_width = 30;

// Fit and strength tuning
side_clearance = 1.8;
depth_clearance = 2.2;
wall_thickness = 2.4;
back_plate_thickness = 4;
pocket_bottom_thickness = 3;
tongue_thickness = 3.2;
frame_fit_clearance = 2.5;
inner_hook_drop = 65;
top_margin_above_pocket = 28;
join_overlap = 0.2;
corner_radius = 4;

// Calculated dimensions
pocket_height = remote_height * 0.35;
pocket_inner_width = remote_width + (side_clearance * 2);
pocket_inner_depth = remote_depth + (depth_clearance * 2);
pocket_outer_width = pocket_inner_width + (wall_thickness * 2);
pocket_outer_depth = back_plate_thickness + pocket_inner_depth + wall_thickness;
hook_inner_gap = bed_frame_width + frame_fit_clearance;
hook_total_depth = back_plate_thickness + hook_inner_gap + tongue_thickness;
back_plate_height = pocket_bottom_thickness + pocket_height + top_margin_above_pocket + tongue_thickness;
pocket_body_height = pocket_bottom_thickness + pocket_height;
front_wall_height = pocket_height;

module rounded_box(size, radius) {
    safe_radius = min(radius, size[0] / 2, size[1] / 2);

    linear_extrude(height = size[2])
        hull() {
            translate([safe_radius, safe_radius, 0])
                circle(r = safe_radius);
            translate([size[0] - safe_radius, safe_radius, 0])
                circle(r = safe_radius);
            translate([safe_radius, size[1] - safe_radius, 0])
                circle(r = safe_radius);
            translate([size[0] - safe_radius, size[1] - safe_radius, 0])
                circle(r = safe_radius);
        }
}

module pocket() {
    union() {
        // Pocket floor
        rounded_box([pocket_outer_width, pocket_outer_depth, pocket_bottom_thickness], corner_radius);

        // Left side wall
        rounded_box([wall_thickness, pocket_outer_depth, pocket_body_height], wall_thickness / 2);

        // Right side wall
        translate([pocket_outer_width - wall_thickness, 0, 0])
            rounded_box([wall_thickness, pocket_outer_depth, pocket_body_height], wall_thickness / 2);

        // Lower front wall for easier gripping and insertion
        translate([0, pocket_outer_depth - wall_thickness, 0])
            rounded_box([pocket_outer_width, wall_thickness, pocket_bottom_thickness + front_wall_height], wall_thickness / 2);
    }
}

module pocket_back_wall() {
    rounded_box([pocket_outer_width, back_plate_thickness, pocket_body_height], back_plate_thickness / 2);
}

module hook_back_wall_upper() {
    translate([0, 0, pocket_body_height - join_overlap])
        rounded_box([pocket_outer_width, back_plate_thickness, back_plate_height - pocket_body_height + join_overlap], back_plate_thickness / 2);
}

module top_hook() {
    translate([0, -(hook_inner_gap + tongue_thickness), back_plate_height - tongue_thickness - join_overlap])
        rounded_box([pocket_outer_width, hook_total_depth, tongue_thickness + join_overlap], tongue_thickness / 2);
}

module inner_hook_leg() {
    translate([0, -(hook_inner_gap + tongue_thickness), back_plate_height - tongue_thickness - inner_hook_drop - join_overlap])
        rounded_box([pocket_outer_width, tongue_thickness, inner_hook_drop + join_overlap], tongue_thickness / 2);
}

module bed_remote_control_holder() {
    union() {
        pocket();
        pocket_back_wall();
        hook_back_wall_upper();
        top_hook();
        inner_hook_leg();
    }
}

render(convexity = 10)
    bed_remote_control_holder();
