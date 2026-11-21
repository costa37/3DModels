# One-piece support-free variant

Task: retain a monolithic two-point table clamp and landscape shelf, changing details to permit support-free FDM printing on a P1S with a 0.4 mm nozzle. Units mm. Service axes X along table, Y outward, Z up; tabletop top Z=0. Confirmed table thickness 30.

Plan: 238 mm long constant-profile C rail, with two screw stations 190 mm apart. Continuous upper and lower rails eliminate mid-air starts when printed along X. The shelf spans the full 238 mm so it starts on the bed with the rails. Retain lowered rear shelf height -65 mm, 18 mm channel, 10 degree back tilt and 3 mm lip. Extend table reach to 40 mm to house captive diamond-shaped printed nuts. Main service envelope approximately 238 × 82.1 × 76 mm.

Two nonthreaded diamond clearance holes and two diamond nut pockets have approximately 50 degree roofs in the supplied printing orientation (global X becomes print +Z). Printed nuts have 0.4 mm profile clearance and 0.3 mm axial clearance, 11 mm engagement length. Nut thread and screw thread are a custom matched 14 mm / 5.5 mm pitch form with flanks >50 degrees from horizontal when screw/nut print on axis. They are not compatible with the earlier variant.

Square-edged head and pad remove bed-facing round-over overhangs. Loose pad prints with socket upward. All small parts remain separate as in a normal screw clamp; clamps and shelf are one single fused solid. No commercial hardware is modeled.

Buildable source entries: assembly.step.py (service pose), body_print.step.py (bed-ready pose), screw.step.py, nut.step.py, pad_print.step.py. STEP is primary, STL/3MF secondary. Shared source variant_geometry.py. Primary printing envelope 76 × approximately 82.1 × 238 mm; allow for a brim. Brim is adhesion, not support.

Validate all solids and assembly interference; compare service body against a 30 mm tabletop and 190 × 90 × 16 mm phone envelope; measure channel, tilt, low lip, screw axes, pocket fit; inspect STEP facts and snapshots; run DfAM measure on every delivered print STL with a 45-degree limit. Aim for zero measured overhang area below 45 degrees, excluding plate contact. Report any remaining limitations and do not claim a physical print test.
