/*

wiperHook
****************************************

*/

// Resolution variables
$fa = 1;
$fs = 0.4;

// Main dimension variables
hookWidthZ = 1.5;
loopRibLength = 20;
hookRibOne = 50;
hookRibTwo = 30;
hookRibThree = 10;
wallThikness = 1;

// Calculated vareables

hookLocationOnLoop = loopRibLength / 2; // The location of the hook on the loop rib (in this case it's in the middle of the loop rib)

// Modules

module wiperHook(){
    difference(){
        cube([loopRibLength + hookRibOne, hookLocationOnLoop + hookRibTwo, hookWidthZ]);

        // Loop section
        translate([wallThikness, wallThikness, - 2])
            cube([loopRibLength - (2 * wallThikness), loopRibLength - (2 * wallThikness), hookWidthZ * 20]);

        // Rib one
        translate([loopRibLength, - 2, -2])
            cube([hookRibOne * 2, hookLocationOnLoop + 2 , hookWidthZ * 20]);
        
        // Rib Two
        translate([loopRibLength, hookLocationOnLoop + wallThikness, -2])
            cube([hookRibOne - wallThikness, hookRibTwo - (wallThikness * 2), hookWidthZ * 20]);
        
        // Rib Three
        translate([- 2, loopRibLength, -2])
            cube([loopRibLength + (hookRibOne - hookRibThree), hookRibTwo * 2, hookWidthZ * 20]);
    }    
}

// Generate the wiper hook
wiperHook();