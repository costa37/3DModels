"""Validate exported STEP solids and current measured dimensions."""
import importlib.util,json
from pathlib import Path
from build123d import import_step,GeomType
from OCP.BRepAlgoAPI import BRepAlgoAPI_Check
root=Path(__file__).parent
spec=importlib.util.spec_from_file_location('current_cup',root/'cup.step.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
results={}
for name,expected in [('cup',(33.1,33.1,16.2)),('thread_fit_test',(20.,20.,8.6))]:
 p=import_step(root/(name+'.step')); box=p.bounding_box()
 bounds=[box.size.X,box.size.Y,box.size.Z]
 assert all(abs(a-b)<1e-5 for a,b in zip(bounds,expected))
 assert len(p.solids())==1 and p.volume>0 and p.is_valid
 assert BRepAlgoAPI_Check(p.wrapped).IsValid()
 assert p.is_inside((0,0,m.FLOOR/2))
 probe_z=m.FLOOR+.8+m.THREAD_PITCH
 assert not p.is_inside((6.95,0,probe_z)), 'groove absent'
 assert p.is_inside((6.95,0,probe_z+m.THREAD_PITCH/2)), 'ridge absent'
 cylinders=[round(2*f.radius,6) for f in p.faces() if f.geom_type==GeomType.CYLINDER]
 for d in ([33.1,30.7,16.5,13.1] if name=='cup' else [20.,16.5,13.1]):
  assert d in cylinders,(name,d,cylinders)
 results[name]={'exact_bounds_mm':bounds,'solid_count':1,'volume_mm3':p.volume,
 'topology_valid':True,'bop_valid':True,'continuous_floor':True,
 'thread_groove_and_ridge_probes':True,'cylinder_diameters_mm':sorted(set(cylinders))}
results['thread']={'measured_male_major_diameter_mm':m.TUBE_THREAD_MAJOR_D,
 'interpreted_pitch_mm':m.THREAD_PITCH,'female_minor_mm':m.BORE_MIN_D,
 'female_groove_major_mm':m.THREAD_GROOVE_D,'diametral_clearance_mm':m.DIAMETRAL_CLEARANCE,
 'boss_height_mm':m.BOSS_HEIGHT,'profile':'approximate 60-degree trapezoidal, right-hand single-start',
 'physical_fit_tested':False}
(root/'current_dimension_checks.json').write_text(json.dumps(results,indent=2)+'\n')
print(json.dumps(results,indent=2))
