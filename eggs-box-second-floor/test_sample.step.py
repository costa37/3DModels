"""Two adjacent seats cropped from the exact tray, with one original socket.

Units mm; XY origin at crop center; flat underside z=0. Original crop:
X=0..108, Y=22..74. Pocket centers (27,47),(81,47), socket (54,66.5).
One leg does not make this a freestanding tray; support the sample by hand
when checking height, and never load it unsupported.
"""
from build123d import Box, Pos, Align
from egg_tray_parts import tray, TRAY_THICKNESS

SAMPLE_LENGTH=108.0
SAMPLE_WIDTH=52.0
CROP_CENTER_X=54.0
CROP_CENTER_Y=48.0

def gen_step():
    crop=Pos(CROP_CENTER_X,CROP_CENTER_Y,-1)*Box(
        SAMPLE_LENGTH,SAMPLE_WIDTH,TRAY_THICKNESS+2,
        align=(Align.CENTER,Align.CENTER,Align.MIN))
    sample=tray(include_grips=False).intersect(crop)
    sample=Pos(-CROP_CENTER_X,-CROP_CENTER_Y,0)*sample
    sample.label='two_oval_seats_54mm_pitch_and_one_leg_socket'
    return sample
