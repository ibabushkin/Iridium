from instructions import Instruction
from labels import Label
from types import *

class DataParser:
    def __init__(self, text):
        self.text = text
        self.code = self.get_code_from_text()
        self.addressed_offsets = []
        self.variables = []
        self.real_variables = []
        self.called_funcs = {}
        self.sizes = {'qword':8, 'dword':4, 'word':2, 'byte':1}
        #self.hll_sizes = {8:['long long int', 'double'],
                          #4:['int', 'float'],
                          #2:['short int'],
                          #1:['char']}
        
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
        self.allocated_space = self.get_allocated_space()
        print 'Allocated:', self.allocated_space
        print self.draw_memory_layout()
        num_of_contrast_points = 0
        contrast_points = []
        current_byte = None
        for index, byte in enumerate(self.draw_memory_layout()):
            if current_byte == None:
                current_byte = byte
            if current_byte != byte:
                current_byte = byte
                contrast_points.append(index)
        for var in self.variables:
            if var.offset >= contrast_points[1] - self.allocated_space:
                self.real_variables.append(var)
        if len(contrast_points) > 2:
            for i in range(0, self.allocated_space):
                if i in contrast_points and contrast_points.index(i) > 1:
                    var = self.find_variable_by_contrast_point(i)
                    if var:
                        var.array = True
                        var.num_items = abs(contrast_points[contrast_points.index(i)+1]-i) / self.sizes[var.size] + 1
        self.find_pointers()
        for var in self.real_variables:
            print var
    
    def recognize_frontend(self):
        try:
            self.recognize()
        except:
            print 'Analysis not possible!'
    
    def find_variable_by_contrast_point(self, point):
        byte_offset = -self.allocated_space + point -1
        for i in self.real_variables:
            #print i.name, i.offset, self.sizes[i.size], byte_offset
            if i.offset + self.sizes[i.size] >= byte_offset and i.offset <= byte_offset:
                return i
    
    def get_allocated_space(self):
        for line in self.code:
            if isinstance(line, Instruction):
                if line.mnemonic == 'sub':
                    return int(line.operands.split(' ')[1], 16)
        
    def draw_memory_layout(self):
        ret = ['-' for i in range(0, self.allocated_space)]
        for var in self.variables:
            for i in range(var.offset, var.offset + self.sizes[var.size]):
                ret[i] = '|'
        return ''.join(ret)
    
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
    
    def find_pointers(self):
        for index, line in enumerate(self.code):
            if line.mnemonic == 'lea':
                destination = line.operands.split(',')[0]
                instruction = self.code[index+1]
                if instruction.mnemonic == 'mov' and instruction.operands.split(' ')[1] == destination:
                    self.find_variable_by_expression(instruction.operands.split(',')[0]).pointer = True
    
    def find_variable_by_expression(self, expression):
        var_name = expression[1:-1].split('+')[-1]
        for i in self.real_variables:
            if i.name == var_name:
                return i

    def find_all_function_calls(self):
        ret = {}
        for index, line in enumerate(self.code):
            if isinstance(line, Instruction):
                if line.mnemonic == 'call':
                    ret[index] = line.operands
        return ret

class Variable:
    def __init__(self, name, size, offset):
        self.size = size
        self.hll_sizes = {'qword':['double', 'long long int'],
                          'dword':['int', 'float'],
                          'word':['short int'],
                          'byte':['char']}
        self.hll_size = self.hll_sizes[size]
        self.offset = offset
        self.name = name
        self.array = False
        self.num_items = 1
        self.pointer = False
    
    def __str__(self):
        return '/'.join(self.hll_size) + ' ' + self.name + ' (' + str(self.offset) + ') Elements: ' + str(self.num_items) + ' Pointer: '+ str(self.pointer)

if __name__ == '__main__':
    l = map(lambda x: x.strip('\n'), open('../../tests/data2.asm_analysis/main.asm', 'rb').readlines())
    d = DataParser(l)
    d.recognize()
