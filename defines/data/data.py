#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
File: data.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: ibabushkin
Description:
    This module is intended to search the code for
    variables saved on the stack, as well as arrays
    and pointers.
"""

import argparse
import sys

from Iridium.defines.util.instructions import Instruction
from Iridium.defines.util.parser import CodeCrawler
from Iridium.defines.util.util import hex_to_num


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
        self.variables = []
        self.real_variables = []
        self.allocated_space = 0
        self.sizes = {'qword': 8, 'dword': 4, 'word': 2, 'byte': 1}
        self.functions_returning_pointers = ('malloc', 'calloc', 'realloc')
        self.get_allocated_space()
        self.find_addressed_offsets()
        self.print_allocated_space()
        print self.draw_memory_layout()
        self.find_pointers()
        self.calculate_contrast_points()
        for var in self.real_variables:
            print var

    def get_allocated_space(self):
        """
        Find out how much space is allocated on the stack by subtracting
        from esp.
        """
        for instr in self.code:
            if isinstance(instr, Instruction):
                if instr.is_sub() and instr.operands[0] == 'esp':
                    self.allocated_space = hex_to_num(instr.operands[1])
                    return

    def print_allocated_space(self):
        """
        Print a visual representation of the stackframe.
        """
        if self.allocated_space == 0:
            print 'Seems like the module couldn\'t find out how much space was allocated!'
            print 'You can\'t trust the results below, that is.'
        else:
            print 'Allocated:', self.allocated_space

    def find_addressed_offsets(self):
        """
        Find all offsets and corresponding memory region sizes that are used by
        the current function. Uses IDA's var_ and arg_ tags.
        """
        ida = False
        for instr in self.code:
            if isinstance(instr, Instruction):
                if instr.mnemonic.startswith('var_') or \
                        instr.mnemonic.startswith('arg_'):
                    tokens = instr.operands[0].split(' ')
                    size = tokens[0]
                    if tokens[2]:
                        offset = hex_to_num(tokens[2])
                    else:
                        offset = hex_to_num(tokens[3])
                    name = instr.mnemonic[:-1]
                    self.variables.append(Variable(name, size, offset))
                    ida = True
                elif not ida and instr.mnemonic != 'lea' and \
                        len(instr.operands) == 2:
                    op = None
                    size = None
                    if '[' in instr.operands[0] and \
                            instr.operands[0].endswith(']'):
                        op = instr.operands[0].split('[')[1][:-1]
                        size = instr.operands[0].split(' ')[0]
                    elif len(instr.operands) == 2:
                        if '[' in instr.operands[1] and \
                                instr.operands[1].endswith(']'):
                            op = instr.operands[1].split('[')[1][:-1]
                            size = instr.operands[1].split(' ')[0]
                            if size.lower() not in Variable.hll_sizes:
                                break
                    register = None
                    offset = None
                    name = None
                    if op:
                        if '+' in op and len(op.split('+')) == 2:
                            register, offset = op.split('+')
                            offset = hex_to_num(offset)
                        elif '-' in op and len(op.split('-')) == 2:
                            register, offset = op.split('-')
                            offset = hex_to_num('-'+offset)
                        else:
                            register = op
                            offset = 0
                        if register in ('ebp', 'esp'):
                            if register == 'esp':
                                offset = -1 * (self.allocated_space-offset)
                            if offset < 0:
                                name = 'var_'
                            else:
                                name = 'arg_'
                            name += hex(abs(offset))[2:]
                            var = Variable(name, size.lower(), offset)
                            if var not in self.variables:
                                self.variables.append(var)

    def draw_memory_layout(self):
        """
        Represents directly adressed memory
        as chars in a chr-bar of some sort.
        Can be drawn directly or analyzed.
        """
        ret = ['-' for i in range(0, self.allocated_space)]
        for var in self.variables:
            if var.ebp_offset < 0:
                for i in range(var.ebp_offset,
                               var.ebp_offset + self.sizes[var.size]):
                    try:
                        ret[i] = '|'
                    except IndexError:
                        pass
        return ''.join(ret)

    def find_pointers(self):
        """
        Searches for pointers using the analysis of lea-instructions.
        """
        for index, instruction in enumerate(self.code):
            if isinstance(instruction, Instruction):
                if instruction.mnemonic == 'lea':
                    destination = instruction.operands[0]
                    instruction2 = self.code[index + 1]
                    if (isinstance(instruction2, Instruction) and
                            instruction2.mnemonic == 'mov' and
                            instruction2.operands[1] == destination):
                        self.find_variable_by_expression(
                            instruction2.operands[0]).pointer = True
                # analyzing function calls regarding returned pointers
                if instruction.mnemonic == 'call':
                    for function in self.functions_returning_pointers:
                        if function in instruction.operands[0]:
                            instruction = self.code[index + 1]
                            if instruction.mnemonic == 'mov':
                                dest, source = instruction.operands
                                if source == 'eax':
                                    self.find_variable_by_expression(
                                        dest).pointer = True

    def find_variable_by_expression(self, expression):
        """
        Used to determine the name of a variable used in an instruction.
        """
        if 'var_' in expression or 'arg_' in expression:
            var_name = expression[1:-1].split('+')[-1]
            for var in self.variables:
                if var.name == var_name:
                    return var
        else:
            offset = None
            if ' ' in expression:
                expression = expression.split(' ')[-1][1:-1]
            else:
                expression = expression[1:-1]
            if '+' in expression:
                register, offset = expression.split('+')
            elif '-' in expression:
                register, offset = expression.split('-')
                offset = '-' + offset
            offset = hex_to_num(offset)
            if register == 'esp':
                offset -= self.allocated_space
            for var in self.variables:
                if var.ebp_offset == offset:
                    return var

    def calculate_contrast_points(self):
        """
        Calculate which variables are in fact variables, and arrays.
        """
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
                if var.ebp_offset >= contrast_points[1] - self.allocated_space:
                    self.real_variables.append(var)
        else:
            self.real_variables = self.variables
            # may we need a copy, fix it here then
        if len(contrast_points) > 2:
            for i in range(0, self.allocated_space):
                if i in contrast_points and (len(contrast_points)-1) > \
                        contrast_points.index(i) > 1:
                    var = self.find_variable_by_contrast_point(i)
                    if var:
                        var.array = True
                        var.num_items = abs(
                            contrast_points[
                                contrast_points.index(i) + 1] - i) / self.sizes[
                                    var.size] + 1

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
            if (i.ebp_offset + self.sizes[i.size] >= byte_offset
                    and i.ebp_offset <= byte_offset):
                return i


class Variable(object):
    """
    The medium-level representation of an addressed offset
    """

    hll_sizes = {'qword': ['double', 'long long int'],
                 'dword': ['int', 'float'],
                 'word': ['short int'],
                 'byte': ['char']}

    def __init__(self, name, size, offset):
        """
        Prepare the data and instance variables.
        """
        self.size = size
        self.hll_size = self.hll_sizes[size]
        self.ebp_offset = offset
        self.name = name
        self.array = False
        self.num_items = 1
        self.pointer = False

    def __str__(self):
        if self.array:
            return '/'.join(self.hll_size) + ' ' + self.name + ' (' + str(self.ebp_offset) + \
                ') Elements: ' + str(self.num_items) + \
                ' Pointer: ' + str(self.pointer)
        else:
            return '/'.join(self.hll_size) + ' ' + self.name + '(' + str(self.ebp_offset) + \
                ') Pointer: ' + str(self.pointer)

    def __eq__(self, other):
        """
        Are two objects equal?
        """
        return self.ebp_offset == other.ebp_offset and self.size == other.size

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
    SOURCE = '../../tests/conditions19_analysis/__libc_csu_init.asm'
    ARGS = ARG_PARSER.parse_args()
    if ARGS.source:
        SOURCE = ARGS.source
    if ARGS.output:
        sys.stdout = open(ARGS.output, 'wb')
    CODE = [line.strip('\n') for line in open(SOURCE, 'rb').readlines()]
    DATA_PARSER = DataParser(CODE)
