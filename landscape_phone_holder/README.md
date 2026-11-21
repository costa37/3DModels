# Landscape phone holder

Open the full assembly in CAD Viewer:
http://127.0.0.1:3245/Users/costa/Downloads/GitHub/3DModels/landscape_phone_holder?file=phone_holder.step.py

The body has two table-edge screw clamps and a continuous 190 mm shelf with an 18 mm clear channel and a 10° backward tilt. The front lip rises 3 mm above the shelf and has rounded top edges. The body is 238 × 74.07 × 76 mm.

The tabletop is confirmed as 30 mm thick. The screw adjustment is designed for approximately 15–35 mm tabletops. The channel assumes a phone no thicker than 16 mm including its case, allowing 2 mm extra space. Screen clearance from the 3 mm lip depends on the actual phone's case and bezel. This covers a broad range of modern phones; unusually bulky cases may need more space.

## Files and quantities

- `phone_holder.step`: complete assembled CAD model for review; not a print layout.
- `holder_body.step`, `.stl`, `.3mf`: main shelf with both clamps; make 1.
- `clamp_screw.step`, `.stl`, `.3mf`: custom coarse screw; make 2.
- `pressure_pad.step`, `.stl`, `.3mf`: loose pressure pad; make 2.
- `thread_coupon.step`, `.stl`: optional small test of the female thread.
- `holder_geometry.py`: shared named dimensions and geometry source.
- `*.step.py`: buildable generators for each CAD artifact.
- `reference_original.3mf`: unchanged input copy. Reference photographs and profile are extracted from it.
- `dimension_checks.json`, `*validation.json`, `geometry_facts.json`, `interference.json`: verification results.
- Saved PNGs: assembled isometric, opposing isometric, top, side, and thread coupon views.

The screws are newly modeled custom 14 mm / 3.5 mm pitch threads with 0.30 mm radial female clearance; they are not interchangeable with the input model's screw. Print the small coupon and one screw to check thread fit before committing to the large holder. This is a geometry export, with no slicer settings or printer profile embedded.

Slide the clamps over the table edge, insert each screw from underneath, place its loose pad on the screw tip, and tighten gently until the pad contacts the table underside. The pads remain loose when not clamped. Place the phone in landscape on the narrow shelf with its back against the rear support.

Validation completed: five closed, positive-volume, topologically valid assembled parts; one connected main body; no assembly clashes above the 1 mm³ check threshold; measured channel 18 mm, lip 3 mm, tilt 10° and clamp axis spacing 214 mm. Multi-view CAD snapshots reviewed. The expensive optional boolean self-intersection check was omitted from the final topology validation. Physical fit, printed thread clearances, and load capacity have not been tested.

The inclined shelf and backrest are perpendicular. Geometry-envelope checks use a 190 × 90 × 16 mm phone and the confirmed 30 mm tabletop; neither envelope intersects the holder body. These checks verify CAD clearances, not physical printed fit. The latest previews are timestamped 20261120T090853Z.

Shelf-height update: phone-support floor lowered vertically by 20 mm, with its rear edge now 65 mm below the tabletop top. The backrest was extended along the existing 10° incline, moving the shelf outward by 3.53 mm. Table clamp jaws, screws, and pads retain their positions. Shelf length, channel depth and retaining lip remain 190 / 18 / 3 mm.
