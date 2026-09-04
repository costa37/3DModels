"""Open-top lightweight box for holding game chips.

All dimensions are millimetres.  The outer footprint is centred on the XY
origin, the bottom sits on Z=0, and the box opens toward +Z.
"""

from build123d import Location, RectangleRounded, extrude


# User dimensions (outside envelope)
OUTER_WIDTH = 105.0
OUTER_DEPTH = 115.0
OUTER_HEIGHT = 35.0

# Lightweight FDM-friendly construction assumptions
WALL_THICKNESS = 1.2
FLOOR_THICKNESS = 1.2
INNER_CORNER_RADIUS = 8.0
OUTER_CORNER_RADIUS = INNER_CORNER_RADIUS + WALL_THICKNESS
CUT_OVERSHOOT = 1.0


def gen_step():
    """Return one closed, positive-volume open-top box solid."""
    outer_profile = RectangleRounded(
        OUTER_WIDTH,
        OUTER_DEPTH,
        OUTER_CORNER_RADIUS,
    )
    outer = extrude(outer_profile, amount=OUTER_HEIGHT)
    cavity_profile = RectangleRounded(
        OUTER_WIDTH - 2.0 * WALL_THICKNESS,
        OUTER_DEPTH - 2.0 * WALL_THICKNESS,
        INNER_CORNER_RADIUS,
    )
    cavity = extrude(
        cavity_profile,
        amount=OUTER_HEIGHT - FLOOR_THICKNESS + CUT_OVERSHOOT,
    ).move(Location((0.0, 0.0, FLOOR_THICKNESS)))

    chip_box = outer - cavity
    chip_box.label = "game_chip_box"
    return chip_box
