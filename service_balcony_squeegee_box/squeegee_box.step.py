from build123d import Location
from cadgen import srgb
from cadgen.assembly import AssemblyHelper
from box_geometry import half

def gen_step():
    asm=AssemblyHelper('service_balcony_squeegee_box')
    right=asm.add(half('female'),'right_female_half',color=srgb('#86AEB2'))
    left=asm.add(half('male'),'left_male_half',color=srgb('#86AEB2'))
    fixed=asm.rigid_frame(right,'seam_floor_seated',Location((0,0,0)))
    moving=asm.rigid_frame(left,'seam_floor_seated',Location((0,0,0)))
    asm.connect(fixed,moving,label='vertical_sliding_dovetails_seated')
    return asm.build()
