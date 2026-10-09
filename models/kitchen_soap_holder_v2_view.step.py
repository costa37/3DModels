"""STEP companion to KitchenSoapHolder256x100x110(NoLegs)v2-05Oct2026.scad.

CAD brief: modify C/D sponge floors; preserve A/B and all walls. Millimeters,
corner origin, +Z up, envelope 256 x 100 x 110. Grid: 8 mm holes, 2.4 mm ribs,
4 mm C border, 2.4 mm D border, 4 mm floor. Support ribs rise 1.2 mm. D's 24 mm circular
outer corner pads accommodate 20 mm glue ends at (244,12) and (244,88).
Validate a single closed solid, through-openings, full contact disks, unchanged
A/B, and envelope. The SCAD remains the editable source of truth.
"""
from math import sqrt, pi, ceil, cos, sin, floor
from build123d import Box, Align, Pos, Polygon, extrude, Cylinder

WIDTH, DEPTH, HEIGHT = 256, 100, 110
OUTER, INNER, DIVIDER = 4, 2, 4
OPENING, RIB, BORDER, LIFT, PAD = 8, 2.4, 4, 1.2, 24
DISPENSER = 140 + 2 * OUTER + INNER
SINGLE = DISPENSER / 2
SPONGE = WIDTH - DISPENSER
SPONGE1 = SPONGE * 0.7
HOLE_Y = DEPTH - 2 * OUTER
C_START = DISPENSER + DIVIDER / 2
D_START = DISPENSER + SPONGE1 + INNER / 2
C_WIDTH = SPONGE1 - INNER / 2 - DIVIDER / 2
D_WIDTH = SPONGE - SPONGE1 - INNER / 2 - OUTER
GLUE_CENTERS = [(WIDTH - PAD / 2, PAD / 2), (WIDTH - PAD / 2, DEPTH - PAD / 2)]


def box(x, y, z, dx, dy, dz):
    return Pos(x, y, z) * Box(dx, dy, dz, align=(Align.MIN,) * 3)


def grid_layout(length, expanded=False):
    border = RIB if expanded else BORDER
    rounding = ceil if expanded else floor
    count = max(1, rounding((length - 2 * border + RIB) / (OPENING + RIB)))
    span = count * OPENING + (count - 1) * RIB
    return count, (length - span) / 2


def grid_windows(start, length, expanded=False):
    nx, ox = grid_layout(length, expanded)
    ny, oy = grid_layout(HOLE_Y, expanded)
    border = RIB if expanded else BORDER
    for col in range(nx):
        for row in range(ny):
            x0 = start + ox + col * (OPENING + RIB)
            y0 = OUTER + oy + row * (OPENING + RIB)
            x, y = max(x0, start + border), max(y0, OUTER + border)
            dx = min(x0 + OPENING, start + length - border) - x
            dy = min(y0 + OPENING, OUTER + HOLE_Y - border) - y
            if dx > 0 and dy > 0:
                yield x, y, dx, dy


def pad_cylinders():
    return [Pos(x,y,-1)*Cylinder(PAD/2,OUTER+2,
            align=(Align.CENTER,Align.CENTER,Align.MIN)) for x,y in GLUE_CENTERS]


def gen_step():
    cavity1 = SINGLE - OUTER - INNER / 2
    cavity2 = SINGLE - INNER / 2 - DIVIDER / 2
    cavities = [(OUTER, cavity1), (SINGLE + INNER / 2, cavity2),
                (C_START, C_WIDTH), (D_START, D_WIDTH)]
    cutters = [box(x, OUTER, OUTER, dx, HOLE_Y, HEIGHT * 2) for x, dx in cavities]
    cutters.append(box(C_START, -DEPTH * 0.2, 40, SPONGE * 1.5, DEPTH * 2, HEIGHT * 2))
    # Preserve the exact faceting and locations of A/B's original holes.
    cell_x, cell_y = (cavity1 - 20) / 4, (HOLE_Y - 20) / 4
    radius = sqrt(0.3 * cell_x * cell_y / 3.14)
    segments = ceil(max(min(360, radius * 2 * pi / 0.4), 5))
    profile = Polygon(*[(radius * cos(i * 2 * pi / segments),
                         radius * sin(i * 2 * pi / segments))
                        for i in range(segments)], align=None)
    drain = extrude(profile, amount=HEIGHT * 2)
    for start in [OUTER, SINGLE + INNER / 2]:
        for row in range(4):
            for col in range(4):
                cutters.append(Pos(start + 10 + cell_x / 2 + cell_x * col,
                                   OUTER + 10 + cell_y / 2 + cell_y * row,
                                   -HEIGHT * 0.1) * drain)
    for start, length, pads in [(C_START, C_WIDTH, False), (D_START, D_WIDTH, True)]:
        for x, y, dx, dy in grid_windows(start, length, pads):
            window = box(x, y, -1, dx, dy, OUTER + 2)
            if pads:
                window = window.cut(*pad_cylinders())
            if isinstance(window, list):
                cutters.extend(window)
            elif window:
                cutters.append(window)
    body = box(0, 0, 0, WIDTH, DEPTH, HEIGHT).cut(*cutters)
    supports = []
    for start, length in [(C_START, C_WIDTH), (D_START, D_WIDTH)]:
        nx, ox = grid_layout(length, start == D_START)
        for col in range(nx - 1):
            supports.append(box(start + ox + OPENING + col * (OPENING + RIB),
                                OUTER, OUTER, RIB, HOLE_Y, LIFT))
    body = body.fuse(*supports)
    body.label = 'Kitchen_soap_holder_v2_C_D_grid_with_D_glue_pads'
    return body
