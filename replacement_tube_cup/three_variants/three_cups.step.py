"""Three numbered cup variants spaced 8.9 mm apart, bases at Z=0."""
from build123d import Compound, Pos
from cup_family import build_cup

def gen_step():
    variants = [(1,0.2,13.0,0.25,0.4),(2,0.4,13.2,0.30,0.5),(3,0.6,13.4,0.35,0.6)]
    cups = [Pos((number-2)*42,0,0) * build_cup(number,clearance,minor,width,lead)
            for number,clearance,minor,width,lead in variants]
    return Compound(children=cups,label='three_numbered_cups_print_layout')
