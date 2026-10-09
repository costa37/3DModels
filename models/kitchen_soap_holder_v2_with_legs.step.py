"""Preview assembly: existing holder plus four original tapered glue-on legs.

Millimeters; holder bottom z=0. Legs extend down to z=-10 with 20 mm top
ends and 10 mm feet, matching KitchenSoapAndSpongeHolderOnlyLegs-13Feb2025.
Two A-side leg centers at (12,10)/(12,90); D uses (244,12)/(244,88).
Validate 5 solids, 256x100x120 envelope, flush glue interfaces, no overlap.
This assembly is a visualization and does not alter the no-legs SCAD.
"""
from pathlib import Path
import importlib.util
from build123d import Cone, Align, Pos, Location, Color
from cadgen.assembly import AssemblyHelper

spec = importlib.util.spec_from_file_location('holder_source', Path(__file__).with_name('kitchen_soap_holder_v2_view.step.py'))
holder_source = importlib.util.module_from_spec(spec)
spec.loader.exec_module(holder_source)
LEG_HEIGHT, GLUE_RADIUS, FOOT_RADIUS = 10, 10, 5
LEG_CENTERS = [(12,10),(12,90),*holder_source.GLUE_CENTERS]


def gen_step():
    asm = AssemblyHelper('Kitchen_soap_holder_v2_with_four_glued_legs')
    holder = asm.add(holder_source.gen_step(), 'Holder_C_D_open_grids')
    holder.color = Color(0.60, 0.66, 0.70)
    for label, (x,y) in zip(['A_front_leg','A_rear_leg','D_front_leg','D_rear_leg'], LEG_CENTERS):
        leg = Pos(0,0,-LEG_HEIGHT)*Cone(FOOT_RADIUS,GLUE_RADIUS,LEG_HEIGHT,
                                     align=(Align.CENTER,Align.CENTER,Align.MIN))
        leg = asm.add(leg,label)
        leg.color = Color(0.25,0.28,0.30)
        seat = asm.rigid_frame(holder,label+'_glue_seat',Location((x,y,0)))
        top = asm.rigid_frame(leg,'wide_glue_end',Location((0,0,0)))
        asm.face_to_face(seat,top,label=label+'_glued_to_bottom')
    return asm.build()
