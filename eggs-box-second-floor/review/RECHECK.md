# Independent recheck — 2026-11-07

Historical audit before lifting cutouts and the user-selected 6.3 mm peg. See CURRENT-RECHECK.md for current status; the 0.2 mm radial clearance and snapshot references below are superseded.

Verdict: valid CAD and plausible FDM geometry; not ready for a full functional print. No geometry was changed in this audit.

## Main functional finding

The earlier selected 60 × 46 mm egg envelope does not fit the current 54 × 47 mm center spacing at 25 degrees if identical horizontal ellipsoids are centered in each pocket at the same elevation. In this simplified envelope model, column separation must be at least 56.562 mm (currently 54) and row separation at least 47.793 mm (currently 47), even before adding handling clearance. See egg-spacing-audit.json. This is a design-envelope failure, not a measurement of actual eggs. Real asymmetric eggs can seat differently, but compatibility with the intended larger size has not been demonstrated.

For the previously researched average 56 × 44 mm envelope, separations required are 53.136 and 45.585 mm. Margins along the center-separation directions are only 0.864 and 1.415 mm. These are not minimum surface-distance measurements and should not be described as guaranteed gaps.

Next design work must resolve egg orientation, seating depth and spacing together within the actual box footprint, using a pocket sample before a full tray. Merely making the pocket opening larger will not resolve neighboring egg collisions.

Other unresolved functional matters: 0.2 mm radial slip clearance does not provide positive leg retention; 13.8 mm elevation increase uses an uncertain photographed 50.3 mm baseline; box-floor contact, lower-egg side clearance and vertical clearance have no measured CAD representation. Load deflection and printed surface finish remain untested.

## Geometry

Reran solid validation for the assembly and tray: both passed. Earlier source intersection check found zero positive-volume interference for all ten tray/leg and leg/leg pairs. Twelve oval bowl surfaces and nominal 4 mm bowl floors were checked in the correction workflow. These checks do not validate the missing eggs or box.

## Exact STL printability measurements

DfAM skill measurements: tray-dfam.json and leg-dfam.json. Both STL files are watertight, single connected bodies, and in plausible millimeter scale. Tray bounds 224 × 148 × 12 mm; leg bounds approximately 10 × 10 × 58.1 mm. Nominal P1S envelope fit holds; slicer exclusions, brim and profiles remain unchecked.

Compared with /Users/costa/.codex/skills/dfam-check/references/process-limits.md, FDM/FFF rows: supported wall 1.2 mm; unsupported wall 1.6 mm; self-supporting angle 45 degrees from horizontal:

- Tray wall_thickness.min_mm=4.071 and p05_mm=5.5 exceed both wall defaults. Sampling is not exhaustive.
- Leg wall_thickness.min_mm=0.879 is below the wall defaults, but p05_mm=5.994 exceeds both. Locations are at a foot edge and shoulder edge. This is a local edge/sampling concern, not evidence of a 0.879 mm shaft wall: the leg is solid. Do not issue a whole-leg thin-wall failure from this minimum alone; inspect shoulder transition during joint testing.
- Tray overhangs.down_facing_area_below_limit_mm2=128.47 at 45 degrees, concentrated at the four blind socket ceilings. These require bridging or support consideration in the slicer. Bridge success was not tested.
- Leg overhangs.down_facing_area_below_limit_mm2=0 in foot-down orientation. This does not certify adhesion or strength.
- Six axis-aligned orientations were measured. Bowls-up has the lowest flagged area (128.47 mm²), compared with 21581.18 mm² bowls-down; retain bowls-up to protect egg-contact surfaces from support marks.

No new snapshots were required: this audit changed no visible geometry. Existing corrected four-view packet *_20261107T080159Z.png remains current. No slicing or printing occurred.
