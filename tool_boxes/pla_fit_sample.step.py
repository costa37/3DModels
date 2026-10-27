"""Revision 3: connector-only test including the lower locating key."""
from build123d import Box, Align, Location, Compound
from cadgen import srgb
from drawer_box_geometry import half, RAIL_X

def gen_step():
    pieces=[]
    for which, xshift, color in [('male',-22,'#D5A56B'),('female',22,'#7EA5B5')]:
        crop=Box(25,32,26,align=(Align.CENTER,Align.CENTER,Align.MIN)).moved(Location((64.5,0,0)))
        piece=(half(which)&crop).moved(Location((xshift-RAIL_X,0,0)))
        piece.label='r3_'+which+'_dovetail_with_floor_locator'
        piece.color=srgb(color)
        pieces.append(piece)
    return Compound(label='r3_connector_only_print_layout',children=pieces)
