# Service balcony squeegee box

420 × 245 mm outside footprint; nominal 110 mm front / 170 mm rear sloping
rim. Edge rounding leaves the maximum rear crown at 169.78 mm. Rounded
R9 exterior plan corners, R6 interior corners, R3 internal floor transition,
and R0.8 exposed rim/base edges. 3 mm walls and 6 mm floor.

SQUEEGEE is centered on the front and engraved 1.2 mm deep, with 1.8 mm
wall remaining behind the letters. The connector profiles retain their
functional sharp mating edges as in tool_boxes revision 3.

## Files

- `box_geometry.py`: editable parameters and all geometry, self-contained.
- `squeegee_box.step.py` / `.step`: assembled model.
- `left_male.step.py` / `.step` / `.stl`: left printable half.
- `right_female.step.py` / `.step` / `.stl`: right printable half.
- `reference/sketch.png`: supplied sketch converted to PNG.
- `renders/`: assembled, rear, top and front views.
- `checks/`: CAD soundness, geometry and mating checks.
- `check_geometry.py`: reproducible geometry checks.
- `render_job.json`: reproducible views (run from repository root).
- `__cadgen__/`: derived CAD Viewer render cache.

## Printing and assembly

Print each STL separately, upright with its flat bottom on the plate, at
100% scale. Left footprint including dovetails: 216 × 245 mm; right:
209.95 × 245 mm. Maximum height approximately 169.78 mm.
The 245 mm depth leaves limited brim room on a 256 mm bed.
Lower the left male half into the right receiver from above. The same
0.10 mm rail relief, sloped seating stop and 0.08 mm locating-tab relief
as tool_boxes are retained. Rails have different lengths to match the
sloping box; no magnets are included. This is not a watertight joint.
Printed fit and slicer settings have not been tested for this new box.

## Verification

CAD validate passes for both assembly occurrences: closed, positive-volume
solids, no reported self-intersections. Each half is one solid. Width and
depth checked against 420 × 245 mm. Seated collision volume is zero;
upward translations of 0.2, 3, 7, 60 and 170 mm are collision-free.
A -0.2 mm downward displacement produces interference, checking the stop.
Front-wall sections verify recessed lettering and continuous backing
apart from the intentional 0.10 mm assembly seam. Four CAD views reviewed.
