"""Landscape holder; mm. X along table edge, Y outward, Z up.
Table top is Z=0; table extends into Y<0 and Z<0.
Custom printed threads are not compatible with the reference model's screw.
"""
from build123d import *
from functools import lru_cache
from math import radians, sin, cos, tan

SHELF_LENGTH = 238.0
CHANNEL_DEPTH = 18.0  # clear distance along the tilted shelf
PHONE_TILT_DEG = 10.0  # backward from vertical
LIP_HEIGHT = 3.0
LIP_THICKNESS = 3.0
MOUNT_WIDTH = 24.0
MOUNT_SPACING = 190.0
BODY_WIDTH = SHELF_LENGTH
TABLE_THICKNESS = 30.0  # confirmed tabletop thickness
JAW_GAP = 42.0
UPPER_THICKNESS = 6.0
LOWER_THICKNESS = 16.0
REACH = 40.0
WEB_DEPTH = 8.0
PHONE_SHELF_DROP = 20.0  # lower the phone shelf relative to the table clamps
FLOOR_BOTTOM = -50.0 - PHONE_SHELF_DROP
FLOOR_THICKNESS = 5.0
FLOOR_TOP = FLOOR_BOTTOM + FLOOR_THICKNESS
CHANNEL_BACK = WEB_DEPTH + (UPPER_THICKNESS-FLOOR_TOP)*tan(radians(PHONE_TILT_DEG))
CHANNEL_FRONT = CHANNEL_BACK + CHANNEL_DEPTH*cos(radians(PHONE_TILT_DEG))
SCREW_Y = -19.0
PITCH = 5.5
ROOT_RADIUS = 5.5  # helical sweep reference
CORE_RADIUS = 6.0  # substantial overlap with the ridge for robust fusion
CREST_RADIUS = 7.0
RADIAL_CLEARANCE = 0.30
THREAD_LENGTH = 42.0
KNOB_HEIGHT = 8.0
PEG_HEIGHT = 3.0
PAD_HEIGHT = 6.0
NUT_RADIUS = 17.0  # diamond tip-to-centre distance
NUT_HEIGHT = 11.0
POCKET_RADIUS = 17.4
POCKET_HEIGHT = 11.3
CLEARANCE_RADIUS = 11.0  # diamond hole; inscribed clearance diameter 15.56 mm


def block(x0,x1,y0,y1,z0,z1):
    return Pos(x0,y0,z0)*Box(x1-x0,y1-y0,z1-z0,align=(Align.MIN,Align.MIN,Align.MIN))

@lru_cache(maxsize=8)
def thread_ridge(length, clearance=0.0):
    """Trapezoidal ridge swept on a right-hand helix, with flat crest."""
    root=ROOT_RADIUS + clearance
    crest=CREST_RADIUS + clearance
    axial=0.15 if clearance else 0.0
    f=Face(Wire.make_polygon([(root-0.2,0,-2.45-axial),(crest,0,-0.35-axial),
                             (crest,0,0.35+axial),(root-0.2,0,2.45+axial)],close=True))
    return sweep(f,Helix(PITCH,length,ROOT_RADIUS),is_frenet=True)

@lru_cache(maxsize=4)
def female_thread_tool(length):
    # Overshoot both ends so the female thread exits the jaw cleanly.
    return Cylinder(CORE_RADIUS+RADIAL_CLEARANCE,length,align=(Align.CENTER,Align.CENTER,Align.MIN)) + thread_ridge(length,RADIAL_CLEARANCE)


def diamond(radius,height):
    face=Face(Wire.make_polygon([(1.2*radius,0,0),(0,radius,0),(-radius,0,0),(0,-radius,0)],close=True))
    return extrude(face,amount=height)


def make_body():
    # Constant section along X: every rail and the shelf starts on the plate
    # when global X is the printing axis. Two holes retain two clamp stations.
    body=block(-BODY_WIDTH/2,BODY_WIDTH/2,0,WEB_DEPTH,FLOOR_BOTTOM,UPPER_THICKNESS)
    back_profile=Face(Wire.make_polygon([
        (-SHELF_LENGTH/2,WEB_DEPTH-1,FLOOR_BOTTOM),
        (-SHELF_LENGTH/2,CHANNEL_BACK+1.2,FLOOR_BOTTOM),
        (-SHELF_LENGTH/2,CHANNEL_BACK,FLOOR_TOP),
        (-SHELF_LENGTH/2,WEB_DEPTH,UPPER_THICKNESS),
        (-SHELF_LENGTH/2,WEB_DEPTH-1,UPPER_THICKNESS)],close=True))
    backrest=extrude(back_profile,amount=SHELF_LENGTH,dir=(1,0,0))
    shelf=block(-SHELF_LENGTH/2,SHELF_LENGTH/2,0,CHANNEL_DEPTH+LIP_THICKNESS,-FLOOR_THICKNESS,0)
    lip=block(-SHELF_LENGTH/2,SHELF_LENGTH/2,CHANNEL_DEPTH,CHANNEL_DEPTH+LIP_THICKNESS,-1,LIP_HEIGHT)
    body=body+backrest+Pos(0,CHANNEL_BACK,FLOOR_TOP)*Rot(PHONE_TILT_DEG,0,0)*(shelf+lip)
    upper=block(-BODY_WIDTH/2,BODY_WIDTH/2,-REACH,WEB_DEPTH,0,UPPER_THICKNESS)
    lower=block(-BODY_WIDTH/2,BODY_WIDTH/2,-REACH,WEB_DEPTH,-JAW_GAP-LOWER_THICKNESS,-JAW_GAP)
    for x in (-MOUNT_SPACING/2,MOUNT_SPACING/2):
        hole=Pos(x,SCREW_Y,-JAW_GAP-LOWER_THICKNESS-1)*diamond(CLEARANCE_RADIUS,LOWER_THICKNESS+2)
        pocket=Pos(x,SCREW_Y,nut_z())*diamond(POCKET_RADIUS,POCKET_HEIGHT+1)
        lower=lower-hole-pocket
    body=body+upper+lower
    body.label='one_piece_continuous_clamp_rail_and_landscape_shelf'
    body.color=Color(0.035,0.19,0.25)
    return body


def make_body_print():
    # Global X -> print +Z; put the complete C-profile on the bed at Z=0.
    body=Pos(UPPER_THICKNESS,REACH,BODY_WIDTH/2)*Rot(0,-90,0)*make_body()
    body.label='one_piece_body_bed_ready_print_on_end'
    return body


def make_nut():
    nut=diamond(NUT_RADIUS,NUT_HEIGHT)
    nut=nut-Pos(0,0,-PITCH)*female_thread_tool(NUT_HEIGHT+2*PITCH)
    nut.label='captive_diamond_nut_14mm_custom_pitch5p5'
    nut.color=Color(0.12,0.45,0.5)
    return nut


def nut_z():
    return -JAW_GAP-POCKET_HEIGHT


def make_screw():
    # Origin: knob bottom; positive Z tightens toward the tabletop.
    knob=Cylinder(13,KNOB_HEIGHT,align=(Align.CENTER,Align.CENTER,Align.MIN))
    # Grip scallops, independent of threaded fit.
    for a in range(0,360,30):
        from math import radians,cos,sin
        knob=knob-Pos(14*cos(radians(a)),14*sin(radians(a)),-1)*Cylinder(2,KNOB_HEIGHT+2,align=(Align.CENTER,Align.CENTER,Align.MIN))
    shaft=Cylinder(CORE_RADIUS,THREAD_LENGTH,align=(Align.CENTER,Align.CENTER,Align.MIN)) + thread_ridge(THREAD_LENGTH)
    shaft=shaft & block(-8,8,-8,8,0,THREAD_LENGTH)
    shaft=Pos(0,0,KNOB_HEIGHT-0.2)*shaft
    shoulder=Pos(0,0,KNOB_HEIGHT+THREAD_LENGTH-0.5)*Cylinder(4,PEG_HEIGHT+0.5,align=(Align.CENTER,Align.CENTER,Align.MIN))
    screw=knob+shaft+shoulder
    screw.label='support_free_screw_14mm_custom_pitch5p5'
    screw.color=Color(0.08,0.09,0.1)
    return screw


def make_pad():
    pad=Cylinder(10,PAD_HEIGHT,align=(Align.CENTER,Align.CENTER,Align.MIN))
    pad=pad-Pos(0,0,-1)*Cylinder(4.3,4.3,align=(Align.CENTER,Align.CENTER,Align.MIN))
    pad.label='loose_rotating_table_pressure_pad'
    pad.color=Color(0.12,0.45,0.5)
    return pad


def screw_pose():
    # Pad bottom at table underside minus pad thickness. Screw shoulder bears
    # on the pad underside, while its peg sits loose in the blind socket.
    return -TABLE_THICKNESS-PAD_HEIGHT-(KNOB_HEIGHT+THREAD_LENGTH)


def make_pad_print():
    pad=Pos(0,0,PAD_HEIGHT)*Rot(180,0,0)*make_pad()
    pad.label='pad_socket_up_bed_ready'
    return pad
