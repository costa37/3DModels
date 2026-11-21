"""Exact BREP checks for user dimensions and the real helical groove."""
import importlib.util,json
from pathlib import Path
from build123d import GeomType
spec=importlib.util.spec_from_file_location('cup',Path(__file__).with_name('cup_preview.step.py'))
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
p=m.gen_step();box=p.bounding_box()
cylinders=[]
for f in p.faces():
 if f.geom_type==GeomType.CYLINDER:
  cylinders.append({'diameter':2*f.radius,'z_min':f.bounding_box().min.Z,'z_max':f.bounding_box().max.Z})
for expected in [m.CUP_OD,m.CUP_ID,m.BOSS_OD,m.BORE_MIN_D]:
 assert any(abs(x['diameter']-expected)<1e-5 for x in cylinders),expected
assert abs(box.size.Z-16.2)<1e-5
assert len(p.solids())==1 and p.volume>0 and p.is_valid
thread_faces=[f for f in p.faces() if f.geom_type==GeomType.BSPLINE]
assert len(thread_faces)>=3,'Helical groove missing'
# A radial point in the expected groove is removed; floor stays continuous.
assert not p.is_inside((6.8,0,m.FLOOR+0.55+m.THREAD_PITCH))
assert p.is_inside((0,0,m.FLOOR/2))
result={'status':'passed','units':'mm','exact_brep_bounds':[box.size.X,box.size.Y,box.size.Z],
        'cylindrical_faces':cylinders,'solid_count':len(p.solids()),'positive_volume_mm3':p.volume,
        'thread_spline_faces':len(thread_faces),'floor_continuous_at_axis':True,
        'boss_height_above_floor':m.BOSS_HEIGHT,'floor_thickness':m.FLOOR,
        'thread_pitch_provisional':m.THREAD_PITCH,'groove_major_diameter_provisional':m.THREAD_GROOVE_D,
        'physical_fit_verified':False}
Path(__file__).with_name('dimension_checks.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
