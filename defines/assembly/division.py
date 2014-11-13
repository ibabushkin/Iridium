import argparse
import sys
import math

from instructions import Instruction
from labels import Label
#from types import *

class DivisionParser:
    def __init__(self, text):
        self.text = text # raw code
        self.code = self.get_code_from_text() # medium-level code representation
    
    def get_code_from_text(self):
        # same as in Graph. maybe we should use some Parent-Class?
        l = []
        index = 0
        for line in self.text:
            if line.endswith(':'):
                l.append(Label(index, line))
            else:
                tokens = line.split(' ')
                if len(tokens) > 0:
                    m = tokens[0]
                    o = line[len(m)+1:]
                    l.append(Instruction(index, 0, m, o))
            index += 1
        return l
    
    def find_interestig_code_sequences(self):
        pass
        
    def get_divisor(self, magic, rshift, bitness=32):
        # see the explanation at http://reverseengineering.stackexchange.com/questions/1397/how-can-i-reverse-optimized-integer-division-modulo-by-constant-operations
        return math.ceil((2.0**(bitness+rshift))/(magic+2**bitness))
