Current print trial: use the three numbered full cups in `three_variants/`. See `three_variants/README.md`. Earlier cup and fit-test files below are retained as prior versions.

# Replacement tube cup

Current files are `cup.step.py`, `cup.step`, `cup.stl`, `cup.3mf` and the matching `thread_fit_test` files. Files named `cup_preview` and `preview_*` are superseded drafts and should not be printed.

## Dimensions and thread interpretation

Cup: OD 33.1 mm, ID 30.7 mm, height 16.2 mm. Wall 1.2 mm. Strengthened floor 2.4 mm. Integral boss OD 16.5 mm, height 6.2 mm above floor, with a tapered skirt at the base.

Tube male thread OD measured 14.2 mm. The reported 2.1 mm between threads is interpreted as axial crest-to-crest pitch. Assumed single-start right-hand thread. The original approximately four visible ridges are not used to override measured spacing.

Female groove maximum diameter 14.5 mm gives 0.30 mm diametral clearance over the measured male crest diameter. Minimum female opening 13.1 mm adds 0.20 mm to the original 12.9 mm opening. These are initial FDM fit allowances, not calibrated tolerances. The trapezoidal thread profile uses approximately 60-degree flanks and a flattened root; the original flank shape and male root diameter are unmeasured. No standard-thread designation is claimed.

## Physical fit check

Print `thread_fit_test.stl` first. It copies the exact blind threaded boss, floor, pitch and clearances from the cup. Its base disk is 20 mm diameter and total height is 8.6 mm. Place the flat base on the build plate with the threaded opening up. Test by hand: check it engages smoothly and seats without forcing. If too tight/loose, adjust the source clearance values and regenerate both files. A failed pitch match cannot be corrected by scaling the model.

The cup also sits flat-base-down, opening up. Geometry exports are unsliced. The 3MF files contain geometry only, with no P1S printer, filament or slicing profile. No G-code, slicing simulation or physical print has been performed.

## Files and verification

STEP is the primary CAD artifact; build123d Python is editable source. STL/3MF are secondary exports in millimeters. `cup_*` and `thread_fit_test_*` PNGs are saved CAD review snapshots; `reference/` contains decoded source photos. `*_refs.json`, `*_validation.json`, and `current_dimension_checks.json` record validation. `BRIEF.md` records original requirements and changes.

Exact BREP dimensions, one positive-volume solid per model, topology, BOP validity and helical groove presence are checked during validation. Geometry validity does not establish physical mating fit.
