# Magnetic drawer box — fit revision 3

Outside dimensions: 150 × 410 × 110 mm. XY centered, underside at Z=0.
P1S, PLA, 0.4 mm nozzle. Printer profile/G-code is not included.
Main generator: magnetic_drawer_box.step.py. Editable dimensions and features:
drawer_box_geometry.py. STEP and STL outputs are derived from these sources.

## Physical test feedback and changes

The first physical sample showed a magnet that would not seat fully and a loose
joint with unequal bottom heights. Photos cannot quantify the actual clearance.
The old rail underside was sloped but the socket bottom was flat, allowing
vertical overtravel. That was a design omission, not an intended height step.

Revision 2 changes:
- Nominal socket lateral relief: 0.25 -> 0.10 mm.
- Seam gap: 0.10 mm in revision 3.
- Female socket now has a solid matching sloped seat at Z=Y+7, stopping the
  male at nominal equal floor/top height. The 45-degree male underside remains.
- Box magnet pockets confirmed Ø17.8 mm, depth 4.3 mm; 0.4 mm radial/deep
  entry chamfer eases insertion past the bed-contact edge.
- Revision 2 tested magnet samples: user confirmed Ø17.8 mm fits.
- Revision 3 retains the successful 0.10 mm dovetail relief and sloped seat.
- Two lower locating tabs at X=±57 mm, width 8 mm, reach 3 mm, height 6 mm.
  Female floor slots have 0.08 mm side/tip relief and are open from above.
  These constrain the lower seam without changing tall-rail fit. Tab undersides
  lie on the bed, requiring no suspended starting layer.

## Test before full print

Use connector_fit_sample_v3.stl. Remove the previous model from Bambu Studio.
The file contains only two connector pieces, each including a floor locator.
Print at 100% scale with the same PLA settings as the successful test. Check
that the pair seats level with firm hand pressure and that lower rocking is
reduced. Physical success of the new locator remains to be tested. The short
rail test does not establish straightness of the full-length rails.

Magnet fit is settled at Ø17.8 × 4.3 mm with the tested 0.4 mm entry chamfer.
A clearance hole has no positive magnet retention; check retention against
steel when lifting the box. The confirmed magnet sample need not be reprinted.

## Box geometry and use

3 mm walls; 6 mm floor; main inner vertical corners R6 and floor transitions R3.
Rounded reinforcing cheeks project into the cavity around the joints. Functional
mating edges remain defined for fit. Four underside magnets at X=±58, Y=±188 mm.
The pocket roof is 1.7 mm thick. Pocket ceilings bridge the opening during print.

Print halves upright, bottom down, separately. Envelopes: male 150 × 211 × 110 mm;
female 150 × 204.95 × 110 mm. Assemble by lowering the male rails into the female
slots. No glue/screws/clips for the connection. Assemble outside the drawer if
there is insufficient overhead room. The joint remains vertically removable;
the box has a narrow floor seam and is not watertight.

## Validation

CAD validity and positive solids checked for assembly, both halves and samples.
Geometry checks verify four pocket diameters/depths/chamfers, print envelopes,
collision-free sampled upward assembly positions and interference at -0.2 mm
male displacement, confirming the nominal downward stop. Saved results are in
checks/. Renders are in renders/. Printed fit and slicer warning state remain
subject to the physical test and Bambu Studio preview.
