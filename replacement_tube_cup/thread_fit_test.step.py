"""Small blind threaded boss, exactly copied from the cup for physical fit checking."""
from pathlib import Path
import importlib.util
from build123d import Cylinder, Align, Color
_spec=importlib.util.spec_from_file_location('cup_source',Path(__file__).with_name('cup.step.py'))
cup=importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(cup)
def gen_step():
    body=cup.gen_step().intersect(Cylinder(10.0,cup.FLOOR+cup.BOSS_HEIGHT,
        align=(Align.CENTER,Align.CENTER,Align.MIN)))
    body.label='thread_fit_test_same_blind_boss_as_cup'
    body.color=Color(0.75,0.82,0.87)
    assert len(body.solids())==1
    return body
