"""Read-only geometry/export audit for the user-selected leg fit."""
import json, sys, importlib.util
from pathlib import Path
import trimesh
from build123d import *

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from egg_tray_parts import *

def load(name):
    spec=importlib.util.spec_from_file_location(name,ROOT/(name+'.step.py'))
    module=importlib.util.module_from_spec(spec); spec.loader.exec_module(module)
    return module

t,l=tray(),leg()
result={'units':'mm','parts':{}}
for name,source in [('tray_print',t),('leg_print',l)]:
    step=import_step(ROOT/(name+'.step'))
    mesh=trimesh.load(ROOT/(name+'.stl'),force='mesh')
    result['parts'][name]={
        'source_valid':source.is_valid,
        'step_valid':step.is_valid,
        'source_bounds':list(source.bounding_box().size),
        'step_bounds':list(step.bounding_box().size),
        'stl_bounds':mesh.extents.tolist(),
        'source_volume':source.volume,'step_volume':step.volume,
        'stl_volume':mesh.volume,
        'stl_watertight':mesh.is_watertight,
        'stl_winding_consistent':mesh.is_winding_consistent,
        'stl_components':len(mesh.split()),
        'stl_min_z':float(mesh.bounds[0,2]),
    }
placed=[Pos(0,0,UNDERSIDE_HEIGHT)*t]+[Pos(x,y,0)*l for x,y in LEG_POSITIONS]
result['assembly_intersections_mm3']={}
for i in range(5):
    for j in range(i+1,5):
        common=placed[i].intersect(placed[j])
        result['assembly_intersections_mm3'][f'{i}-{j}']=0 if common is None else common.volume
gauge=load('peg_fit_gauge').fit_pin(6.3,2)
clip=Pos(0,0,UNDERSIDE_HEIGHT)*Box(8,8,6,align=(Align.CENTER,Align.CENTER,Align.MIN))
actual=l.intersect(clip)
expected=(Pos(0,-4,UNDERSIDE_HEIGHT-2.4)*gauge).intersect(clip)
def volume(shape):
    if shape is None: return 0
    if isinstance(shape,ShapeList): return sum(s.volume for s in shape)
    return shape.volume
result['peg_vs_test_pin_2']={'actual_volume':actual.volume,'expected_volume':expected.volume,
    'difference_volume':volume(actual.cut(expected))+volume(expected.cut(actual))}
result['height']={'tray_top':TOP_HEIGHT,'lower_egg_ceiling':UNDERSIDE_HEIGHT,
    'peg_top':UNDERSIDE_HEIGHT+PEG_LENGTH,'socket_roof':UNDERSIDE_HEIGHT+SOCKET_DEPTH}
result['socket_roof_nominal_material_to_top']=TRAY_THICKNESS-SOCKET_DEPTH
out=ROOT/'review/current-audit.json'
out.write_text(json.dumps(result,indent=2)); print(out.read_text())
