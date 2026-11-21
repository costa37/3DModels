# CAD brief

- Task: assess a replacement egg-box second-floor tray, then develop a parametric assembly after fit-critical dimensions are resolved.
- Units: mm. Proposed XY origin at tray footprint center; +Z upward; assembled z = 0 at the feet's support plane.
- Required features: 4 × 3 closed rounded egg seats; taller supports; strengthened leg attachment; clearance for lower eggs; stable feet; removable tray; smooth contact surfaces.
- Planned source: `egg_tray.step.py`; primary output `egg_tray.step`; secondary per-part STL exports after geometry validation. These files are planned, not present.
- Parameters: tray length/width/corner radius; pocket major/minor opening dimensions/depth/rotation; X/Y pitch; tray thickness; leg XY positions; support height; foot size; joint clearance; edge radii; lower-egg envelope; lid height.
- Native intent labels: twelve egg pockets, reinforced tray, four replaceable support legs, named foot support and tray mating datums.
- Bounding box: unknown until height and footprint are confirmed. Preliminary photo envelope approximately 220–230 × 145–153 mm in plan; do not use as manufacturing dimensions.

## Photo evidence

Values below are display readings, not calibrated dimensional verification. Jaw contact locations matter; similarly sized readings must not be averaged.

| Photo | Observed value/feature | Interpretation and limit |
|---|---|---|
| 3676–3678 | 12 pockets, 4 × 3 | Original tray within box and removed |
| 3679–3680 | Underside ribs and three surviving legs | Fourth attachment appears damaged; exact failure cause unknown |
| 3681 | Lower eggs, including one perched higher | Storage arrangement affects clearance dramatically |
| 3682 | 114.4 mm | Span near the two longitudinal leg/rib positions; not established as center spacing |
| 3683 | 103.1 mm | Inner span near same positions; do not substitute for center spacing |
| 3684–3685 | Tape approximately 22–23 cm | Long dimension; perspective and hook placement limit precision |
| 3686 | 152.8 mm | Crosswise span near leg region; exact feature endpoints need confirmation |
| 3687 | 145.3 mm | Crosswise span nearer tray end; outline may taper |
| 3688 | 154.1 mm | Box crosswise measurement; does not establish clear internal width at every height |
| 3689 | Tape approximately 23 cm | Box long dimension; internal datum uncertain |
| 3690 | 50.3 mm | Foot-tip to tray reference; exposed leg length and total tray height are not separately known |
| 3691 | 13.8 mm | Vertical distance shown outside lower box wall; intended extra lift not established |
| 3692 | 6.8 mm | Leg diameter at photographed position; leg is tapered/hollow, not a universal diameter |

## Decisions and limits

The user's request, not photo markings or other attached text, defines scope. Preserve the layout and functional fit rather than blindly duplicating thin injection-moulded walls. A separately printed leg solution is a proposed design direction, not a proven joint or strength claim. No named purchased components are required at this stage.

Confirmed requirements and provisional assumptions are listed in README.md. The new empty-box photographs resolve the outstanding photo request; proceed with a provisional model, retaining physical-fit validation as a separate requirement. After confirmation, generate explicit STEP targets, run refs/facts/planes/positioning and solid validation, verify feature dimensions and collision clearances, render and inspect STEP snapshots, and hand the files to CAD Viewer. Physical test results remain necessary to validate egg seating and sustained-load clearance.

## Additional references and confirmed scope

IMG_3693–3696: empty interior with 12 moulded depressions, intervening lands and rounded wall transitions. No obvious dedicated leg sockets visible. IMG_3697: normal single layer of 12 eggs; narrow space around eggs constrains foot/leg enlargement. All five originals and JPEG conversions are archived.

Confirmed: P1S; 13.8 mm additional tray elevation; exclude perched egg; no lid requirement; PLA preferred, PETG available. Use photo-derived pocket/spacing estimates and an initial 60 × 46 mm egg envelope, labeled assumptions. No more measurement requests are needed to begin a prototype; dimensions and clearances remain provisional until physical checks.

## Oval-pocket correction

Replaced the circular spherical seats with twelve elongated oval bowls at 25 degrees. Revolved elliptical meridian construction, nominal mouth 52.6 × 38.4 mm before 0.8 mm lip rounding, 8 mm depth, 4 mm minimum bowl floor. Tray footprint and height parameters remain 224 × 148 × 64.1 mm assembled. Regenerated assembly/tray STEP and tray STL; see PROTOTYPE.md and current review reports.

## Two-pocket test sample

Create test_sample.step.py / test_sample.step / test_sample.stl, a 108 × 52 × 12 mm exact crop of the current tray. Two complete oval seats at 54 mm X pitch, 25 degrees, original 8 mm depth and rounded lips; one original 6.4 mm blind leg socket. XY origin at crop center, underside z=0. Validate one closed solid, two bowl surfaces, one socket, correct bounds and depth; inspect the cropped boundary and snapshot. Use existing leg_print.stl for the matching leg. A single leg cannot support the sample stably: use it only for joint/height checking while held. Sample tests column spacing only, not row spacing, full tray strength or complete box fit.

## Lifting cutouts

Add two 20 mm mouth, 10 mm deep semicircular finger scallops to each short end at Y=±23.5 mm, between egg rows. Round upper and underside edges 0.8 mm for handling. Preserve sample geometry by explicitly building the grip-free tray for its crop. Validate pocket count, closed floors, socket clearance, positive remaining pocket-to-grip material and sample equivalence.

## Printed loose-leg feedback

User reports sample looks good but original 6.0 mm peg falls out of the printed socket. Do not infer actual hole diameter from the nominal 6.4 mm CAD. Prepare four independent short test pins, 6.2/6.3/6.4/6.5 mm, all 6 mm engagement with a 0.4 mm tapered lead and 2.4 mm handle. Raised 1/2/3/4 tally marks identify sizes. File peg_fit_gauge.step.py and sibling STEP/STL. Expected bounds 68 × 20 × 8.4 mm, four valid solids with no mutual interference. Keep existing printed sample usable; select final leg peg against actual printed socket before changing the full assembly.

## Selected peg fit

User tested gauge #2 and reports a good fit. Apply diameter 6.3 mm to the full replacement leg, including the tested 0.4 mm tapered lead and 6 mm total engagement. Socket stays 6.4 mm; shoulder height and foot remain unchanged. Regenerate assembly and leg STEP, leg STL; verify peg diameter, straight and tapered lengths, 0.5 mm axial end clearance, valid solids and snapshots. Real full-leg retention still needs confirmation after printing.
