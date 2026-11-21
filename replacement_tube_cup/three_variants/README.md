Combined print file: `three_cups.stl` contains all three numbered cups, bases at Z=0, with 8.9 mm gaps. Import it once into Bambu Studio.

# Print these three numbered cups

Use `cup_1.stl`, `cup_2.stl`, and `cup_3.stl`. Each is a complete cup with its number recessed near the outside rim. Import all three into Bambu Studio to print together; place their flat bases on the plate with openings up. Exports are in millimeters. The 3MF alternatives contain unsliced geometry only, without a printer/filament profile.

Try #2 first, then compare #1 (closer fit) and #3 (more clearance). Test by hand without forcing. Choose the one that starts easily, screws on smoothly, seats properly, and has the least unwanted play. Physical fit has not been verified.

| Printed number | Fit intent | Thread groove maximum diameter | Thread minimum opening | Entry lead-in |
|---|---|---:|---:|---:|
| 1 | Closer | 14.4 mm | 13.0 mm | 0.4 mm |
| 2 | Medium | 14.6 mm | 13.2 mm | 0.5 mm |
| 3 | More clearance | 14.8 mm | 13.4 mm | 0.6 mm |

Thread groove axial width also increases slightly from #1 to #3. All share the interpreted 2.1 mm pitch and measured cup size 33.1 OD x 30.7 ID x 16.2 high. The reinforced 2.4 mm floor and boss height remain common. The exact original thread profile is unknown, so these are controlled fit variants.

`cup_family.py` is shared geometry source; `cup_1.step.py` etc. are editable entry generators. STEP files are primary CAD artifacts; STL/3MF are secondary exports. `BRIEF.md` explains all differences, `validation_dimensions.json` records exact checks, and snapshot PNGs show the validated geometry. These three supersede earlier single-cup and thread-fit-test files for this print trial.
