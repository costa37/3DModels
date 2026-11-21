from pathlib import Path
import importlib.util,json
from build123d import import_step,GeomType
from OCP.BRepAlgoAPI import BRepAlgoAPI_Check
root=Path(__file__).parent
results=[]
for n,minor,major,width,lead in [(1,13.,14.4,.5,.4),(2,13.2,14.6,.6,.5),(3,13.4,14.8,.7,.6)]:
 p=import_step(root/f'cup_{n}.step'); bb=p.bounding_box()
 assert all(abs(a-b)<1e-5 for a,b in zip([bb.size.X,bb.size.Y,bb.size.Z],[33.1,33.1,16.2]))
 assert len(p.solids())==1 and p.volume>0 and p.is_valid
 assert BRepAlgoAPI_Check(p.wrapped).IsValid()
 ds={round(2*f.radius,5) for f in p.faces() if f.geom_type==GeomType.CYLINDER}
 assert all(d in ds for d in [33.1,30.7,16.5,minor]),ds
 # Sample the 2.1 mm helix at two whole turns and between the turns.
 for z in [5.3,7.4]:
  assert not p.is_inside(((minor+major)/4,0,z)),('groove',n,z)
 assert p.is_inside(((minor+major)/4,0,4.25)),('ridge',n)
 assert p.is_inside((0,0,1.2)),('floor',n)
 # Engraving floors are portions of a coaxial R16.2 cylinder near the rim.
 marks=[f for f in p.faces() if f.geom_type==GeomType.CYLINDER and abs(f.radius-16.2)<1e-5 and f.bounding_box().min.Z>9]
 assert marks,('number missing',n)
 for f in marks:
  assert f.bounding_box().max.Z<16.2 and f.bounding_box().min.Z>9
 results.append({'model':n,'bounds_mm':[bb.size.X,bb.size.Y,bb.size.Z], 'solids':1,
 'volume_mm3':p.volume,'topology_and_BOP_valid':True,'groove_and_ridge_checks':True,
 'female_minor_diameter_mm':minor,'female_groove_major_diameter_mm':major,
 'pitch_mm':2.1,'root_axial_width_mm':width,'lead_in_mm':lead,
 'number_marking_depth_mm':.35,'remaining_wall_at_marking_mm':.85,'marking_floor_faces':len(marks),
 'boss_min_wall_at_thread_root_mm':round((16.5-major)/2,3),'physical_fit_verified':False})
(root/'validation_dimensions.json').write_text(json.dumps(results,indent=2)+'\n')
print(json.dumps(results,indent=2))
