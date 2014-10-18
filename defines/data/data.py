from instructions import Instruction
from types import *

class DataParser:
    def __init__(self, text):
        self.text = text
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

    def recognize(self):
        pass
