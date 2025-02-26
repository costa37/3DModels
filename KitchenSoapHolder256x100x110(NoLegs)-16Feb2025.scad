// Model for two Soap (Ikea like, RINNIG black series) dispenser and two Sponges holder (one regular size and one small, special for scraping)
// Soap dispenser: x=70, y=70

// The resolution variables:
$fa = 1;
$fs = 0.4;

//Variables:
// Main dimensions
mainBodyX = 256;
mainBodyY = 100;
mainBodyZ = 110;
outsideWallsThickness = 4;
insideWallsThickness = 2;
specialWallForCutting = outsideWallsThickness; // * 2;
spongeWallsHight = 40; // The hight of the walls of the sponge section - should be low for easy picking of the sponges
marginsForDrainingHolesArea = 10; // Margins (area without holes) for the surface area of draining holes on all sides (X and Y axes)
numRowsColumnsForDrainingHolesGrid = 4;
partOfHoleInGridCell = 0.3;

// Calculations for the rest of the sections
dispenserSectionLengthX = 140 + (outsideWallsThickness * 2) + insideWallsThickness; //mainBodyX / 2; // X length to the border between dispensers and sponges, where 140 is a lenth of 2 standard Ikea soap dispencer
singleDispencerSectionLengthX = dispenserSectionLengthX / 2;
spongeSectionLengthX = mainBodyX - dispenserSectionLengthX;
spongeOneSectionLengthX = spongeSectionLengthX * 0.7; // First section for the sponge will be larger then the 2nd
spongeTwoSectionLengthX = spongeSectionLengthX - spongeOneSectionLengthX;
holeDispenserOneX = singleDispencerSectionLengthX - outsideWallsThickness - (insideWallsThickness / 2); // Has two walls, one outside and half of the inside wall
holeDispenserTwoX = singleDispencerSectionLengthX - (insideWallsThickness / 2) - (specialWallForCutting / 2); // has one outside and one inside walls - only half of each one should be here
holeSpongeOneX = spongeOneSectionLengthX - (insideWallsThickness / 2) - (specialWallForCutting / 2); // has two shared inside wall - only half of each one should be here
holeSpongeTwoX = spongeTwoSectionLengthX - (insideWallsThickness / 2) - outsideWallsThickness; // Has two walls, half inside (shared wall) and one outside
holeY = mainBodyY - (outsideWallsThickness * 2); // The Y axis (width) for all the holes is the same
holeZ = mainBodyZ * 2; // Twice the hight of the body (for easy colculations)
holeLowerWallsSpongeSectionY = mainBodyY * 2;
// Draining holes calculation
firstDispencerAreaForDrainingHolesX = holeDispenserOneX - (marginsForDrainingHolesArea * 2);
firstDispencerAreaForDrainingHolesY = holeY - (marginsForDrainingHolesArea * 2);
gridCellDispencerAreaForDrainingHolesX = firstDispencerAreaForDrainingHolesX / numRowsColumnsForDrainingHolesGrid;
gridCellDispencerAreaForDrainingHolesY = firstDispencerAreaForDrainingHolesY / numRowsColumnsForDrainingHolesGrid;
drainingHolesRadius = sqrt((partOfHoleInGridCell * gridCellDispencerAreaForDrainingHolesX * gridCellDispencerAreaForDrainingHolesY) / 3.14);

// Main body

difference(){
    cube([mainBodyX,mainBodyY,mainBodyZ]);

    // First dispenser hole
    translate([outsideWallsThickness, outsideWallsThickness, outsideWallsThickness])
        cube([holeDispenserOneX, holeY, holeZ]);

    // Second dispenser hole
    translate([singleDispencerSectionLengthX + (insideWallsThickness / 2), outsideWallsThickness, outsideWallsThickness])
        cube([holeDispenserTwoX, holeY, holeZ]);

    // First sponge hole
    translate([dispenserSectionLengthX + (specialWallForCutting / 2), outsideWallsThickness, outsideWallsThickness])
        cube([holeSpongeOneX, holeY, holeZ]);

    // Second sponge hole
    translate([dispenserSectionLengthX + spongeOneSectionLengthX + (insideWallsThickness / 2), outsideWallsThickness, outsideWallsThickness])
        cube([holeSpongeTwoX, holeY, holeZ]);

    // Lowering the walls for sponge section
    translate([dispenserSectionLengthX + (specialWallForCutting / 2), - (holeLowerWallsSpongeSectionY * 0.1), spongeWallsHight]) // For removal of the wall the Y axis translate should be minus
        cube([spongeSectionLengthX * 1.5, holeLowerWallsSpongeSectionY, holeZ]);

    // Draining holes first dispencer
    for (y = [1 : numRowsColumnsForDrainingHolesGrid]){
        for(i = [1 : numRowsColumnsForDrainingHolesGrid]){
            translate([outsideWallsThickness + marginsForDrainingHolesArea + ((gridCellDispencerAreaForDrainingHolesX / 2)) + (gridCellDispencerAreaForDrainingHolesX * (i-1)), outsideWallsThickness + marginsForDrainingHolesArea + ((gridCellDispencerAreaForDrainingHolesY / 2)) + (gridCellDispencerAreaForDrainingHolesY * (y-1)), - (mainBodyZ * 0.1)])
                cylinder(r=drainingHolesRadius, h=mainBodyZ * 2);
        }
    }

    // Draining holes second dispencer
    for (y = [1 : numRowsColumnsForDrainingHolesGrid]){
        for(i = [1 : numRowsColumnsForDrainingHolesGrid]){
            translate([singleDispencerSectionLengthX + (insideWallsThickness/2) + marginsForDrainingHolesArea + ((gridCellDispencerAreaForDrainingHolesX / 2)) + (gridCellDispencerAreaForDrainingHolesX * (i-1)), outsideWallsThickness + marginsForDrainingHolesArea + ((gridCellDispencerAreaForDrainingHolesY / 2)) + (gridCellDispencerAreaForDrainingHolesY * (y-1)), - (mainBodyZ * 0.1)]) 
                cylinder(r=drainingHolesRadius, h=mainBodyZ * 2);
        }
    }

    // Draining holes first sponge
    for (y = [1 : numRowsColumnsForDrainingHolesGrid]){
        for(i = [1 : numRowsColumnsForDrainingHolesGrid]){
            translate([dispenserSectionLengthX + (outsideWallsThickness/2) + marginsForDrainingHolesArea + ((gridCellDispencerAreaForDrainingHolesX / 2)) + (gridCellDispencerAreaForDrainingHolesX * (i-1)), outsideWallsThickness + marginsForDrainingHolesArea + ((gridCellDispencerAreaForDrainingHolesY / 2)) + (gridCellDispencerAreaForDrainingHolesY * (y-1)), - (mainBodyZ * 0.1)]) 
                cylinder(r=drainingHolesRadius, h=mainBodyZ * 2);
        }
    }

    // Draining holes second sponge
    for (y = [1 : numRowsColumnsForDrainingHolesGrid]){
        for(i = [1 : numRowsColumnsForDrainingHolesGrid - 3]){
            translate([dispenserSectionLengthX + spongeOneSectionLengthX + (insideWallsThickness/2) + marginsForDrainingHolesArea + ((gridCellDispencerAreaForDrainingHolesX / 2)) + (gridCellDispencerAreaForDrainingHolesX * (i-1)), outsideWallsThickness + marginsForDrainingHolesArea + ((gridCellDispencerAreaForDrainingHolesY / 2)) + (gridCellDispencerAreaForDrainingHolesY * (y-1)), - (mainBodyZ * 0.1)]) 
                cylinder(r=drainingHolesRadius, h=mainBodyZ * 2);
        }
    }
}
