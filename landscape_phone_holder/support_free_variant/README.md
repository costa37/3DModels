# One-piece phone holder — support-free variant

The phone shelf and both table clamp stations form **one connected printed body**. Continuous clamp rails let every part of the C-shaped cross-section start on the build plate. Two printed screws, two captive printed nuts, and two loose pressure pads provide the adjustable clamping mechanism.

Retained: 30 mm tabletop fit, 10° backward lean, 18 mm phone channel, 3 mm retaining lip, and the lowered shelf (rear edge 65 mm below the tabletop top). The continuous shelf is now 238 mm long. The fuller clamp rail uses more material than the original two narrow end mounts.

## Print files

| File | Quantity | Orientation already supplied |
| --- | --- | --- |
| `body_print.3mf` or `.stl` | 1 | C-shaped end on bed; 238 mm tall |
| `screw.3mf` or `.stl` | 2 | Knob on bed, screw axis upward |
| `nut.3mf` or `.stl` | 2 | Flat diamond face on bed |
| `pad_print.3mf` or `.stl` | 2 | Flat table-contact face on bed, socket upward |

Use the new parts together: the custom 14 mm / 5.5 mm pitch screw and nut are not compatible with the earlier holder's screws. Print one screw and one nut first to check free-running fit before printing the large body. The second copy can be added in Bambu Studio after the test.

Import the files as individual parts. Keep the body in the supplied orientation, with a 76 × 82.07 mm footprint and 238 mm build height. Disable supports and add an outer brim for adhesion. Use the P1S / 0.4 mm nozzle profile and the appropriate profile for your filament. These are geometry 3MFs, not pre-sliced printer projects: no material profile or process settings are embedded. Check the sliced layer preview before printing. Do not print `assembly.step` as an assembled unit.

The overhang screening found zero downward-facing area below 45° for all four print files. This is a geometry-based finding, not a completed physical print test. See `PRINTABILITY.md` and the `*_dfam.json` reports.

## Assembly

1. Before mounting the holder, drop each diamond nut into the matching pocket on the top face of the lower rail. The nut rests on a 4.7 mm ledge. The longer point of the asymmetric diamond follows the longer point of the pocket. The nut cannot rotate in the pocket.
2. Thread the new screw through each nut from below, then place a loose pressure pad on the screw tip.
3. Slide the continuous C rail over the table edge and tighten the screws gently until the pads meet the underside. The upper rail rests on the tabletop. The pads are loose when unclamped.
4. Put the phone in landscape in the inclined shelf. The 18 mm channel targets phones up to about 16 mm thick including their cases; the 3 mm lip's screen clearance depends on the actual bezel/case.

## CAD and review

`assembly.step.py` / `assembly.step` show the mounted pose. `body_print.step.py` / `body_print.step` show the printing pose. STEP is the primary validated geometry. Python generators and `variant_geometry.py` retain the dimensions and construction intent. `dimension_checks.json`, `validation.json`, `geometry_facts.json`, `interference.json` and the saved PNG snapshots record verification.

Mounted model: http://127.0.0.1:3245/Users/costa/Downloads/GitHub/3DModels/landscape_phone_holder?file=support_free_variant/assembly.step.py

Print orientation: http://127.0.0.1:3245/Users/costa/Downloads/GitHub/3DModels/landscape_phone_holder?file=support_free_variant/body_print.step.py
