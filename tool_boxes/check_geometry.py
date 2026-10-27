"""Check source geometry, magnet recess surfaces, and vertical assembly path."""
import json
from pathlib import Path
from build123d import Location,GeomType
from drawer_box_geometry import half, MAGNET_POCKET_DIAMETER, MAGNET_POCKET_DEPTH, MAGNET_ENTRY_CHAMFER

a,b=half('male'),half('female')
result={'half_bounds':{},'magnets':[],'assembly_path':[]}
for name,part in [('male',a),('female',b)]:
    assert len(part.solids())==1 and part.is_valid and part.volume>0
    size=part.bounding_box().size
    result['half_bounds'][name]=list(size)
    assert max(size)<260
    for face in part.faces():
        if face.geom_type==GeomType.CYLINDER and abs(face.radius-MAGNET_POCKET_DIAMETER/2)<1e-6:
            bb=face.bounding_box()
            assert abs(bb.min.Z-MAGNET_ENTRY_CHAMFER)<1e-6 and abs(bb.max.Z-MAGNET_POCKET_DEPTH)<1e-6
            result['magnets'].append({'center':[(bb.min.X+bb.max.X)/2,(bb.min.Y+bb.max.Y)/2], 'diameter':2*face.radius,'depth':bb.max.Z, 'entry_chamfer':bb.min.Z})
assert len(result['magnets'])==4
for lift in [0,0.2,1,5,25,50,100,110]:
    overlap=a.moved(Location((0,0,lift))) & b
    volume=sum(s.volume for s in overlap.solids()) if overlap else 0
    assert volume<1e-6,(lift,volume)
    result['assembly_path'].append({'male_lift_mm':lift,'overlap_volume_mm3':volume})
below=a.moved(Location((0,0,-0.2))) & b
stop_volume=sum(s.volume for s in below.solids()) if below else 0
assert stop_volume>0.1
result['downward_stop']={'shift_mm':-0.2,'interference_mm3':stop_volume}
result['ok']=True
Path('tool_boxes/checks/geometry.json').write_text(json.dumps(result,indent=2))
print(json.dumps(result))
