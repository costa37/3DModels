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

// C/D open-grid floor. D has solid corner pads for 20 mm glue-on legs.
gridOpening = 8;
gridRib = 2.4;
gridBorder = 4;
spongeLift = 1.2;
legGluePadSize = 24;
sectionCX = dispenserSectionLengthX + specialWallForCutting / 2;
sectionDX = dispenserSectionLengthX + spongeOneSectionLengthX + insideWallsThickness / 2;
// D uses a denser coverage envelope; edge cells are clipped to a 2.4 mm border.
function gridCount(length, expanded = false) = max(1, expanded ?
    ceil((length - 2 * gridRib + gridRib) / (gridOpening + gridRib)) :
    floor((length - 2 * gridBorder + gridRib) / (gridOpening + gridRib)));
function gridSpan(n) = n * gridOpening + (n - 1) * gridRib;
function gridStart(length, expanded = false) = (length - gridSpan(gridCount(length, expanded))) / 2;

module legGluePads() {
    for (y = [legGluePadSize / 2, mainBodyY - legGluePadSize / 2])
        translate([mainBodyX - legGluePadSize / 2, y, -1])
            cylinder(d=legGluePadSize, h=outsideWallsThickness + 2, $fn=120);
}

module spongeGridHoles(startX, lengthX, keepLegPads = false) {
    border = keepLegPads ? gridRib : gridBorder;
    difference() {
        intersection() {
            union() {
                for (col = [0 : gridCount(lengthX, keepLegPads) - 1])
                    for (row = [0 : gridCount(holeY, keepLegPads) - 1])
                        translate([startX + gridStart(lengthX, keepLegPads) + col * (gridOpening + gridRib),
                            outsideWallsThickness + gridStart(holeY, keepLegPads) + row * (gridOpening + gridRib), -1])
                            cube([gridOpening, gridOpening, outsideWallsThickness + 2]);
            }
            translate([startX + border, outsideWallsThickness + border, -1])
                cube([lengthX - 2 * border, holeY - 2 * border, outsideWallsThickness + 2]);
        }
        if (keepLegPads) legGluePads();
    }
}

module spongeSupportRibs(startX, lengthX, expanded = false) {
    if (gridCount(lengthX, expanded) > 1)
        for (col = [0 : gridCount(lengthX, expanded) - 2])
            translate([startX + gridStart(lengthX, expanded) + gridOpening + col * (gridOpening + gridRib),
                       outsideWallsThickness, outsideWallsThickness])
                cube([gridRib, holeY, spongeLift]);
}

// Main body
module holderBody() {
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

    // Open drainage grids in C and D; preserve D's two outer glue pads.
    spongeGridHoles(sectionCX, holeSpongeOneX);
    spongeGridHoles(sectionDX, holeSpongeTwoX, true);
}
}

union() {
    holderBody();
    spongeSupportRibs(sectionCX, holeSpongeOneX);
    spongeSupportRibs(sectionDX, holeSpongeTwoX, true);
}
