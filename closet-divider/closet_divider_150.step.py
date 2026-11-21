"""Lightweight closet divider in millimeters, with the shelf at Z=0."""

from build123d import (
    Align, Axis, Box, Location, RectangleRounded,
    chamfer, extrude, fillet,
)

LENGTH = 200.0
WIDTH = 165.0
HEIGHT = 150.0

BASE_THICKNESS = 2.0
BASE_CORNER_RADIUS = 5.0
WALL_THICKNESS = 2.4
ROOT_RADIUS = 4.0
TOP_RADIUS = 0.75

SLOT_LENGTH = 50.0
SLOT_WIDTH = 40.0
SLOT_RADIUS = 8.0
SLOT_OFFSET = 51.0
SLOT_CENTERS = (-62.0, 0.0, 62.0)
BASE_EDGE_CHAMFER = 0.4


def gen_step():
    """Build the flat-faced dividing wall and slotted base."""
    base = extrude(RectangleRounded(LENGTH, WIDTH, BASE_CORNER_RADIUS),
                   amount=BASE_THICKNESS)
    for x in SLOT_CENTERS:
        for side in (-1, 1):
            slot = RectangleRounded(SLOT_LENGTH, SLOT_WIDTH, SLOT_RADIUS)
            slot.move(Location((x, side * SLOT_OFFSET, -1.0)))
            base -= extrude(slot, amount=BASE_THICKNESS + 2.0)

    # Ease the slot rims where they touch clothing.
    slot_rims = [
        edge for edge in base.edges().filter_by_position(
            Axis.Z, BASE_THICKNESS - 1e-6, BASE_THICKNESS + 1e-6)
        if abs(edge.center().X) < LENGTH / 2 - BASE_CORNER_RADIUS
        and abs(edge.center().Y) < WIDTH / 2 - BASE_CORNER_RADIUS
    ]
    base = chamfer(slot_rims, BASE_EDGE_CHAMFER)

    wall = Box(LENGTH, WALL_THICKNESS, HEIGHT,
               align=(Align.CENTER, Align.CENTER, Align.MIN))
    divider = base + wall
    root_edges = [
        edge for edge in divider.edges()
        if abs(abs(edge.center().Y) - WALL_THICKNESS / 2) < 1e-6
        and abs(edge.center().Z - BASE_THICKNESS) < 1e-6
        and edge.length > LENGTH - 2 * BASE_CORNER_RADIUS
    ]
    divider = fillet(root_edges, ROOT_RADIUS)
    divider = fillet(divider.edges().filter_by_position(
        Axis.Z, HEIGHT - 1e-6, HEIGHT + 1e-6), TOP_RADIUS)

    divider.label = "150 mm lightweight closet divider"
    return divider
