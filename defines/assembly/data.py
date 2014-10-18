from instructions import Instruction
from labels import Label
from types import *

class DataParser:
    def __init__(self, text):
        self.text = text
        self.code = self.get_code_from_text()
        self.addressed_offsets = []
        
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
        self.get_memory_offsets_assuming_IDA()

    def get_memory_offsets_assuming_IDA(self):
        for i in self.code:
            if isinstance(i, Instruction):
                if i.mnemonic.startswith('var_'):
                    self.addressed_offsets.append(int('-'+i.mnemonic.split('=')[0][4:], 16))
                elif i.mnemonic.startswith('arg_'):
                    self.addressed_offsets.append(int(i.mnemonic.split('=')[0][4:], 16))
        print self.addressed_offsets
