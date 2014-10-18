#!/usr/bin/env python
import sys
import os
from defines.assembly.labels import Function, Label, FunctionLabel
from defines.assembly.instructions import Jump
from defines.assembly.graph import Graph
from defines.data.data import DataParser

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
            #print os.path.join(os.path.join(self.analyze_dir, self.filename + '_analysis'), i.name + '.asm')
            output = open(os.path.join(os.path.join(self.analyze_dir, self.filename + '_analysis'), i.name + '.asm'), 'wb')
            for j in i.code:
                if j != '':
                    if ';' in j:
                        j = j.split(';')[0][:-2]
                    output.write(j.replace('\t', ' ')+'\n')
    
    def cfg_analysis(self, function_name):
        l = map(lambda x: x.strip('\n'), open(os.path.join(os.path.join(self.analyze_dir, self.filename + '_analysis'), function_name + '.asm'), 'rb').readlines())
        stdout = sys.stdout
        sys.stdout = open(os.path.join(os.path.join(self.analyze_dir, self.filename + '_analysis'), function_name + '_cfg_analysis.txt'), 'wb')
        g = Graph(l)
        g.reduce()
        sys.stdout = stdout

    def dataflow_analysis(self, function_name):
        l = map(lambda x: x.strip('\n'), open(os.path.join(os.path.join(self.analyze_dir, self.filename + '_analysis'), functions_name + '.asm'), 'rb').readlines())
        stdout = sys.stdout
        sys.stdout = open(os.path.join(os.path.join(self.analyze_dir, self.filename + '_analysis'), function_name + '_dataflow_analysis.txt'), 'wb')
        p = DataParser(l)
        p.recognize()
	sys.stdout = stdout
    
    def analyze_everything(self):
        for i in self.functions:
            print 'analyzing function', i.name,'...'
            self.cfg_analysis(i.name)
            print 'done.'

if __name__ == '__main__':
    a = AssemblyParser('tests/conditions13.asm')
    a.dump_functions()
    a.analyze_everything()
