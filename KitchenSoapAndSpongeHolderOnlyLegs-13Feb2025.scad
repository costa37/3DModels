// Model for two Soap (Ikea like, RINNIG black series) dispenser and two Sponges holder (one regular size and one small, special for scraping)
// Soap dispenser: x=70, y=70
// Soap and Sponge Holder main body: x=310, y=100, z=120

// The resolution variables:
$fa = 1;
$fs = 0.4;

// Small legs
for(i = [1:4]){
    translate([(i * 30), 0, 0])
        cylinder(h = 10, r1 = 10, r2 = 5);
}