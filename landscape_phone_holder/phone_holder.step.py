from build123d import *
from cadgen.assembly import AssemblyHelper
from holder_geometry import *
from math import degrees

def gen_step():
    asm=AssemblyHelper('landscape_phone_holder_two_clamps')
    body=asm.add(make_body(),'continuous_phone_shelf_and_two_clamps')
    screw=make_screw()
    pad=make_pad()
    # Explicit source placements use the same thread axis and helix phase as
    # the jaw tooling. The root body stays fixed. No table/phone is exported.
    z=screw_pose()
    tool_start=-JAW_GAP-LOWER_THICKNESS-PITCH
    phase=360*((z+KNOB_HEIGHT-0.2-tool_start)/PITCH)
    for side,x in [('left',-MOUNT_SPACING/2),('right',MOUNT_SPACING/2)]:
        s=asm.add(Pos(x,SCREW_Y,z)*Rot(0,0,phase)*screw,f'{side}_adjustment_screw')
        p=asm.add(Pos(x,SCREW_Y,-TABLE_THICKNESS-PAD_HEIGHT)*pad,f'{side}_pressure_pad')
    return asm.build()
