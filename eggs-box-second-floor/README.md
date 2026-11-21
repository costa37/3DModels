# Egg box — replacement second floor

Status: review prototype generated, 2026-11-07. STEP assembly and separate tray/leg STEP and STL files are available. Fit, egg clearance, strength, leg retention and surface finish are not physically validated. Not sliced; no G-code or printer job was sent.

## Files

- `reference/originals/`: all 22 supplied HEIC photographs, preserved.
- `reference/jpg/`: readable JPEG conversions of every photograph.
- `reference/contact-1.jpg` through `contact-3.jpg`: indexed photo overviews.
- `cad-brief.md`: design intent, measured evidence, unknowns and validation plan.

## Assessment

The original has 12 closed egg pockets in a 4 × 3 layout, underside stiffening ribs and four slender leg positions; one leg is missing with damage at its attachment. A replacement should reinforce the leg-to-tray load path, not merely lengthen equally slender legs. Longer legs increase bending leverage during handling.

The photos indicate a footprint roughly 220–230 mm long and about 145–153 mm across the measured features. This fits nominally within the P1S 256 × 256 × 256 mm envelope. Final plate placement must include brim and the active slicer profile's excluded regions. Printer name `PS1` is provisionally interpreted as `P1S`.

Manufacturer specification: https://store.bblcdn.com/63ec128d3b8f4f32b7d60fe4dd112ed3.pdf

Preferred development direction: a single tray with closed, rounded pockets and a flat printable underside, plus four separately printed, mechanically retained legs. This allows the pocket interiors to face upward without support contact, and allows a leg to be replaced independently. Joint geometry and foot locations must be determined from the box and lower egg layout. A thicker flat-backed tray may consume clearance or raise the eggs relative to the original thin shell, so the height budget must use the new geometry.

Use rounded pocket transitions and no sharp contact rims; begin with a 0.4 mm nozzle and 0.12–0.16 mm layers as prototype settings. These are starting assumptions, not a verified slicing recipe. Keep seams away from the main contact area where possible, remove strings and burrs, and inspect a single-pocket sample by touch and with a sacrificial egg before printing the complete tray. FDM will retain layer texture; an injection-moulded gloss finish is not assumed. Choose the final material and settings after identifying available filament. Surface smoothness alone does not establish food-contact suitability or dishwasher compatibility.

## Confirmed requirements and prototype assumptions

- Printer: Bambu Lab P1S, confirmed by user.
- Raise the tray by 13.8 mm relative to the original. This is a tray elevation change; leg length must account for the new tray and joint geometry.
- Lower layer contains 12 normally seated eggs; exclude the extra perched egg.
- No lid-clearance requirement.
- PLA preferred; PETG available if needed.
- User accepts photo-based estimates and a representative egg envelope for a first prototype rather than exact reproduction. Initial egg envelope: 60 × 46 mm, a design assumption, not a maximum for all large eggs. A published commercial-large-egg sample averaged 56 × 44 mm: https://www.nature.com/articles/s42005-025-02087-0
- Additional empty-bottom photo request fulfilled by IMG_3693–3696. IMG_3697 shows the normal 12-egg arrangement.
- No further photos or measurements required to begin the provisional CAD prototype. Physical fit, pocket seating and loaded clearance remain unverified.

## New photo review

IMG_3693 and IMG_3694 clearly show the empty interior and its 4 × 3 moulded egg depressions. IMG_3695 and IMG_3696 show closer views of the intervening lands and wall-to-floor transitions. No obvious dedicated leg sockets are visible; this is a visual observation, not proof that no small locating features exist. Feet should land on the relatively flat areas outside the depressions, avoiding the sloped pocket rims and rounded wall transitions. Preserve the original leg locations as the initial reference rather than relocating feet freely.

IMG_3697 shows the lower eggs occupy most of the pocket field, so broad feet or thickened legs must be checked against egg sides as well as the empty floor. Photographs do not establish land elevations, pocket depths or absolute egg height. Plan a footprint/joint test and then a loaded-clearance check; do not describe the design as physically validated from these photos alone.

## Validation before use

- Define z = 0 at the foot support surface. Let H be the top tray reference height, D the maximum downward extent of the tray/cups/ribs below that reference, E the tallest lower egg elevation, and S the allowance for deflection and dimensional error. Require H - D - E - S >= 5 mm as an initial design target, subject to physical confirmation.
- With a lid, let U be the upper egg protrusion above the tray reference and L the lid underside elevation. Require L - H - U >= 5 mm as an initial target. Raising the tray improves the lower gap and reduces the upper gap by the same amount.
- Check leg and foot volumes against lower eggs, lower pockets, wall taper and bottom corner radii, including the insertion path.
- Validate STEP solids and dimensions; export and inspect mesh; review CAD snapshots; slice with the actual P1S/nozzle/material profile and inspect support placement and layer paths.
- Test a single pocket and leg joint first, then dry-fit the tray. Test full-load deflection using nonfragile equivalent weights and inspect after sustained loading before using eggs. Do not infer strength from CAD validity.

See PROTOTYPE.md for the generated geometry, review links, validation and remaining physical checks. The earlier design discussion above describes intent; PROTOTYPE.md describes the actual first model.

## Recheck finding

The independent audit found that centered horizontal 60 × 46 mm egg envelopes overlap at the current pocket spacing. The design needs a seating/spacing revision before a full functional print. Both STLs are watertight; bowls-up orientation minimizes flagged overhang area. See `review/RECHECK.md` and the accompanying measurement JSON files.
