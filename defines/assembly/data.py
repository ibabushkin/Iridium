from instructions import Instruction
from labels import Label
from types import *

class DataParser:
    def __init__(self, text):
        self.text = text
        self.code = self.get_code_from_text()
        self.addressed_offsets = []
        self.variables = []
        
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
        self.generate_variables()
        
        for var in self.variables:
            print var
    
    def generate_variables(self):
        for offset in self.addressed_offsets:
            name, size = self.get_name_and_size_of_variable_by_offset(offset)
            self.variables.append(Variable(name, size, offset))
    
    def get_name_and_size_of_variable_by_offset(self, offset):
        if offset in self.addressed_offsets:
            for i in self.code:
                if isinstance(i, Instruction):
                    if i.mnemonic.startswith('var_'):
                        if int('-'+i.mnemonic.split('=')[0][4:], 16) == offset:
                            name = i.mnemonic.split('=')[0]
                            size = i.operands.split(' ')[0]
                            return [name, size]

    def get_memory_offsets_assuming_IDA(self):
        for i in self.code:
            if isinstance(i, Instruction):
                if i.mnemonic.startswith('var_'):
                    self.addressed_offsets.append(int('-'+i.mnemonic.split('=')[0][4:], 16))
                elif i.mnemonic.startswith('arg_'):
                    self.addressed_offsets.append(int(i.mnemonic.split('=')[0][4:], 16))
        #print self.addressed_offsets

class Variable:
    def __init__(self, name, size, offset):
        self.size = size
        self.offset = offset
        self.name = name
    
    def __str__(self):
        return self.name + ' ' + str(self.size) + ' ' + str(self.offset)

if __name__ == '__main__':
    l = map(lambda x: x.strip('\n'), open('../../tests/conditions13.asm_analysis/main.asm', 'rb').readlines())
    d = DataParser(l)
    d.recognize()
