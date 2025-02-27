// The resolution variables:
$fa = 1;
$fs = 0.4;

//Variables
mainBodyX = 240;
mainBodyY = 20;
mainBodyZ = 40;
backWallZ = 70;
wallsThickness = 3;
screwHoleRadius = 3.9 / 2;
screwHoleZ = 53;

// Main body
difference(){
    cube([mainBodyX,mainBodyY,backWallZ]);
    translate([wallsThickness, wallsThickness, wallsThickness])
        cube([mainBodyX - (wallsThickness * 2), mainBodyY - (wallsThickness * 2), backWallZ - wallsThickness]);
    translate([-2,wallsThickness,mainBodyZ])
        cube([mainBodyX + 5, mainBodyY + 5,backWallZ]);
    translate([mainBodyX / 2, 5, screwHoleZ])
        rotate([90, 0, 0])
            cylinder(h = (mainBodyY / 2), r = screwHoleRadius);
}

// translate([mainBodyX * 2, -2, screwHoleZ])
//         rotate([90, 0, 0])
//             cylinder(h = mainBodyY / 2, r = screwHoleRadius);