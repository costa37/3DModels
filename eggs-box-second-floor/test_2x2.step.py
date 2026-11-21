"""Four exact tray pockets and one original leg socket, mm.

Crop in full-tray coordinates: X=0..112, Y=-23.5..74.
Local XY center maps to full-tray (56,25.25). Print underside down.
One leg is not a stable stand: support the other edges during testing.
"""
from build123d import Box, Pos, Align
from egg_tray_parts import tray, TRAY_THICKNESS

CENTER_X, CENTER_Y = 56.0, 25.25
LENGTH, WIDTH = 112.0, 97.5

def gen_step():
    crop=Pos(CENTER_X,CENTER_Y,-1)*Box(LENGTH,WIDTH,TRAY_THICKNESS+2,
        align=(Align.CENTER,Align.CENTER,Align.MIN))
    sample=tray(include_grips=True).intersect(crop)
    sample=Pos(-CENTER_X,-CENTER_Y,0)*sample
    sample.label='four_exact_oval_seats_54x47_pitch_one_original_socket'
    return sample
