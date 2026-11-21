"""Full replacement cup model 1; pitch 2.1 mm, diametral clearance 0.20 mm."""
from cup_family import build_cup
MODEL_NUMBER=1
CLEARANCE=0.2
MINOR_D=13.0
ROOT_HALF_WIDTH=0.25
LEAD_IN=0.4
def gen_step():
    return build_cup(MODEL_NUMBER,CLEARANCE,MINOR_D,ROOT_HALF_WIDTH,LEAD_IN)
