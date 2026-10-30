"""Millimetres. Datum: centered XY footprint, underside Z=0."""
from functools import lru_cache
from build123d import *

WIDTH, DEPTH = 420., 245.
FRONT_HEIGHT, BACK_HEIGHT = 110., 170.
WALL, FLOOR = 3., 6.
INNER_RADIUS, OUTER_RADIUS, FLOOR_RADIUS, EDGE_RADIUS = 6., 9., 3., .8
SEAM_GAP, SLIDE_CLEARANCE, FLOOR_KEY_CLEARANCE = .1, .10, .08
RAIL_U = DEPTH/2-6
TEXT_DEPTH, TEXT_SIZE = 1.2, 24.

def height_envelope():
    d=DEPTH/2
    profile=Plane.YZ * Polygon((-d, -1),(d,-1),(d,BACK_HEIGHT),
        (-d,FRONT_HEIGHT),align=None)
    return extrude(profile,amount=WIDTH+4).moved(Location((-WIDTH/2-2,0,0)))

@lru_cache(None)
def blank():
    outer=extrude(RectangleRounded(WIDTH,DEPTH,OUTER_RADIUS),amount=BACK_HEIGHT)
    outer=outer & height_envelope()
    cavity=extrude(RectangleRounded(WIDTH-2*WALL,DEPTH-2*WALL,INNER_RADIUS),amount=BACK_HEIGHT+2).moved(Location((0,0,FLOOR)))
    edges=[e for e in cavity.edges() if abs(e.bounding_box().min.Z-FLOOR)<1e-6 and abs(e.bounding_box().max.Z-FLOOR)<1e-6]
    cavity=fillet(edges,FLOOR_RADIUS)
    body=outer-cavity
    # Round exposed rim and outside underside, leaving the interior R3 transition.
    edges=[e for e in body.edges() if e.bounding_box().min.Z>FRONT_HEIGHT-1 or e.bounding_box().max.Z<1e-6]
    body=fillet(edges,EDGE_RADIUS)
    return body

def text_cutter():
    letters=Text('SQUEEGEE',TEXT_SIZE,font='Arial',font_style=FontStyle.BOLD)
    bb=letters.bounding_box()
    letters=letters.moved(Location((-(bb.min.X+bb.max.X)/2,-(bb.min.Y+bb.max.Y)/2,0)))
    # Local text +Y becomes world +Z; extrusion goes toward front (-Y).
    cut=extrude(letters,amount=TEXT_DEPTH+.2).rotate(Axis.X,90).moved(Location((0,-DEPTH/2+TEXT_DEPTH,FRONT_HEIGHT/2)))
    return cut

def rail(u, top, clearance=0., bottom=6.):
    c=clearance
    return extrude(Polygon((u-2-c,-1-c),(u+2+c,-1-c),(u+3.8+c,6+c),(u-3.8-c,6+c),align=None),amount=top-bottom).moved(Location((0,0,bottom)))

def connector(u, top, socket=False):
    c=SLIDE_CLEARANCE if socket else 0.
    upper=BACK_HEIGHT+1 if socket else top
    envelope=extrude(Plane.YZ*Polygon((-1-c,6-c),(6+c,13+c),(6+c,upper),(-1-c,upper),align=None),amount=12).moved(Location((u-6,0,0)))
    return (rail(u,upper,c,0 if socket else 6) & envelope).rotate(Axis.Z,-90)

def floor_key(u,socket=False):
    c=FLOOR_KEY_CLEARANCE if socket else 0.
    y0,y1=-1.,3.+c
    return Box(8+2*c,y1-y0,FLOOR+2 if socket else FLOOR,align=(Align.CENTER,Align.CENTER,Align.MIN)).moved(Location((u,(y0+y1)/2,-1 if socket else 0))).rotate(Axis.Z,-90)

@lru_cache(None)
def half(which):
    male=which=='male'
    x=-(WIDTH/4+SEAM_GAP/4) if male else WIDTH/4+SEAM_GAP/4
    mask=Box(WIDTH/2-SEAM_GAP/2,DEPTH+2,BACK_HEIGHT+2,align=(Align.CENTER,Align.CENTER,Align.MIN)).moved(Location((x,0,-1)))
    body=blank() & mask
    pads=[]
    for u in (-RAIL_U,RAIL_U):
        pad=extrude(RectangleRounded(12,12,2),amount=BACK_HEIGHT-FLOOR).moved(Location((u,-6-SEAM_GAP/2 if male else 6+SEAM_GAP/2,FLOOR))).rotate(Axis.Z,-90)
        pad=pad & height_envelope()
        top_edges=[e for e in pad.edges() if e.bounding_box().min.Z>100]
        pad=fillet(top_edges,EDGE_RADIUS)
        pads.append(pad)
    body=body+pads
    rails=[connector(u, FRONT_HEIGHT-4 if u>0 else BACK_HEIGHT-7,not male) for u in (-RAIL_U,RAIL_U)]
    keys=[floor_key(u,not male) for u in (-90.,90.)]
    body=body+rails+keys if male else body-rails-keys
    body=body-text_cutter()
    body.label='squeegee_left_male' if male else 'squeegee_right_female'
    return body
