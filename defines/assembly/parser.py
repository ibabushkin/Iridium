from instructions import Instruction
from labels import Label
from types import *

class Parser:
    # the parent class for all modules.
    # intended to extract the code and make
    # access easy.
    def __init__(self, text):
        self.text = text # raw code
        self.code = self.get_code_from_text()
        
    def get_code_from_text(self):
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
