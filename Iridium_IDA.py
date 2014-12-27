#!/usr/bin/env python
import sys
import os
import argparse
from defines.assembly.labels import Function, Label, FunctionLabel
from defines.assembly.instructions import Jump
from defines.assembly.graph import Graph
from defines.assembly.data import DataParser
from defines.assembly.division import DivisionParser

from settings import *


class AssemblyParser:

    def __init__(self, filepath):
        self.code = map(lambda x: x.strip(), open(filepath, 'rb').readlines())
        self.analyze_dir = os.path.dirname(filepath)
        self.filename = os.path.split(filepath)[1]
        self.current_function = ''
        if not SKIP_FILE_EXTENSION_FOR_DIRNAME:
            self.results_dir = os.path.join(
                self.analyze_dir, self.filename + RESULTS_DIR_NAME)
        else:
            fn = '.'.join(self.filename.split('.')[:-1])
            self.results_dir = os.path.join(
                self.analyze_dir, fn + RESULTS_DIR_NAME)
        if not os.path.exists(self.results_dir):
            print 'creating directory...'
            os.mkdir(self.results_dir)
        else:
            print 'skipping mkdir, directory already existing...'
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
                    self.functions[-1].set_code(
                        self.get_code(self.current_function_beginning_index, index + 1))
                    self.current_function_beginning_index = None
                    self.in_function = False

    def get_code(self, start, end):
        return self.code[start:end]

    def dump_functions(self):
        for i in self.functions:
            output = open(
                os.path.join(self.results_dir, i.name + '.asm'), 'wb')
            for j in i.code:
                if j != '':
                    if ';' in j:
                        j = j.split(';')[0][:-2]
                    output.write(j.replace('\t', ' ') + '\n')

    def cfg_analysis(self, l):
        stdout = sys.stdout
        sys.stdout = open(os.path.join(
            self.results_dir, self.current_function + FILENAME_EXTENSIONS['cfg']), 'wb')
        g = Graph(l)
        g.reduce()
        sys.stdout = stdout

    def dataflow_analysis(self, l):
        stdout = sys.stdout
        sys.stdout = open(os.path.join(
            self.results_dir, self.current_function + FILENAME_EXTENSIONS['data']), 'wb')
        p = DataParser(l)
        p.recognize_from_frontend()
        sys.stdout = stdout

    def division_analysis(self, l):
        stdout = sys.stdout
        sys.stdout = open(os.path.join(
            self.results_dir, self.current_function + FILENAME_EXTENSIONS['div']), 'wb')
        p = DivisionParser(l)
        p.find_interestig_code_sequences()
        sys.stdout = stdout

    def load_function(self, function_name):
        return map(lambda x: x.strip('\n'), open(os.path.join(self.results_dir, function_name + '.asm'), 'rb').readlines())

    def analyze_everything(self, ignore_cfg=True, ignore_data=True, ignore_div=True):
        for i in self.functions:
            print 'analyzing function', i.name + '...',
            l = self.load_function(i.name)
            self.current_function = i.name
            if not ignore_cfg:
                self.cfg_analysis(l)
            if not ignore_data:
                self.dataflow_analysis(l)
            if not ignore_div:
                self.division_analysis(l)
            print 'done.'

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Analyze IDA\'s output')
    parser.add_argument('file', help='The file to be analyzed')
    parser.add_argument(
        '--ignore-controlflow', action='store_true', help='Don\'t perform CFG analysis')
    parser.add_argument(
        '--ignore-data', action='store_true', help='Don\'t perform data analysis')
    parser.add_argument(
        '--ignore-division', action='store_true', help='Don\'t perform division analysis')
    f = parser.parse_args()
    print 'target:', f.file
    if f.ignore_controlflow:
        print 'skipping CFG analysis.'
    if f.ignore_data:
        print 'skipping data analysis.'
    if f.ignore_division:
        print 'skipping division analysis.'
    a = AssemblyParser(f.file)
    a.dump_functions()
    a.analyze_everything(
        f.ignore_controlflow, f.ignore_data, f.ignore_division)
    print 'task completed. see', a.results_dir, 'for results.'
