from build123d import *
from cadgen.assembly import AssemblyHelper
from variant_geometry import *

def gen_step():
    asm=AssemblyHelper('support_free_one_piece_landscape_phone_holder')
    asm.add(make_body(),'one_piece_clamp_rail_and_phone_shelf')
    screw=make_screw();nut=make_nut();pad=make_pad()
    z=screw_pose()
    phase=360*((z+KNOB_HEIGHT-0.2-(nut_z()-PITCH))/PITCH)
    for side,x in [('left',-MOUNT_SPACING/2),('right',MOUNT_SPACING/2)]:
        asm.add(Pos(x,SCREW_Y,z)*Rot(0,0,phase)*screw,side+'_clamp_screw')
        asm.add(Pos(x,SCREW_Y,nut_z())*nut,side+'_captive_diamond_nut')
        asm.add(Pos(x,SCREW_Y,-TABLE_THICKNESS-PAD_HEIGHT)*pad,side+'_loose_pressure_pad')
    return asm.build()
