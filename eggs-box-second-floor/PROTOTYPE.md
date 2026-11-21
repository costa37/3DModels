# Oval-pocket review prototype

This is a provisional fit-test design, not a validated production replacement.

## Review

- [Assembled tray](http://127.0.0.1:3245/Users/costa/Downloads/GitHub/3DModels/eggs-box-second-floor?file=egg_tray.step.py)
- [Separate printable tray](http://127.0.0.1:3245/Users/costa/Downloads/GitHub/3DModels/eggs-box-second-floor?file=tray_print.step.py)
- [Separate leg, four required](http://127.0.0.1:3245/Users/costa/Downloads/GitHub/3DModels/eggs-box-second-floor?file=leg_print.step.py)

All three have sibling STEP files. Tray and leg also have STL exports. `egg_tray_parts.py` holds the shared parameters. Viewer links require the local server to remain running.

## Actual geometry

- Tray footprint 224 × 148 mm, rounded corners; thickness 12 mm.
- Twelve elongated oval bowls, 4 × 3, angled 25° to the long tray axis; pitch 54 × 47 mm; depth 8 mm and minimum bowl floor 4 mm. Each cutting surface is made by revolving an elliptical meridian with radii 37 × 27 mm. The nominal opening before lip rounding is approximately 52.6 × 38.4 mm. These are side-resting cradles based on the photographed layout, not an exact reproduction of the original pockets. Real-egg seating still needs a physical check.
- Pocket lips and top outside edges have 0.8 mm rounding. Apparent radial lines in CAD edge views are surface seams, not physical grooves.
- Provisional assembled top 64.1 mm = photographed reference 50.3 + requested increase 13.8 mm. The photo's exact original datum is uncertain. Thus 13.8 mm is an exact parameter change relative to an assumed baseline, not a verified physical elevation increase.
- Flat underside at 52.1 mm above the foot plane. No ribs or bowls project beneath it. This approach favors flat-bed printing but uses more material than the original shell.
- Four supports centered at X = ±54, Y = ±66.5 mm. Shaft about 8–9 mm diameter; seating shoulder 10 mm. Each has a 6.3 mm diameter, 6 mm long peg entering a 6.4 mm diameter, 6.5 mm deep blind socket.
- The peg joint is a prototype slip fit with 0.05 mm nominal radial and 0.5 mm end clearance. It is NOT positively locked. Do not lift a loaded tray assuming loose legs will stay attached. Gauge #2 was accepted by the user; retention with a full-length leg still requires a physical test.
- Foot locations approximate the original layout; correspondence to the box's flat lands and clearance from lower egg sides remain unverified.

## Verification

Current assembly, tray and leg passed the CAD skill's solid validation. Bounding dimensions and major planes were inspected. A leg shoulder-to-tray mating check returned zero Z translation; tray thickness was measured between its underside and top planes. Source geometry checks record all part-pair intersection volumes and parameter clearances in `review/geometry-checks.json`.

The final four-view snapshot packet is `review/*_20261107T170638Z.png`, rendered directly from the current assembly generator and visually reviewed. Earlier timestamped packets are superseded. Review found the intended 12-oval-bowl pattern, four legs, flat underside and consistent assembly height. Physical eggs and the original box are not present in the CAD assembly, so these views cannot prove collision clearance with them.

## Printing scope

Tray STL is in bowls-up orientation, flat underside on Z=0; print four copies of the leg STL separately. Footprint fits the nominal P1S envelope. Blind socket roofs may require short bridges: inspect those layers in Bambu Studio. Mesh DfAM analysis has been completed; see review/RECHECK.md. No slicing, print-time estimate, material consumption estimate or physical load test has been completed.

PLA and 0.12–0.16 mm layers are provisional starting choices. Test a small pocket/joint sample before the full tray. Check lower egg clearance, leg seating, retention, rocking, pocket finish and loaded deflection. CAD smoothness does not guarantee the printed surface finish. Do not hot-wash or dishwasher-clean this PLA prototype.

## Recheck finding

The independent audit found that centered horizontal 60 × 46 mm egg envelopes overlap at the current pocket spacing. The design needs a seating/spacing revision before a full functional print. Both STLs are watertight; bowls-up orientation minimizes flagged overhang area. See `review/RECHECK.md` and the accompanying measurement JSON files.

## Lifting-cutout correction

Added two semicircular finger scallops to each short end, centered between egg rows at Y=±23.5 mm. Nominal mouth 20 mm, depth 10 mm; top and underside edge rounding 0.8 mm. Four cutout walls and all twelve bowls verified; minimum bowl-surface to cylindrical grip-wall distance 3.279 mm (not a global wall-thickness measurement). Updated assembly and tray pass solid validation. Physical finger access with the box and eggs in place remains a fit-test item.

The sample explicitly uses `tray(include_grips=False)`, preserving its original crop and pocket/socket construction. Its existing STL was left untouched; no replacement sample print is needed for this correction. STEP comparison bounds agree within 0.000001 mm and volume differs by 0.0074 mm³ out of 53748 mm³, within roundtrip comparison tolerance; boolean symmetric difference proved unreliable and is not reported as an equality check. See review/grip-checks.json.

This change addresses lifting access only. Egg spacing, leg retention and physical clearance concerns in review/RECHECK.md remain unresolved.

## User-selected leg fit

User reports gauge #2 is a good fit in the printed sample. Applied that 6.3 mm diameter and its 0.4 mm tapered lead to the full leg. Engagement is 5.6 mm cylindrical plus 0.4 mm taper, total 6 mm. Shoulder height remains 52.1 mm, preserving the assumed assembled tray elevation of 64.1 mm. Socket remains 6.4 mm diameter by 6.5 mm deep. Updated leg STL and STEP, assembly STEP and CAD previews. Both entries pass solid validation; measured peg diameter and length match the selected gauge; checked leg has zero positive intersection volume with the tray. See review/selected-peg-checks.json.

Print one updated leg with the same settings as the successful gauge, fit it to the existing sample, and check seating and retention under its full weight before making four. This is a friction-fit joint, not a positive lock. Full-tray egg clearances and loaded strength remain provisional.

## Latest verification after peg selection

See review/CURRENT-RECHECK.md for the current audit and physical test status. Earlier recheck notes describe the earlier 6.0 mm peg; the current peg is 6.3 mm and matches the accepted gauge #2. The sample was reported good except for the original loose leg. This does not establish full-tray row spacing or lower-egg clearance.
