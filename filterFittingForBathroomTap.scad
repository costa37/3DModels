/*
Fitting for Ikea Abacken filter for special size tap
Z = 11.6 - 1.5 (filter upper part) = 10.1
outsideD = 16.3
innerD = 14
*/

// The resolution variables:
$fa = 1;
$fs = 0.4;

// Main dimension vareables

z = 10.1;
outsideD = 16.3;
insideD = 14;

// Calculated vareables

outsideR = outsideD / 2;
insideR = insideD / 2;

// Main

difference(){
    cylinder (r = outsideR, h = z);
    translate([0, 0, -10])
        cylinder (r = insideR,  h = z * 2);
}