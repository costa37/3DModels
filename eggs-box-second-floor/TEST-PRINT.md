# Two-pocket and leg fit test

Print one `test_sample.stl` and one `leg_print.stl` at 100% scale in mm. Sample is 108 × 52 × 12 mm. Use PLA, 0.16 mm layers, 3 walls and 15–20% infill as initial settings. Sample: flat underside on bed, oval pockets up. Leg: foot on bed, peg up; consider a brim for the narrow foot. Preview the 6.4 mm blind socket ceiling as a bridge; avoid supports on egg-contact surfaces. These are starting settings, not a validated slicer profile. No G-code was generated.

Place the sample flat on a table first. Run a fingertip over each bowl and remove strings or burrs. Place two of your largest usual eggs in the bowls with their long axes following the oval pockets. Record whether each seats securely, whether eggs touch each other, and whether they rock or catch on a rim. The current 54 mm spacing deliberately reproduces the suspect full-tray spacing: this is a diagnostic sample, not confirmation of fit.

Fit the separate leg into the underside socket. The shoulder should meet the underside; record whether the peg is loose, snug, or too tight. Do not force it. The joint is a slip fit without a lock.

For height only, hold the sample level inside the box with the foot on the appropriate flat land. One leg cannot make this sample stable: keep it supported by hand and do not leave eggs loaded on it. Check the underside against lower eggs without pressing on shells. The sample cannot establish full tray stability, bending strength, all foot contacts or spacing between rows. Do not print the full tray based only on a successful column-spacing test.

Validation: one valid CAD solid, two complete bowl surfaces with minimum z=4 mm, one socket verified clear with the mating peg envelope; STL watertight and one connected body. Measured sampled minimum thickness 3.684 mm, fifth percentile 5.173 mm, above the DfAM skill's conservative FDM supported/unsupported wall defaults of 1.2/1.6 mm. Sampling is not exhaustive. See review/test-sample-*.json and snapshots for evidence.

Review: http://127.0.0.1:3245/Users/costa/Downloads/GitHub/3DModels/eggs-box-second-floor?file=test_sample.step.py
