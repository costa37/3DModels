"""Assembled review prototype. Feet z=0; tray top z=64.1 mm."""
from build123d import Location
from cadgen.assembly import AssemblyHelper
from egg_tray_parts import tray, leg, LEG_POSITIONS, UNDERSIDE_HEIGHT

def gen_step():
    asm=AssemblyHelper('egg_box_second_floor_prototype')
    top=asm.add(tray().moved(Location((0,0,UNDERSIDE_HEIGHT))), 'tray_twelve_egg_seats')
    for i,(x,y) in enumerate(LEG_POSITIONS,1):
        support=asm.add(leg(),f'replaceable_leg_{i}')
        target=asm.rigid_frame(top,f'leg_{i}_shoulder_seat',Location((x,y,UNDERSIDE_HEIGHT)))
        source=asm.rigid_frame(support,'leg_shoulder',Location((0,0,UNDERSIDE_HEIGHT)))
        asm.face_to_face(target,source)
    return asm.build()
