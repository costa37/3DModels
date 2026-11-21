"""Variant of the closet divider with six openings through the upright."""

from pathlib import Path
from runpy import run_path

from build123d import Location, Plane, Polygon, extrude, fillet

base_design = run_path(str(Path(__file__).with_name("closet_divider_150.step.py")))

OPENING_HALF_WIDTH = 24.0
OPENING_HALF_SHOULDER = 2.0
OPENING_CORNER_RADIUS = 1.5
OPENING_COLUMNS = (-60.0, 0.0, 60.0)
OPENING_ROWS = (48.0, 108.0)


def build_perforated_divider(half_width):
    """Cut rounded hexagonal openings with sloped tops into the flat wall."""
    divider = base_design["gen_step"]()
    width = half_width
    shoulder = OPENING_HALF_SHOULDER
    height = width + shoulder
    profile = Polygon(
        (0, -height), (width, -shoulder), (width, shoulder),
        (0, height), (-width, shoulder), (-width, -shoulder),
    )
    profile = fillet(profile.vertices(), OPENING_CORNER_RADIUS)
    cutter = extrude(Plane.XZ * profile, amount=base_design["WALL_THICKNESS"], both=True)

    for column in OPENING_COLUMNS:
        for row in OPENING_ROWS:
            divider -= Location((column, 0, row)) * cutter

    divider.label = "150 mm perforated closet divider"
    return divider


def gen_step():
    return build_perforated_divider(OPENING_HALF_WIDTH)
