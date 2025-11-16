/*
box_generator

Description:
*****************
A module for generating boxes with rounded edges inside.
Boxes are meant for appartment enterance closet

Creator:
*****************
Constantin Ganshin
*/

wall = 0;
r_inside = 5;
r_outside = 5;

module box_generator(x,y,z) {
  difference() {
    minkowski() {
      cube([x,y,z]);
      sphere(r_outside);
    }
    translate([wall + r_inside, wall + r_inside, wall + r_inside])
      minkowski() {
        cube([x - 2*r_inside -(wall*2),y - 2*r_inside -(wall*2),z + 2]);
        sphere(r_inside);
      }
  }
}

module box_generator_without_wall(x,y,z) {
  difference() {
    minkowski() {
      cube([x,y,z]);
      sphere(r_outside);
    }
    translate([wall + r_inside, wall + r_inside, wall + r_inside])
      minkowski() {
        cube([x - 2*r_inside -(wall*2),y + 2*r_inside + (wall*2),z + 2]);
        sphere(r_inside);
      }
  }
}

// Special measuring module
module measure(x) {
  color("#FF0000") //red color for easier visibility
    cube([x,5,5]);
}

box_generator(70,130,120);

translate([90,0,0])
  box_generator(80,130,100);

translate([190,0,0])
  box_generator(160,170,60);

translate([370,0,0])
  box_generator_without_wall(60,260,180);

!translate([450,0,0])
  box_generator(110,11,38);  // For small wallet that will be inside of the big box

translate([450, 0, 40])
  rotate([0, 0, 0])
    measure(100);
