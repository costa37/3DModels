# Support-free print assessment — current lowered holder

Printer: Bambu Lab P1S, 0.4 mm nozzle. Material and layer height unspecified. Assessment is geometric, using conservative FDM defaults; no slicer or physical print was run.

Verdict: the current complete design cannot be recommended as reliably support-free. The mesh is watertight, but all six tested axis-aligned orientations retain downward faces below the 45-degree screening limit.

Main body measurements (`holder_body_dfam_measure.json`):
- `mesh.bbox_mm`: 238 × 74.07 × 76 mm.
- `mesh.watertight`: true; one connected body.
- `wall_thickness.p05_mm`: 5.0 mm, above the 1.6 mm unsupported-wall screening limit. Sampled minimum 0.147 mm occurs on the internal thread boundary; this is a local edge sample and not evidence that the full structural wall is that thin.
- `overhangs.down_facing_area_below_limit_pct`: 11.2% in the modeled upright orientation. `largest_faces_below_limit` includes the shelf underside at 10 degrees from horizontal and the clamp upper-arm undersides at 0 degrees.
- Best tested axis orientation: `rot_plus_90_y`, 1.9% / 1172.43 mm² flagged surface, 238 mm build height. This still has unsupported transitions where the end mounts and cradle start. Low flagged area alone is not proof of support-free printability.

Other parts:
- Screws: print knob down as a starting orientation, but the measured thread underside is roughly 24 degrees from horizontal, below the conservative 45-degree rule. Its short radial reach may print acceptably, but fit and finish require a physical coupon test. No support-free guarantee.
- Pressure pads: flip 180 degrees around X, flat table-contact face on the plate and socket upward. Flagged area falls from 6.9% to 1.4%, with only small rounded lower edges remaining. This is the most promising support-free component; verify the sliced first layers.

Concrete redesign for dependable support-free printing: separate the two clamps from the connecting shelf so each clamp can print on its broad side at roughly 24 mm build height. Give the shelf a bed-facing flat surface and >=45-degree chamfers beneath exposed protrusions. Revise the printed thread load flanks to >=45 degrees, then recheck fit, overhangs and slicing. Splitting introduces joints which need a separate fit/strength design.

Limits source: /Users/costa/.codex/skills/dfam-check/references/process-limits.md, FDM column: 45 degrees from horizontal; 1.6 mm unsupported wall. These are screening rules, not a nozzle-specific guarantee. Bridge reach was not measured by this tool. Support-volume estimates are coarse upper bounds and are not used as a slicer-material prediction.

Manufacturer machine specification: https://store.bblcdn.com/s5/default/78c105c0c92642a99e64b4b0b0f3ca6a.pdf — P1S nominal build volume 256 × 256 × 256 mm.
