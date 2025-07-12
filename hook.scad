/*
Creator
*****************
Constantin Ganshin


Project name:
*****************
hook


Description:
****************************************
Hook for hanging stuff on the windoe rails on the service balcony

Sketch:
****************************************
            c            
            -----                 |
            |   |               |
          a |   | b           |   d
            |   |           |
            |   |         |
                |       |
                |     |
                |   |
                | |
                 V   
                
Notes:
****************************************

*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Main dimension variables (part name is marked on the sketch)
a = 25;
b = 50;
c = 11.5; // Inside measurements
d = 70;
angle_b_d = 45;
sphere_r = 2;
cube_x = c + 49.5 ; //c^2 = a^2 + b^2 - 2ab \cdot \cos(C)
cube_y = b;
cube_z = 14 - sphere_r; 

// Modules
module hook(){
  difference(){
    minkowski(){
      cube([cube_x, cube_y, cube_z]); // Base cube
      sphere(sphere_r); // Corners radius (will enlarge the module by this)
    }
    translate([0, - sphere_r - 1, - sphere_r -1])
      cube([c, b + (sphere_r) + 1, cube_z + (sphere_r * 2) + 2]);

    translate([- sphere_r - 1, - sphere_r - 1, - sphere_r -1])
      cube([sphere_r + 2, b - a  + sphere_r + 1, cube_z + (sphere_r * 2) + 2]);
    
    // Inside triangle
    minkowski(){
      translate([(sphere_r) + c + 6, sphere_r + 6, - sphere_r - 1])
        linear_extrude(cube_z + (sphere_r * 2) + 2)
        polygon(points=[[0, 0], [0, b + sphere_r + 1], [cube_x, b + sphere_r + 1]]);
      sphere(sphere_r + 2);
    }
    
    // Outside triangle (on the right side)
    translate([(sphere_r * 2) + c + 8, - sphere_r - 1, - sphere_r - 1])
      linear_extrude(cube_z + (sphere_r * 2) + 2)
      polygon(points=[[- sphere_r * 2, 0], [cube_x, (sphere_r * 2) + b + 1], [cube_x + sphere_r + 1, -sphere_r - 1]]);
  }
}

// 3D module generation
hook();