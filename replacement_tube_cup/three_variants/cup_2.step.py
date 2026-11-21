"""Full replacement cup model 2; pitch 2.1 mm, diametral clearance 0.40 mm."""
from cup_family import build_cup
MODEL_NUMBER=2
CLEARANCE=0.4
MINOR_D=13.2
ROOT_HALF_WIDTH=0.3
LEAD_IN=0.5
def gen_step():
    return build_cup(MODEL_NUMBER,CLEARANCE,MINOR_D,ROOT_HALF_WIDTH,LEAD_IN)
