"""Provisional photo-derived design, mm. Not physically fit-tested."""
from build123d import *

TRAY_LENGTH = 224.0
TRAY_WIDTH = 148.0
TRAY_THICKNESS = 12.0
ORIGINAL_TOP_REFERENCE = 50.3  # photographed datum is approximate
ADDED_HEIGHT = 13.8
TOP_HEIGHT = ORIGINAL_TOP_REFERENCE + ADDED_HEIGHT
UNDERSIDE_HEIGHT = TOP_HEIGHT - TRAY_THICKNESS
POCKET_DEPTH = 8.0
POCKET_LONG_RADIUS = 37.0
POCKET_CROSS_RADIUS = 27.0
POCKET_ANGLE = 25.0
PITCH_X, PITCH_Y = 54.0, 47.0
LEG_X, LEG_Y = 54.0, 66.5
PEG_RADIUS, SOCKET_RADIUS = 3.15, 3.2  # user-tested gauge #2: 6.3 mm peg
PEG_LENGTH, SOCKET_DEPTH = 6.0, 6.5
PEG_LEAD_LENGTH = 0.4  # match the tested gauge lead-in
LEG_POSITIONS = [(x,y) for y in (-LEG_Y,LEG_Y) for x in (-LEG_X,LEG_X)]

GRIP_RADIUS = 10.0
GRIP_Y = PITCH_Y / 2

def tray(include_grips=True):
    body = extrude(RectangleRounded(TRAY_LENGTH, TRAY_WIDTH, 7), TRAY_THICKNESS)
    # Revolve an elliptical meridian around the long axis. This constructs
    # the oval bowl directly, without nonuniformly deforming a sphere.
    meridian = Edge.make_ellipse(POCKET_LONG_RADIUS, POCKET_CROSS_RADIUS,
                                start_angle=0, end_angle=180)
    diameter = Edge.make_line((-POCKET_LONG_RADIUS,0,0),
                              (POCKET_LONG_RADIUS,0,0))
    egg_seat_tool = revolve(Face(Wire([meridian, diameter])), axis=Axis.X)
    cutters=[]
    for y in (-PITCH_Y,0,PITCH_Y):
        for x in (-1.5*PITCH_X,-0.5*PITCH_X,0.5*PITCH_X,1.5*PITCH_X):
            cutters.append(Pos(x,y,TRAY_THICKNESS+POCKET_CROSS_RADIUS-POCKET_DEPTH)*Rot(0,0,POCKET_ANGLE)*egg_seat_tool)
    body=body.cut(*cutters)
    # Two finger scallops at each short end, between adjacent egg rows.
    # The test coupon explicitly excludes these full-tray-only features.
    if include_grips:
        for x in (-TRAY_LENGTH/2, TRAY_LENGTH/2):
            for y in (-GRIP_Y, GRIP_Y):
                body -= Pos(x,y,-1)*Cylinder(GRIP_RADIUS,TRAY_THICKNESS+2,
                    align=(Align.CENTER,Align.CENTER,Align.MIN))
    # Round all top boundaries, including each pocket mouth.
    top_edges=[e for e in body.edges() if abs(e.bounding_box().min.Z-TRAY_THICKNESS)<1e-5 and abs(e.bounding_box().max.Z-TRAY_THICKNESS)<1e-5]
    body=fillet(top_edges,0.8)
    if include_grips:
        bottom_edges=[e for e in body.edges() if
            abs(e.bounding_box().min.Z)<1e-5 and abs(e.bounding_box().max.Z)<1e-5]
        body=fillet(bottom_edges,0.8)
    # Blind underside sockets: initial loose slip fit for joint prototyping.
    for x,y in LEG_POSITIONS:
        body=body-Pos(x,y,-1)*Cylinder(SOCKET_RADIUS,SOCKET_DEPTH+1,align=(Align.CENTER,Align.CENTER,Align.MIN))
    body.label='tray_twelve_rounded_closed_egg_pockets'
    body.color=Color(0.82,0.88,0.92)
    return body

def leg():
    # Foot at z=0; shoulder at underside height. Narrow feet avoid lower pockets.
    body=Cone(4.5,4.0,UNDERSIDE_HEIGHT,align=(Align.CENTER,Align.CENTER,Align.MIN))
    body += Pos(0,0,UNDERSIDE_HEIGHT-3)*Cone(4.0,5.0,3,align=(Align.CENTER,Align.CENTER,Align.MIN))
    body += Pos(0,0,UNDERSIDE_HEIGHT)*Cylinder(
        PEG_RADIUS,PEG_LENGTH-PEG_LEAD_LENGTH,align=(Align.CENTER,Align.CENTER,Align.MIN))
    body += Pos(0,0,UNDERSIDE_HEIGHT+PEG_LENGTH-PEG_LEAD_LENGTH)*Cone(
        PEG_RADIUS,PEG_RADIUS-PEG_LEAD_LENGTH,PEG_LEAD_LENGTH,
        align=(Align.CENTER,Align.CENTER,Align.MIN))
    body.label='replaceable_leg_with_seating_shoulder_and_slip_peg'
    body.color=Color(0.20,0.48,0.60)
    return body
