"""Millimetres. XY footprint centred, bottom Z=0; sliding assembly along Z."""
from build123d import *

WIDTH, LENGTH, HEIGHT = 150.0, 410.0, 110.0
WALL, FLOOR = 3.0, 6.0
INNER_RADIUS, FLOOR_RADIUS = 6.0, 3.0
MAGNET_DIAMETER, MAGNET_HEIGHT = 17.5, 4.0
# Diameter confirmed by the user's P1S PLA physical test.
MAGNET_POCKET_DIAMETER, MAGNET_POCKET_DEPTH = 17.8, 4.3
MAGNET_ENTRY_CHAMFER = 0.4
MAGNET_CENTERS = [(x,y) for x in (-58.0,58.0) for y in (-188.0,188.0)]
SEAM_GAP, SLIDE_CLEARANCE = 0.1, 0.10
RAIL_X, RAIL_BOTTOM, RAIL_TOP = 69.0, 6.0, 106.0
FLOOR_KEY_X, FLOOR_KEY_WIDTH, FLOOR_KEY_REACH = 57.0, 8.0, 3.0
FLOOR_KEY_CLEARANCE = 0.08

def blank():
    outer = extrude(RectangleRounded(WIDTH,LENGTH,INNER_RADIUS+WALL),amount=HEIGHT)
    cavity = extrude(RectangleRounded(WIDTH-2*WALL,LENGTH-2*WALL,INNER_RADIUS),amount=HEIGHT)
    cavity = cavity.moved(Location((0,0,FLOOR)))
    bottom_edges = [e for e in cavity.edges() if abs(e.bounding_box().min.Z-FLOOR)<1e-6 and abs(e.bounding_box().max.Z-FLOOR)<1e-6]
    cavity = fillet(bottom_edges,FLOOR_RADIUS)
    body = outer-cavity
    pockets = [magnet_pocket().moved(Location((x,y,0))) for x,y in MAGNET_CENTERS]
    return body-pockets

def magnet_pocket(diameter=MAGNET_POCKET_DIAMETER):
    r=diameter/2
    bore=Cylinder(r,MAGNET_POCKET_DEPTH+1,align=(Align.CENTER,Align.CENTER,Align.MIN)).moved(Location((0,0,-1)))
    lead=Cone(r+MAGNET_ENTRY_CHAMFER,r,MAGNET_ENTRY_CHAMFER,
              align=(Align.CENTER,Align.CENTER,Align.MIN))
    return bore+lead

def rail(x, clearance=0.0, bottom=RAIL_BOTTOM, top=RAIL_TOP):
    # CCW trapezoid: wide head inside receiving half, narrow neck at seam.
    c=clearance
    points=[(x-2-c,-1-c),(x+2+c,-1-c),(x+3.8+c,6+c),(x-3.8-c,6+c)]
    return extrude(Polygon(*points,align=None),amount=top-bottom).moved(Location((0,0,bottom)))

def printable_male_rail(x):
    """45-degree underside grows from the supporting cheek, not mid-air.

    At y=-1 the underside is z=6; at the y=6 head it is z=13.
    The original female socket remains compatible with this trimmed rail.
    """
    yz_profile=Plane.YZ * Polygon((-1,RAIL_BOTTOM),(6,RAIL_BOTTOM+7),
                                  (6,RAIL_TOP),(-1,RAIL_TOP),align=None)
    ramp_envelope=extrude(yz_profile,amount=10).moved(Location((x-5,0,0)))
    return rail(x) & ramp_envelope

def seated_socket(x):
    """Socket floor matches male underside z=y+7; zero nominal Z overtravel.

    Lateral relief is kept, but is not applied to the seating-plane height.
    A downward-shifted male therefore interferes with the solid sloped seat.
    """
    c=SLIDE_CLEARANCE
    yz=Plane.YZ * Polygon((-1-c,RAIL_BOTTOM-c),
                         (6+c,RAIL_BOTTOM+7+c),
                         (6+c,HEIGHT+1),(-1-c,HEIGHT+1),align=None)
    envelope=extrude(yz,amount=12).moved(Location((x-6,0,0)))
    return rail(x,c,0,HEIGHT+1) & envelope

def floor_key(x, socket=False):
    """Bottom-supported key and open-top slot permit vertical assembly.

    Positioned inside the cavity, clear of the tall rail cheeks. Side and tip
    relief limit lower-joint play without tightening the tested tall rails.
    """
    c=FLOOR_KEY_CLEARANCE if socket else 0.0
    y0=-1.0
    y1=FLOOR_KEY_REACH+c
    return Box(FLOOR_KEY_WIDTH+2*c,y1-y0,FLOOR+2 if socket else FLOOR,
               align=(Align.CENTER,Align.CENTER,Align.MIN)).moved(
                   Location((x,(y0+y1)/2,-1 if socket else 0)))

def half(which):
    body=blank()
    negative=which=='male'
    center_y=-(LENGTH/4+SEAM_GAP/4) if negative else LENGTH/4+SEAM_GAP/4
    mask=Box(WIDTH+2,LENGTH/2-SEAM_GAP/2,HEIGHT+2,align=(Align.CENTER,Align.CENTER,Align.MIN)).moved(Location((0,center_y,-1)))
    body=body & mask
    # Rounded internal cheeks support the rail/socket without exceeding outer width.
    pads=[]
    for x in (-RAIL_X,RAIL_X):
        pad=extrude(RectangleRounded(12,12,2),amount=HEIGHT-FLOOR).moved(Location((x, -6-SEAM_GAP/2 if negative else 6+SEAM_GAP/2,FLOOR)))
        pads.append(pad)
    body=body+pads
    if negative:
        body=body+[printable_male_rail(x) for x in (-RAIL_X,RAIL_X)]
        body=body+[floor_key(x) for x in (-FLOOR_KEY_X,FLOOR_KEY_X)]
    else:
        body=body-[seated_socket(x) for x in (-RAIL_X,RAIL_X)]
        body=body-[floor_key(x,socket=True) for x in (-FLOOR_KEY_X,FLOOR_KEY_X)]
    body.label='drawer_box_'+which+'_half'
    return body
