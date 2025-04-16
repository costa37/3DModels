/*

Creator
*****************

Constantin Ganshin

Project name:
*****************
closet_floating_shelf

Description:

    Closets shelf that will attached under the shelf
                                  ________
                                          |
                                          |
             -----------------------------
            |
            |                           
            |                             |
             -----------------------------                   
*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Main dimension variables
hook_top_x = 60; // Length of the upper part (that will be on top of the shelf)
closet_shelf_thickness_y = 29; // Thickness of the actual closet shelf
hook_shelf_bottom_x = 250; // Length of the bottom part (that will be on the bottom of the shelf) and the bottom part of the floating shelf
floating_shelf_thickness_y = 37; // Thickness (the gap for the things that will be put on the shelf) of the floating shelf
shelf_closer_y = floating_shelf_thickness_y * 0.05; // The part that closes the floating shelf and prevents from things to slide from the shelf)
wall_thickness = 4; // Walls are in addition to the rest of measurements 
shelf_thickness_z = 70;
// round_corners_radius = 1;
// wall_thickness_udjust_for_round_corners = wall_thickness - round_corners_radius;


module closet_floating_shelf(){
    difference(){
        cube([hook_shelf_bottom_x + (wall_thickness * 2), (wall_thickness * 3) + floating_shelf_thickness_y + closet_shelf_thickness_y, shelf_thickness_z]);
        // Shelf cutout
        translate([wall_thickness, wall_thickness, -1])
            cube([hook_shelf_bottom_x, floating_shelf_thickness_y, shelf_thickness_z + 2]);
        // Closer cutout    
        translate([wall_thickness + hook_shelf_bottom_x - 1, wall_thickness + shelf_closer_y, -1])
            cube([wall_thickness + 2, floating_shelf_thickness_y - shelf_closer_y, shelf_thickness_z + 2]); 
        // Hook cutout
        translate([-1, (wall_thickness * 2) + floating_shelf_thickness_y, -1])
            cube([wall_thickness + hook_shelf_bottom_x + 1, closet_shelf_thickness_y, shelf_thickness_z + 2 ]);
        //Hook cutout 2nd part    
        translate([-1, (wall_thickness * 2) + floating_shelf_thickness_y + closet_shelf_thickness_y - 1, -1])
            cube([hook_shelf_bottom_x - hook_top_x + 1, wall_thickness + 2, shelf_thickness_z + 2]);   
    }
}

// Generate the shape
closet_floating_shelf();