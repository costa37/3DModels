"""Geometry measurements for the tilted cradle, in mm and degrees."""
import json
from pathlib import Path
from math import acos, degrees
from holder_geometry import *

body=make_body()
planes=[f for f in body.faces() if f.geom_type==GeomType.PLANE]
floor=min(planes,key=lambda f:abs(f.area-SHELF_LENGTH*CHANNEL_DEPTH))
n_floor=floor.normal_at()
n_back=Vector(0,cos(radians(PHONE_TILT_DEG)),sin(radians(PHONE_TILT_DEG)))
back=max((f for f in planes if f.normal_at().dot(n_back)>0.99999),key=lambda f:f.area)
lip_inner=next(f for f in planes if f.normal_at().dot(n_back)<-0.99999 and abs(f.area-SHELF_LENGTH*(LIP_HEIGHT-0.7))<0.01)
lip_top=min(planes,key=lambda f:abs(f.area-SHELF_LENGTH*(LIP_THICKNESS-1.4)))
channel=abs((lip_inner.center()-back.center()).dot(n_back))
lip=abs((lip_top.center()-floor.center()).dot(n_floor))
angle=degrees(acos(n_floor.dot(Vector(0,0,1))))
length=floor.bounding_box().size.X
# Envelope checks only: these boxes are not delivered as manufactured parts.
phone=Pos(0,CHANNEL_BACK,FLOOR_TOP)*Rot(PHONE_TILT_DEG,0,0)*block(-95,95,0,16,0,90)
table=block(-130,130,-60,0,-TABLE_THICKNESS,0)
phone_overlap=(body & phone).volume
table_overlap=(body & table).volume
b=body.bounding_box()
report={'ok':True,'body_solids':len(body.solids()),'body_valid':body.is_valid,'body_volume_mm3':body.volume,'body_size_mm':list(b.size),'shelf_length_mm':length,'channel_depth_mm':channel,'lip_height_mm':lip,'backward_tilt_deg':angle,'clamp_spacing_mm':MOUNT_SPACING,'confirmed_tabletop_mm':TABLE_THICKNESS,'shelf_drop_mm':PHONE_SHELF_DROP,'shelf_rear_height_mm':FLOOR_TOP,'190x90x16_phone_body_overlap_mm3':phone_overlap,'30mm_table_body_overlap_mm3':table_overlap}
assert len(body.solids())==1 and body.is_valid
assert abs(FLOOR_TOP-(-65.0))<1e-6
for a,e in [(length,190),(channel,18),(lip,3),(angle,10)]:assert abs(a-e)<1e-5,(a,e)
assert phone_overlap<1e-3 and table_overlap<1e-3
folder=Path(__file__).resolve().parent
(folder/'dimension_checks.json').write_text(json.dumps(report,indent=2))
print(json.dumps(report))
