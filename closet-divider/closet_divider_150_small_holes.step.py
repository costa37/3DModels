"""Closet divider with six rounded openings approximately 34 mm wide."""

from pathlib import Path
from runpy import run_path

perforated_design = run_path(
    str(Path(__file__).with_name("closet_divider_150_perforated.step.py"))
)
OPENING_HALF_WIDTH = 17.0


def gen_step():
    divider = perforated_design["build_perforated_divider"](OPENING_HALF_WIDTH)
    divider.label = "150 mm closet divider with smaller openings"
    return divider
