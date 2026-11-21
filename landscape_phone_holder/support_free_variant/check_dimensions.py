"""Spec-driven geometric checks; no exported mock phone or tabletop."""
import json
from pathlib import Path
from math import acos,degrees,pi
from variant_geometry import *

body=make_body();printed=make_body_print()
planes=[f for f in body.faces() if f.geom_type==GeomType.PLANE]
floor=min(planes,key=lambda f:abs(f.area-SHELF_LENGTH*CHANNEL_DEPTH))
n_floor=floor.normal_at();n_back=Vector(0,cos(radians(PHONE_TILT_DEG)),sin(radians(PHONE_TILT_DEG)))
back=max((f for f in planes if f.normal_at().dot(n_back)>0.99999),key=lambda f:f.area)
inner=next(f for f in planes if f.normal_at().dot(n_back)<-0.99999 and abs(f.area-SHELF_LENGTH*LIP_HEIGHT)<.01)
top=next(f for f in planes if f.normal_at().dot(n_floor)>.99999 and abs(f.area-SHELF_LENGTH*LIP_THICKNESS)<.01)
channel=abs((inner.center()-back.center()).dot(n_back));lip=abs((top.center()-floor.center()).dot(n_floor))
angle=degrees(acos(n_floor.dot(Vector(0,0,1))))
phone=Pos(0,CHANNEL_BACK,FLOOR_TOP)*Rot(PHONE_TILT_DEG,0,0)*block(-95,95,0,16,0,90)
table=block(-130,130,-60,0,-TABLE_THICKNESS,0)
report={'body_solids':len(body.solids()),'body_valid':body.is_valid,'body_volume_mm3':body.volume,'print_size_mm':list(printed.bounding_box().size),'print_min_z':printed.bounding_box().min.Z,'shelf_length_mm':floor.bounding_box().size.X,'channel_mm':channel,'lip_mm':lip,'tilt_deg':angle,'rear_shelf_height_mm':FLOOR_TOP,'clamp_spacing_mm':MOUNT_SPACING,'phone_overlap_mm3':(body&phone).volume,'table_overlap_mm3':(body&table).volume,'parts':{}}
for name,fn in [('body_print',make_body_print),('screw',make_screw),('nut',make_nut),('pad_print',make_pad_print)]:
 s=fn();report['parts'][name]={'solids':len(s.solids()),'valid':s.is_valid,'volume_mm3':s.volume}
 assert len(s.solids())==1 and s.is_valid and s.volume>0
nut=make_nut()
for side,x in [('left',-MOUNT_SPACING/2),('right',MOUNT_SPACING/2)]:
    for lift in (0, 1, 6, 12):
        assert (body & (Pos(x,SCREW_Y,nut_z()+lift)*nut)).volume < 0.001
    blocked=(body & (Pos(x,SCREW_Y,nut_z()-0.1)*nut)).volume
    assert blocked > 20
    report[side+'_downward_0p1mm_interference_mm3']=blocked
screw_area=section(make_screw(),section_by=Plane.XY.offset(25)).area
report['screw_midsection_area_mm2']=screw_area
report['screw_plain_core_area_mm2']=pi*CORE_RADIUS**2
assert screw_area>pi*CORE_RADIUS**2+5  # actual thread retained after booleans
for a,b in [(channel,18),(lip,3),(angle,10),(FLOOR_TOP,-65)]:assert abs(a-b)<1e-5,(a,b)
assert report['phone_overlap_mm3']<1e-3 and report['table_overlap_mm3']<1e-3
assert max(report['print_size_mm'])<256
Path(__file__).with_name('dimension_checks.json').write_text(json.dumps(report,indent=2))
print(json.dumps(report))
