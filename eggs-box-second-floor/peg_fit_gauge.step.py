"""Four independent fit pins for the existing printed 6.4 mm socket.

Print base down, same settings/material as the original leg, 100% scale.
1/2/3/4 raised marks = 6.2/6.3/6.4/6.5 mm diameter. Insert by hand only.
No guessed shrinkage compensation; choose against the real printed hole.
"""
from build123d import *
DIAMETERS=(6.2,6.3,6.4,6.5)
BASE_HEIGHT=2.4
PEG_LENGTH=6.0
LEAD_LENGTH=0.4

def fit_pin(diameter,mark_count):
    handle=extrude(RectangleRounded(14,20,2),BASE_HEIGHT)
    pin=Pos(0,4,BASE_HEIGHT)*Cylinder(diameter/2,PEG_LENGTH-LEAD_LENGTH,
        align=(Align.CENTER,Align.CENTER,Align.MIN))
    pin+=Pos(0,4,BASE_HEIGHT+PEG_LENGTH-LEAD_LENGTH)*Cone(
        diameter/2,diameter/2-LEAD_LENGTH,LEAD_LENGTH,
        align=(Align.CENTER,Align.CENTER,Align.MIN))
    handle+=pin
    for i in range(mark_count):
        handle+=Pos((i-(mark_count-1)/2)*2,-5,BASE_HEIGHT)*Box(
            0.8,4,0.4,align=(Align.CENTER,Align.CENTER,Align.MIN))
    handle.label=f'fit_pin_{diameter:.1f}mm_{mark_count}_marks'
    return handle

def gen_step():
    return Compound(label='four_independent_socket_fit_pins',children=[
        Pos(i*18,0,0)*fit_pin(d,i+1) for i,d in enumerate(DIAMETERS)])
