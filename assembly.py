#!/usr/bin/env python
import sys
import os
from defines.assembly.labels import Function, Label, FunctionLabel
from defines.assembly.instructions import Jump
from defines.assembly.graph import Graph

class AssemblyParser:
    def __init__(self, filepath):
        self.code = map(lambda x: x.strip(), open(filepath, 'rb').readlines())
        self.analyze_dir = os.path.dirname(filepath)
        self.filename = os.path.split(filepath)[1]
        if not os.path.exists(os.path.join(self.analyze_dir, self.filename + '_analysis')):
            os.mkdir(os.path.join(self.analyze_dir, self.filename + '_analysis'))
        self.in_function = False
        self.functions = []
        self.current_function_beginning_index = None
        self.obtain_functions()
    
    def obtain_functions(self):
        for index, line in enumerate(self.code):
            if not self.in_function:
                if 'proc' in line:
                    self.functions.append(Function(line.split()[0]))
                    self.in_function = True
                    self.current_function_beginning_index = index
            else:
                if 'endp' in line:
                    self.functions[-1].set_code(self.get_code(self.current_function_beginning_index, index+1))
                    self.current_function_beginning_index = None
                    self.in_function = False

    def get_code(self, start, end):
        return self.code[start:end]

    def dump_functions(self):
        for i in self.functions:
            output = open(os.path.join(os.path.join(self.analyze_dir, self.filename + '_analysis'), i.name + '.asm'), 'wb')
            for j in i.code:
                if j != '':
                    if ';' in j:
                        j = j.split(';')[0][:-2]
                    output.write(j.replace('\t', ' ')+'\n')

if __name__ == '__main__':
    a = AssemblyParser('tests/conditions3.asm')
    a.dump_functions()
