# Replacement threaded tube cup — provisional design

New one-piece replacement for the white cup and detached internally threaded boss in IMG_3701–3705. Millimeters. Base centered at origin, XY floor, +Z toward cup opening. Tube screws into a blind female threaded boss inside the cup. No hole through the cup floor.

User dimensions: cup OD 33.1, ID 30.7 (1.2 radial wall); boss OD 16.5, internal crest diameter assumed 12.9, boss height 6.2, approximately four visible thread ridges. Printer P1S, nozzle 0.4.

Fit-critical measurements requested: tube thread major diameter, axial distance across three thread gaps. Four visible ridges alone does not uniquely determine pitch.

Provisional parameters for visual review only: cup height 16.2 (subsequently measured by user); floor thickness 2.4; boss rises 6.2 above floor; right-hand single-start pitch 1.55; internal groove major diameter 14.5; minimum bore 12.9. These thread parameters are NOT a verified match. No claim of a standard thread. No additional fit allowance until mating dimensions are known.

Reinforcement: integral 2.4 floor and 1.5-high conical fillet-like skirt around the boss foot, outside its 16.5 straight portion. Cup diameters retained. Thread is a real helical trapezoidal groove, not stacked rings. Boss entrance has a 0.4 lead-in.

Expected bounds: 33.1 x 33.1 x 16.2. One closed positive-volume solid. Validate topology, self-intersection, bounds, cup diameters, floor, boss height, bore and cavity sections; snapshot opposing angles, top and front. Primary STEP plus parametric Python, provisional STL/3MF, reference photos, validation and preview files all kept in this folder.

## Measured-thread revision

User confirms cup height 16.2, male crest OD 14.2, and "2.1 mm between two threads (from outside of the threads)". Interpret the latter as crest-to-crest pitch 2.1, with right-hand single-start and 60-degree trapezoidal profile assumptions. Current `cup.step.py`: groove major diameter 14.5 (0.30 diametral clearance), bore minor 13.1 (0.20 relief over original 12.9). Original ring OD 16.5 and height 6.2 retained. Physical fit remains unverified. Add `thread_fit_test.step.py`, a 20 mm disk with the exact same blind boss, total height 8.6, to check fit economically. Supersedes `cup_preview` artifacts.
