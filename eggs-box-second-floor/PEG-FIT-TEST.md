# Fixing the loose leg

The original leg peg is 6.0 mm in a nominal 6.4 mm socket, leaving 0.4 mm diametral clearance. User confirmed the real print is loose and falls out. Preserve the printed sample; select the revised peg diameter against its actual printed socket.

Print peg_fit_gauge.stl once at 100% scale, PLA and the same nozzle, layer height and extrusion settings as the original leg. This contains four separate small handle-and-pin pieces. Place the flat handles on the bed with pins pointing up. Raised tally marks identify the nominal diameters:

| Marks | Peg diameter |
|---|---|
| 1 | 6.2 mm |
| 2 | 6.3 mm |
| 3 | 6.4 mm |
| 4 | 6.5 mm |

The pins reproduce the original 6 mm engagement length, with a 0.4 mm tapered lead for insertion. Full pin height above handle remains 6 mm. Try smallest first, with the sample empty and held securely. Seat the handle against the underside; do not force or hammer a pin. Select the smallest size that seats fully by hand, stays attached under its own weight and gentle handling, and can be removed by hand. Tell Codex the mark count and whether it is snug or still loose, and stop at a diameter that is too tight.

The gauge tests diameter fit; it does not prove retention under the weight/leverage of a full leg, repeated use, or a loaded tray. The chosen final leg still needs an insertion and retention check. If all sizes are loose or none seat fully, report that instead of forcing them. Original full-leg and tray CAD are intentionally not assigned a guessed new interference size before this test.

CAD check: four closed positive-volume solids, measured pin diameters, expected overall bounds 68 × 20 × 8.4 mm. STEP and STL supplied, preview snapshot in review/. Test pins only; do not use them as tray legs.

## Result applied

User selected two marks (6.3 mm). That tested peg profile is now in leg_print.step.py / leg_print.step / leg_print.stl and the full assembly. Print one replacement leg first; no new pocket sample is needed.
