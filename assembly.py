#!/usr/bin/env python
import sys
from defines.assembly.labels import Function, Label, FunctionLabel
from defines.assembly.instructions import Jump
from defines.assembly.graph import Graph

class AssemblyParser:
    def __init__(self, filepath, outputpath):
        self.code = map(lambda x: x.strip(), open(filepath, 'rb').readlines())
        self.in_function = False
        self.output = open(outputpath, 'wb')
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
        
    def print_results(self):
        for i in self.functions:
            print i.name
            if raw_input('Analyze?') == 'y':
                for j in i.code:
                    if j != '':
                        if ';' in j:
                            j = j.split(';')[0][:-2]
                        self.output.write(j.replace('\t', ' ')+'\n')
            print '=========================='
        self.output.close()

if __name__ == '__main__':
    args = sys.argv[1:]
    path = ''
    for index, arg in enumerate(args):
        if arg == '-p':
            path = args[index+1]
        elif arg == '-o':
            out = args[index+1]
    if path == '':
        print 'Usage: python assembly.py -p <path> -o <path>'
    else:
        p = AssemblyParser(path, out)
        p.print_results()
