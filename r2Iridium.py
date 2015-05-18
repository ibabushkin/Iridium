#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
File: radare2Iridium.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: ibabushkin
Description:
    A frontend to graph.py, data.py, division.py, used to analyze
    a a disassembly dump from radare2.
    For more details on usage see ``python radare2Iridium.py -h``.
"""

import sys
import os
import argparse
import re
from multiprocessing import Process

# import the submodules
from Iridium.defines.util.labels import Function
from Iridium.defines.cfg.graph import Graph
from Iridium.defines.cfg.analyzer import GraphAnalyzer
from Iridium.defines.data.data import DataParser
from Iridium.defines.div.division import DivisionParser

# import the settings
from Iridium.settings import RESULTS_DIR_NAME_SUFFIX
from Iridium.settings import SKIP_FILE_EXTENSION_FOR_DIRNAME
from Iridium.settings import FILENAME_EXTENSIONS


class AssemblyParser(object):
    """
    This Class provides an abstraction on an assembly-file.
    Makes it possible to perform analysis on every function in the
    file and save the output in an ordered manner. For a detailed
    description of features and configuration options, see
    ``python IDAIridium.py -h`` and ``settings.py``
    """
    def __init__(self, filepath, blacklist):
        """
        Get the code out of the file and create and create an enviroment
        suitable for analysis.
        """
        self.code = [line.strip() for line in open(filepath, 'rb').readlines()]
        self.analysis_dir = os.path.dirname(filepath)
        self.filename = os.path.split(filepath)[1]
        if blacklist:
            self.blacklist_pattern = blacklist
            self.no_blacklist = False
        else:
            self.no_blacklist = True
        self.current_function = ''
        if not SKIP_FILE_EXTENSION_FOR_DIRNAME:
            self.results_dir = os.path.join(self.analysis_dir,
                                            self.filename +
                                            RESULTS_DIR_NAME_SUFFIX)
        else:
            filename_ = '.'.join(self.filename.split('.')[:-1])
            self.results_dir = os.path.join(self.analysis_dir,
                                            filename_ + RESULTS_DIR_NAME_SUFFIX)
        if not os.path.exists(self.results_dir):
            print 'creating directory...'
            os.mkdir(self.results_dir)
        else:
            print 'skipping mkdir, directory already existing...'
        self.in_function = False
        self.functions = []
        self.func_begin_index = None
        self.obtain_functions()

    def obtain_functions(self):
        """
        Find all functions in the analysis target.
        Uses patterns to find functions. The functions are
        saved as Function-instances in self.functions.
        """
        print 'obtaining functions...'
        for index, line in enumerate(self.code):
            if not self.in_function:
                if re.match('.+[\t ]proc[\t ]near$', line, re.MULTILINE):
                    self.functions.append(Function(line.split()[0]))
                    self.in_function = True
                    self.func_begin_index = index
            else:
                if re.match('.+[\t ]endp', line, re.MULTILINE):
                    self.functions[-1].set_code(self.get_code(
                        self.func_begin_index, index + 1))
                    self.func_begin_index = None
                    self.in_function = False

    def get_code(self, start, end):
        """
        Return a slice of code from the file's listing.
        """
        return self.code[start:end]

    def dump_functions(self):
        """
        For every function found, save it's code to an
        appropriately named file in the analysis directory.
        """
        for i in self.functions:
            output = open(
                os.path.join(self.results_dir, i.name + '.asm'), 'wb')
            for j in i.code:
                if j != '':
                    if ';' in j:
                        j = j.split(';')[0].strip()
                    output.write(j.replace('\t', ' ') + '\n')

    def cfg_analysis(self, listing):
        """
        Perform controlflow-analysis on a functions's code
        and save the results to an apropriately named file.
        """
        stdout = sys.stdout
        sys.stdout = open(
            os.path.join(
                self.results_dir,
                self.current_function +
                FILENAME_EXTENSIONS['cfg']),
            'wb')
        graph = Graph(listing)
        analyzer = GraphAnalyzer(graph)
        analyzer.reduce()
        sys.stdout = stdout

    def dataflow_analysis(self, listing):
        """
        Perform data-analysis on a function's code
        and save the results to an apropriately named file.
        """
        stdout = sys.stdout
        sys.stdout = open(
            os.path.join(
                self.results_dir,
                self.current_function +
                FILENAME_EXTENSIONS['data']),
            'wb')
        data_parser = DataParser(listing)
        data_parser.recognize()
        sys.stdout = stdout

    def division_analysis(self, listing):
        """
        Perform division-analysis on a function's code
        and save the results to an apropriately named file.
        """
        stdout = sys.stdout
        sys.stdout = open(
            os.path.join(
                self.results_dir,
                self.current_function +
                FILENAME_EXTENSIONS['div']),
            'wb')
        div_parser = DivisionParser(listing)
        div_parser.find_interestig_code_sequences()
        sys.stdout = stdout

    def load_function(self, function_name):
        """
        Load the contents of an .asm-file from the analysis dir.
        """
        path = os.path.join(self.results_dir, function_name + '.asm')
        return [line.strip('\n') for line in open(path, 'rb').readlines()]

    def analyze_everything(
            self,
            ignore_cfg=True,
            ignore_data=True,
            ignore_div=True,
            multiproc=True):
        """
        For every function, perform the specified kinds of analysis.
        """
        for i in self.functions:
            code = self.load_function(i.name)
            self.current_function = i.name
            if self.no_blacklist or not \
                    re.match(self.blacklist_pattern, self.current_function):
                print 'analyzing function', i.name + '...',
                if not ignore_cfg:
                    if multiproc:
                        proc = Process(target=self.cfg_analysis, args=(code,))
                        proc.start()
                    else:
                        self.cfg_analysis(code)
                if not ignore_data:
                    if multiproc:
                        proc = Process(target=self.dataflow_analysis,
                                       args=(code,))
                        proc.start()
                    else:
                        self.dataflow_analysis(code)
                if not ignore_div:
                    if multiproc:
                        proc = Process(target=self.division_analysis,
                                       args=(code,))
                        proc.start()
                    else:
                        self.division_analysis(code)
                print 'done.'

if __name__ == '__main__':
    ARG_PARSER = argparse.ArgumentParser(description='Analyze IDA\'s output')
    ARG_PARSER.add_argument('file', help='The file to be analyzed')
    ARG_PARSER.add_argument(
        '--ignore-controlflow',
        action='store_true',
        help='Don\'t perform CFG analysis')
    ARG_PARSER.add_argument(
        '--ignore-data',
        action='store_true',
        help='Don\'t perform data analysis')
    ARG_PARSER.add_argument(
        '--ignore-division',
        action='store_true',
        help='Don\'t perform division analysis')
    ARG_PARSER.add_argument(
        '--blacklist-pattern',
        help='Functions that match the pattern are excluded from analysis.\
            The source is still saved to disk.')
    ARG_PARSER.add_argument(
        '--no-multiprocessing',
        action='store_true',
        help='Use only one process for analysis.')
    ARGS = ARG_PARSER.parse_args()
    print 'blacklist:', ARGS.blacklist_pattern
    print 'target:', ARGS.file
    if ARGS.ignore_controlflow:
        print 'skipping CFG analysis.'
    if ARGS.ignore_data:
        print 'skipping data analysis.'
    if ARGS.ignore_division:
        print 'skipping division analysis.'
    ASM_PARSER = AssemblyParser(ARGS.file, ARGS.blacklist_pattern)
    ASM_PARSER.dump_functions()
    ASM_PARSER.analyze_everything(ARGS.ignore_controlflow,
                                  ARGS.ignore_data,
                                  ARGS.ignore_division,
                                  not ARGS.no_multiprocessing)
    print 'task completed. see', ASM_PARSER.results_dir, 'for results.'