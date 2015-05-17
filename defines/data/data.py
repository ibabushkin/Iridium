#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
File: data.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: None
Description:
    This module is intended to search the code for
    variables saved on the stack, as well as arrays
    and pointers.
"""

import argparse
import sys

from Iridium.defines.util.instructions import Instruction
from Iridium.defines.util.parser import CodeCrawler


class DataParser(CodeCrawler):
    """
    Intended to parse a program regarding the data it uses.
    Similar to Graph (at least consdering the level of abstraction
    and overall position in the system).
    """

    def __init__(self, text):
        """
        Prepare everything for analysis.
        """
        CodeCrawler.__init__(self, text)
        self.addressed_offsets = []  # used to determine class 0 vars
        self.variables = []  # used for class 0 vars
        self.real_variables = []  # class 1 vars
        # for call-/ return-analysis
        self.called_funcs = self.find_all_function_calls()
        # var sizes
        self.sizes = {'qword': 8, 'dword': 4, 'word': 2, 'byte': 1}
        self.functions_returning_pointers = ['malloc', 'calloc', 'realloc']
        # self.hll_sizes = {8:['long long int', 'double'],
        # 4:['int', 'float'],
        # 2:['short int'],
        # 1:['char']}
        self.allocated_space = self.get_allocated_space()
        if self.allocated_space == 0:
            print 'Seems like the module couldn\'t find out how much space was allocated!'
            print 'You can\'t trust the results below, that is.'

    def recognize(self):
        """
        The main method to record all data availible.
        """
        self.ida_memory_offsets()
        self.generate_variables()
        print 'Allocated:', self.allocated_space
        print self.draw_memory_layout()
        contrast_points = []
        current_byte = None
        for index, byte in enumerate(self.draw_memory_layout()):
            if current_byte is None:
                current_byte = byte
            if current_byte != byte:
                current_byte = byte
                contrast_points.append(index)
        if len(contrast_points) > 1:
            for var in self.variables:
                if var.offset >= contrast_points[1] - self.allocated_space:
                    self.real_variables.append(var)
        if len(contrast_points) > 2:
            for i in range(0, self.allocated_space):
                if i in contrast_points and contrast_points.index(i) > 1:
                    var = self.find_variable_by_contrast_point(i)
                    if var:
                        var.array = True
                        var.num_items = abs(
                            contrast_points[
                                contrast_points.index(i) + 1] - i) / self.sizes[
                                    var.size] + 1
        self.find_pointers()
        for var in self.real_variables:
            print var

    def find_variable_by_contrast_point(self, point):
        """
        A contrast point is a point in memory (on the stack)
        that is at the edge of some chunk of memory that is adressed
        directly by the code. This method makes it possible to find the
        corresponding variable.
        """
        byte_offset = -self.allocated_space + point - 1
        for i in self.real_variables:
            # print i.name, i.offset, self.sizes[i.size], byte_offset
            if (i.offset + self.sizes[i.size] >= byte_offset
                    and i.offset <= byte_offset):
                return i

    def get_allocated_space(self):
        """
        Find the first sub-instruction in the code that is used
        to allocate space on the stack.
        """
        for instruction in self.code:
            if isinstance(instruction, Instruction):
                # save enough, I hope
                if instruction.mnemonic == 'sub' and 'esp' in instruction.operands:
                    value = instruction.operands.split(' ')[1]
                    if value.endswith('h'):
                        value = value[:-1]
                    return int(value, 16)
        return 0

    def draw_memory_layout(self):
        """
        Represents directly adressed memory
        as chars in a chr-bar of some sort.
        Can be drawn directly or analyzed.
        """
        ret = ['-' for i in range(0, self.allocated_space)]
        print ret
        for var in self.variables:
            if var.offset > 0:
                for i in range(var.offset, var.offset + self.sizes[var.size]):
                    ret[i] = '|'
        return ''.join(ret)

    def generate_variables(self):
        """
        Generates a medium-level representations
        of addressed offsets.
        """
        for offset in self.addressed_offsets:
            name, size = self.get_var_data_by_offset(offset)
            self.variables.append(Variable(name, size, offset))

    def get_var_data_by_offset(self, offset):
        """
        Analyzes how much space is addressed at a specific offset
        """
        if offset in self.addressed_offsets:
            for i in self.code:
                if isinstance(i, Instruction):
                    if i.mnemonic.startswith('var_'):
                        if int('-' + i.mnemonic.split('=')[0][4:], 16) == offset:
                            name = i.mnemonic.split('=')[0]
                            size = i.operands.split(' ')[0]
                            return [name, size]
                    elif i.mnemonic.startswith('arg_'):
                        if int(i.mnemonic.split('=')[0][4:], 16) == offset:
                            name = i.mnemonic.split('=')[0]
                            size = i.operands.split(' ')[0]
                            return [name, size]

    def ida_memory_offsets(self):
        """
        Parses the IDA-specific var-statements
        """
        for i in self.code:
            if isinstance(i, Instruction):
                if i.mnemonic.startswith('var_'):
                    self.addressed_offsets.append(
                        int('-' + i.mnemonic.split('=')[0][4:], 16))
                elif i.mnemonic.startswith('arg_'):
                    self.addressed_offsets.append(
                        int(i.mnemonic.split('=')[0][4:], 16))
        # print self.addressed_offsets

    def find_pointers(self):
        """
        Searches for pointers using the analysis of lea-instructions.
        """
        for index, instruction in enumerate(self.code):
            if isinstance(instruction, Instruction):
                if instruction.mnemonic == 'lea':
                    destination = instruction.operands.split(',')[0]
                    instruction2 = self.code[index + 1]
                    if (isinstance(instruction2, Instruction) and
                            instruction2.mnemonic == 'mov' and
                            instruction2.operands.split(' ')[1] == destination):
                        self.find_variable_by_expression(
                            instruction2.operands.split(',')[0]).pointer = True
                # analyzing function calls regarding returned pointers
                if instruction.mnemonic == 'call':
                    for function in self.functions_returning_pointers:
                        if function in instruction.operands:
                            instruction = self.code[index + 1]
                            if instruction.mnemonic == 'mov':
                                dest, source = instruction.operands.split(', ')
                                if source == 'eax':
                                    self.find_variable_by_expression(
                                        dest).pointer = True

    def find_variable_by_expression(self, expression):
        """
        Used to determine the name of a variable used in an instruction.
        """
        var_name = expression[1:-1].split('+')[-1]
        for i in self.real_variables:
            if i.name == var_name:
                return i

    def find_all_function_calls(self):
        """
        Search for all function calls.
        """
        ret = {}
        for index, instruction in enumerate(self.code):
            if isinstance(instruction, Instruction):
                if instruction.mnemonic == 'call':
                    ret[index] = instruction.operands
        return ret


class Variable(object):
    """
    The medium-level representation of an addressed offset
    """

    def __init__(self, name, size, offset):
        """
        Prepare the data and instance variables.
        """
        self.size = size
        self.hll_sizes = {'qword': ['double', 'long long int'],
                          'dword': ['int', 'float'],
                          'word': ['short int'],
                          'byte': ['char']}
        self.hll_size = self.hll_sizes[size]
        self.offset = offset
        self.name = name
        self.array = False
        self.num_items = 1
        self.pointer = False

    def __str__(self):
        return '/'.join(self.hll_size) + ' ' + self.name + ' (' + str(self.offset) + \
            ') Elements: ' + str(self.num_items) + \
            ' Pointer: ' + str(self.pointer)

if __name__ == '__main__':
    ARG_PARSER = argparse.ArgumentParser(
        description='The data analysis module, capable to work stand-alone')
    ARG_PARSER.add_argument(
        '-s',
        '--source',
        help='''Optional file to be analyzed, if not present,
        the hard-coded-default is used (for debugging purposes)''')
    ARG_PARSER.add_argument(
        '-o', '--output', help='Optional file to redirect input to')
    SOURCE = '../../tests/data2_analysis/__libc_csu_init.asm'
    ARGS = ARG_PARSER.parse_args()
    if ARGS.source:
        SOURCE = ARGS.source
    if ARGS.output:
        sys.stdout = open(ARGS.output, 'wb')
    CODE = [line.strip('\n') for line in open(SOURCE, 'rb').readlines()]
    DATA_PARSER = DataParser(CODE)
    DATA_PARSER.recognize()
