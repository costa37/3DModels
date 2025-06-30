/*
Creator
*****************
Constantin Ganshin


Project name:
*****************
Phone_Airpods_Charger_Under_The _Screen_Organizer

Description:
****************************************
Desk organizer for placing Airpods, MagSafe charger and Phone under the screen on the desktop.
The phone and charger place will have a ~20 degrees tilt towards the X axis (towards the user).

Sketch:
****************************************


                        ____________
                       |           |             
                       |           | 
            Charger    |           |
 ________   ___________|           |
|         |            |           |
| Airpods |   *****    |  Phone    |
|         |   *****    |           |
|________ |____________|           |
                       |           |
                       |           |
                       |           |
                       |           |
                       -------------


Notes:
****************************************

*/


// Resolution variables
$fa = 1;
$fs = 0.4;


// Main dimension variables
airpods_x = 70; //Original 83
airpods_y = 67;
airpods_z = 13;
round_edge_airpods_r = 2;

airpod_dimentions_x = 64;
airpod_dimentions_y = 49; 
airpod_dimentions_cutout_z = 4;

charger_x = 90; //Original 110
charger_y = 67;
charger_z = 26;

magsafe_cutout_d = 61.6;
magsafe_cutout_z = 9.8;
magsafe_cort_cutout_x = 2;
magsafe_cort_cutout_y = 20;
cable_width_x = 8.5;
ring_height = 1;
inner_diameter = 57.9;


phone_x = 85; //Original 100
phone_y = 170;
phone_z = 26;

round_edge_r = 4;
phone_tilt_angle = 5;

// Modules
module base(){
    union(){
        minkowski(){
            cube([airpods_x + charger_x, airpods_y, charger_z]);
            sphere(round_edge_r);
        }
        translate([airpods_x + charger_x, (- phone_y / 2) + charger_y / 2, 0])
            minkowski(){
                cube([phone_x, phone_y, phone_z]);
                sphere(round_edge_r);
            }
    }
}

module design(){
    difference(){
        base();
        translate([airpods_x, (- phone_y / 2) + charger_y / 2, airpods_z / 2])
            rotate([phone_tilt_angle, 0, 0])
                cube([charger_x + phone_x + round_edge_r + 2, phone_y * 2, charger_z * 4]);
        translate([airpods_x + charger_x - 10, (- phone_y / 2), airpods_z])
            cube([phone_x * 2, charger_y, airpods_x]);
        translate([- round_edge_r - 2, - round_edge_r - 2, airpods_z / 2])
            cube([airpods_x + round_edge_r + 3, airpods_y * 2 + round_edge_r + 2, airpods_z * 4]);
        // Cutout for the airpods
        translate([(airpods_x - airpod_dimentions_x) / 2 - 3, (airpods_y - airpod_dimentions_y) / 2 - 2, airpods_z / 2 - airpod_dimentions_cutout_z + 4])
            minkowski(){
                cube([airpod_dimentions_x + 3, airpod_dimentions_y + 3, airpod_dimentions_cutout_z + 1]);
                sphere(round_edge_airpods_r);
            }
        // Cutout for the MagSafe charger
        translate([airpods_x + (charger_x / 2), charger_y / 2, airpods_z + 1 - magsafe_cutout_z])
            rotate([phone_tilt_angle, 0, 0])
                cylinder(h = magsafe_cutout_z + 1, d = magsafe_cutout_d);
        // Cutout for the MagSafe power cord
        translate([airpods_x + (charger_x / 2) - cable_width_x/2, charger_y / 2 + magsafe_cutout_d / 2 - 1, airpods_z - magsafe_cutout_z + 3.6])
            rotate([phone_tilt_angle, 0, 0])
                    cube([cable_width_x, magsafe_cort_cutout_y, magsafe_cutout_z * 2]);
    }           
}

// Retention ring that fits between outer and inner diameters
module retention_ring() {
    difference() {
        cylinder(d=magsafe_cutout_d - 0.1, h=ring_height, center=false); // Slightly smaller for tight fit
        translate([0,0,-1])
            cylinder(d=inner_diameter + 0.2, h=ring_height + 2, center=false); // Slightly larger for clearance
    }
}

module measurment(){
    translate([airpods_x + charger_x + phone_x + 10, phone_y - 50, - round_edge_r])
        cylinder(h = 30, d = 2);
    translate([airpods_x + charger_x + phone_x + 10, (- phone_y / 2) + charger_y / 2, - round_edge_r])
        cylinder(h = 21, d = 2);
    translate([airpods_x + charger_x + phone_x + 10, (- phone_y / 2) + charger_y / 2 + 5, - round_edge_r])
        cylinder(h = 15, d = 2);
    translate([airpods_x, phone_y, 0])
        #cube([100, 3, 10]);
}

// 3D module generation
design();

// Render the retention ring (positioned separately for printing)
translate([airpods_x + charger_x + 180, 0, 0])
    retention_ring();

// measurment();

// Printing
echo(str("airpods_x = ", airpods_x)); 
echo(str("charger_x = ", charger_x));
echo(str("phone_x = ", phone_x));
echo(str("Overall_width_x = ", airpods_x + charger_x + phone_x + round_edge_r*2));

