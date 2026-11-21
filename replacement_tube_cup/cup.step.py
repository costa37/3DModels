"""Replacement cup: measured 14.2 mm male thread, interpreted 2.1 mm pitch.
Thread profile is approximate; print the fit test before the full cup.
Origin at base center; XY base, Z up; all dimensions millimeters.
"""
from build123d import (Align, Axis, Color, Cone, Cylinder, Face, Helix,
                      Plane, Polygon, Pos, sweep)

CUP_OD = 33.1
CUP_ID = 30.7
CUP_HEIGHT = 16.2  # measured by user
FLOOR = 2.4       # strengthened replacement
BOSS_OD = 16.5
BOSS_HEIGHT = 6.2
ORIGINAL_BORE_MIN_D = 12.9
DIAMETRAL_CLEARANCE = 0.30
BORE_MIN_D = ORIGINAL_BORE_MIN_D + 0.20  # crest relief for FDM
TUBE_THREAD_MAJOR_D = 14.2
THREAD_GROOVE_D = TUBE_THREAD_MAJOR_D + DIAMETRAL_CLEARANCE
THREAD_PITCH = 2.1  # interpreted as crest-to-crest axial spacing
THREAD_ROOT_HALF_WIDTH = 0.25
THREAD_BORE_OVERLAP = 0.15
THREAD_PROFILE_HALF_WIDTH = THREAD_ROOT_HALF_WIDTH + ((THREAD_GROOVE_D-BORE_MIN_D)/2 + THREAD_BORE_OVERLAP)/(3**0.5)
ROOT_SKIRT_HEIGHT = 1.5
ROOT_SKIRT_RADIUS = 9.75
LEAD_IN = 0.4
BASE = (Align.CENTER, Align.CENTER, Align.MIN)


def gen_step():
    cup_blank = Cylinder(CUP_OD/2, CUP_HEIGHT, align=BASE)
    cavity = Pos(0,0,FLOOR) * Cylinder(CUP_ID/2, CUP_HEIGHT, align=BASE)
    cup = cup_blank - cavity
    boss = Pos(0,0,FLOOR-0.1) * Cylinder(BOSS_OD/2, BOSS_HEIGHT+0.1, align=BASE)
    skirt = Pos(0,0,FLOOR-0.1) * Cone(ROOT_SKIRT_RADIUS, BOSS_OD/2,
                                     ROOT_SKIRT_HEIGHT+0.1, align=BASE)
    body = cup.fuse(boss, skirt)
    bore = Pos(0,0,FLOOR) * Cylinder(BORE_MIN_D/2, BOSS_HEIGHT+1, align=BASE)
    # Right-hand helical groove cut: extends beyond top and starts at floor.
    # Profile overlaps the bore slightly for robust booleans.
    start_z = FLOOR + 0.80
    path = Helix(THREAD_PITCH, BOSS_HEIGHT+THREAD_PITCH-0.13,
                 BORE_MIN_D/2, center=(0,0,start_z))
    profile = Plane.XZ * Polygon(
        (BORE_MIN_D/2-THREAD_BORE_OVERLAP, start_z-THREAD_PROFILE_HALF_WIDTH),
        (THREAD_GROOVE_D/2, start_z-THREAD_ROOT_HALF_WIDTH),
        (THREAD_GROOVE_D/2, start_z+THREAD_ROOT_HALF_WIDTH),
        (BORE_MIN_D/2-THREAD_BORE_OVERLAP, start_z+THREAD_PROFILE_HALF_WIDTH), align=None)
    groove = sweep(profile, path=path, is_frenet=True)
    # Cut groove before the coaxial bore; reverse order loses the groove in OCC.
    body = (body - groove) - bore
    entry = Pos(0,0,FLOOR+BOSS_HEIGHT-LEAD_IN) * Cone(
        BORE_MIN_D/2, BORE_MIN_D/2+LEAD_IN, LEAD_IN+0.01, align=BASE)
    body = body - entry
    body.label = 'replacement_cup_integral_female_thread_14p2_pitch2p1'
    body.color = Color(0.75,0.82,0.87)
    assert len(body.solids()) == 1
    return body
