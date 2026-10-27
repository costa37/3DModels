"""150 x 410 x 110 mm magnetic drawer box, assembled sliding dovetails."""
from build123d import Location
from cadgen import srgb
from cadgen.assembly import AssemblyHelper
from drawer_box_geometry import half

def gen_step():
    asm=AssemblyHelper('magnetic_drawer_box')
    receiver=asm.add(half('female'),'drawer_box_female_half',color=srgb('#7EA5B5'))
    male=asm.add(half('male'),'drawer_box_male_half',color=srgb('#D5A56B'))
    fixed=asm.rigid_frame(receiver,'seam_floor',Location((0,0,0)))
    moving=asm.rigid_frame(male,'seam_floor',Location((0,0,0)))
    asm.connect(fixed,moving,label='vertical_dovetails_seated')
    return asm.build()
