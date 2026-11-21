# Printability verification

Target: Bambu Lab P1S, 0.4 mm nozzle. FDM screening uses the 45 degree self-supporting angle and 1.6 mm unsupported wall default in `/Users/costa/.codex/skills/dfam-check/references/process-limits.md`. Material and layer height were not specified. All comparisons use the final STL files in this folder in their delivered print orientations.

| Part | Watertight | Sampled min thickness mm | Thickness p05 mm | Down-facing area below 45 degrees mm² |
| --- | --- | --- | --- | --- |
| body_print | True | 3.0 | 5.0 | 0.0 |
| screw | True | 1.403 | 8.0 | 0.0 |
| nut | True | 0.098 | 5.781 | 0.0 |
| pad_print | True | 2.7 | 2.7 | 0.0 |

✅ Watertightness: every `<part>_dfam.json: mesh.watertight` is true and `scale.units_suspect` is false.

✅ Overhang geometry: every `<part>_dfam.json: overhangs.down_facing_area_below_limit_mm2` is 0, against the 45-degree screening rule. This excludes faces on the build plate. Hole and pocket roofs are around 50 degrees from horizontal in `body_print`; thread flanks screen into the 50–60 degree bin. `support_volume.estimated_support_volume_mm3` is also 0, but this is a coarse geometry calculation, not slicer verification.

✅ Structural thickness screening: every `<part>_dfam.json: wall_thickness.p05_mm` exceeds 1.6 mm. The body has only 132 mesh faces and hence 132 ray samples: the sample-based minimum is not exhaustive. Nut and screw minima near thread terminations are local edge samples, not a claim that all thread features meet the wall limit. Printed thread quality and minimum printable crest features still need checking on the actual printer.

✅ CAD: seven assembled positive, closed, valid solids passed `inspect validate --skip-self-intersection`; the optional expensive boolean self-intersection check was omitted. `inspect interfere` found no clashes above 1 mm³ across all 21 assembly pairs (10 boolean tests, 11 excluded by disjoint bounds).

✅ Envelope: `dimension_checks.json` verifies one connected main solid, 76 × 82.07 × 238 mm bed-oriented size, 238 mm shelf length, 18 mm channel, 3 mm lip, 10 degree inclination, rear shelf height -65 mm, and zero volume overlap with the confirmed 30 mm tabletop and a 190 × 90 × 16 mm phone envelope. It also checks actual external screw thread material survives the booleans by comparing a midshaft section against the plain-core area.

Multi-view STEP snapshots were reviewed: assembly isometric/opposing, top/side, and the body in printing orientation. Small parts appear in the assembly, and their dedicated delivered STL files were measured separately.

Limits: no slicing or physical print was run. No strength certification, bed adhesion or warp test, or material-specific tolerance test has been performed. Bridge length, trapped volumes and slicer-specific thin-feature handling are not measured by this DfAM tool. Keep the supplied orientations; rotating the part to match its desk pose invalidates the support-free finding.
