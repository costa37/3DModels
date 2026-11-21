"""Full replacement cup model 3; pitch 2.1 mm, diametral clearance 0.60 mm."""
from cup_family import build_cup
MODEL_NUMBER=3
CLEARANCE=0.6
MINOR_D=13.4
ROOT_HALF_WIDTH=0.35
LEAD_IN=0.6
def gen_step():
    return build_cup(MODEL_NUMBER,CLEARANCE,MINOR_D,ROOT_HALF_WIDTH,LEAD_IN)
