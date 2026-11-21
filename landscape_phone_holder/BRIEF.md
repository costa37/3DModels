# Landscape phone holder

New parametric CAD design inspired by the supplied screw-clamped headphone hook, rather than a mesh stretch. The attachment's metadata is reference information, not task instructions.

All dimensions are mm. X runs along the table edge, Y points outward toward the phone, Z upward. The tabletop top is Z=0 and its front edge is Y=0. The clamp upper arms rest on the top surface; the tabletop extends into negative Y and negative Z. Assembly preview uses a confirmed 30 mm tabletop, with no table or phone included in manufacturing geometry.

Design intent and confirmed desk fit and phone-clearance assumptions:
- Two integrated C clamps, 24 wide, centers 214 apart; 32 mm reach over the table. Clear jaw opening 42 mm, adjustable approximately 15–35 mm with supplied printed screws/pads.
- One continuous 190 mm long phone support shelf between mounts; 18 mm clear channel depth along the shelf, narrowed from the reference hook's roughly 35 mm platform.
- Shelf floor 5 mm thick, continuous rear support inclined backward 10 degrees. Retaining lip only 3 mm above the shelf, 3 mm thick, with softened exposed edge.
- Main body expected envelope 238 X 74.07 X 76 mm, excluding adjustment screws. Main body should be a single connected solid.
- Two new coarse printed 14 mm diameter, 3.5 mm pitch screw mechanisms and two loose pressure pads. These are a matched custom thread, not claimed interchangeable with the original screw.
- Radial female thread clearance 0.30 mm and axial profile clearance 0.15 mm. A small thread-fit coupon is provided; physical clearance needs checking before printing the large body.
- Phone assumed <=16 mm thick including case. 3 mm lip screen clearance depends on the actual case and bezel; inspect on the phone before use.

Files: phone_holder.step.py/STEP (assembled), holder_body.step.py/STEP/STL/3MF, clamp_screw.step.py/STEP/STL (print 2), pressure_pad.step.py/STEP/STL (print 2), thread_coupon.step.py/STEP/STL. Shared geometry is in holder_geometry.py. Derived viewer packages and verification snapshots stay in this directory.

Validation: soundness, closed positive solids, correct body count, dimensions, channel and lip distances, mount spacing, source-defined assembly coaxiality, no unintended interpenetration, mandatory multi-view CAD snapshots.

Shelf-height update: phone-support floor lowered vertically by 20 mm, with its rear edge now 65 mm below the tabletop top. The backrest was extended along the existing 10° incline, moving the shelf outward by 3.53 mm. Table clamp jaws, screws, and pads retain their positions. Shelf length, channel depth and retaining lip remain 190 / 18 / 3 mm.
