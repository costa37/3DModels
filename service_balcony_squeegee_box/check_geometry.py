"""Spec and connector motion checks; run with project CAD Python."""
import json
from pathlib import Path
from build123d import Box, Location, Align
from box_geometry import half, blank, WIDTH, DEPTH, BACK_HEIGHT

def volume(shape):
    return 0. if shape is None else sum(s.volume for s in shape.solids())

a,b=half('male'),half('female')
report={}
for name,part in [('left_male',a),('right_female',b)]:
    bb=part.bounding_box()
    report[name]={'valid':part.is_valid,'solids':len(part.solids()),'volume_mm3':part.volume,'bounds_mm':list(bb.size),'bottom_z':bb.min.Z,'top_z':bb.max.Z}
    assert part.is_valid and len(part.solids())==1 and part.volume>0
    assert bb.size.X<256 and bb.size.Y<256 and abs(bb.min.Z)<1e-5
motion={}
for z in [0, .2, 3, 7, 60, 170, -.2]:
    v=volume(a.moved(Location((0,0,z))) & b)
    motion[str(z)]=v
    assert v<1e-5 if z>=0 else v>1
report['male_translation_z_collision_mm3']=motion
bb=(a+b).bounding_box()
report['assembled_bounds_mm']=list(bb.size)
assert abs(bb.size.X-WIDTH)<1e-5 and abs(bb.size.Y-DEPTH)<1e-5
assert abs(bb.size.Z-BACK_HEIGHT)<.3
report['height_note']='110/170 mm nominal sloping top before 0.8 mm edge rounding; rounded rear crown is slightly below 170 mm.'
# Prove engraving cuts front wall without penetrating its 3 mm thickness.
for y0,label,expected in [(-122.4,'engraved_front_section',True),(-121.1,'continuous_backing_section',False)]:
    probe=Box(150,.05,18,align=(Align.CENTER,Align.MIN,Align.CENTER)).moved(Location((0,y0,55)))
    missing=probe.volume-volume((a+b) & probe)
    report[label+'_missing_mm3']=missing
    assert missing>1 if expected else abs(missing-.1*.05*18)<1e-5
Path(__file__).with_name('checks').joinpath('geometry.json').write_text(json.dumps(report,indent=2))
print(json.dumps(report,indent=2))
