#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
File GDBIridium.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: ibabushkin
Description:
    A frontend to graph.py, data.py, division.py, used to analyze
    a function inside GDB.
"""

# import the submodules
from Iridium.defines.cfg.graph import Graph
from Iridium.defines.cfg.analyzer import GraphAnalyzer
from Iridium.defines.data.data import DataParser
from Iridium.defines.div.division import DivisionParser
from Iridium.defines.util.instructions import Instruction


class GDBIridium(gdb.Command):
    """
    Base command.
    """
    def __init__(self):
        """
        Register command.
        """
        gdb.Command.__init__(self, "iridium",
                             gdb.COMMAND_USER,
                             gdb.COMPLETE_NONE, True)

    def invoke(self, arg, from_tty):
        """
        Args parsing etc.
        """
        disas = gdb.execute("disas " + arg, False, True)
        code = self.process(disas, arg)
        self.analyze(code)

    def process(self, code, func_name):
        """
        Reformat the code so we can analyze it.
        """
        lines = code.splitlines()[1:-1]
        code = []
        jump_targets = []
        # initial parsing
        for line in lines:
            address, instruction = line.split('\t')
            code.append([' '.join(address.split(' ')[-2:]),
                         ' '.join([x for x in instruction.split(' ') if x])])
        # find all jumps and their destinations
        for index, instruction in enumerate(code):
            tokens = instruction[1].split(' ')
            mnemonic = tokens[0]
            i = Instruction(0, 0, mnemonic, '')
            if i.is_jump():
                jump_targets.append('<+'+tokens[-1].split('+')[1]+':')
                code[index][1] = tokens[0] + ' ' + tokens[-1]
            if i.is_call():
                code[index][1] = tokens[0] + ' ' + tokens[-1]
        # generate labels from jump targets
        labels = {}
        for index, instruction in enumerate(code):
            location = instruction[0].split(' ')[1]
            if location in jump_targets:
                labels[index] = location
            code[index] = instruction[1]
        # insert labels into code
        for i, l in enumerate(sorted(labels.keys())):
            code.insert(l+i, '<'+func_name+labels[l][1:])
        return code

    def analyze(self, code):
        for line in code:
            print line


class GDBIridiumCFG(GDBIridium):
    """
    Command invoking the controlflow module.
    """
    def __init__(self):
        """
        Register command.
        """
        gdb.Command.__init__(self, "iridium cfg",
                             gdb.COMMAND_USER,
                             gdb.COMPLETE_NONE, False)

    def analyze(self, code):
        graph = Graph(code)
        analyzer = GraphAnalyzer(graph)
        analyzer.reduce()


class GDBIridiumData(GDBIridium):
    """
    Command invoking data module.
    """
    def __init__(self):
        """
        Register command.
        """
        gdb.Command.__init__(self, "iridium data",
                             gdb.COMMAND_USER,
                             gdb.COMPLETE_NONE, False)

    def analyze(self, code):
        dp = DataParser(code)


class GDBIridiumDiv(GDBIridium):
    """
    Command invoking division module.
    """
    def __init__(self):
        """
        Register command.
        """
        gdb.Command.__init__(self, "iridium div",
                             gdb.COMMAND_USER,
                             gdb.COMPLETE_NONE, False)

    def analyze(self, code):
        dp = DivisionParser(code)
        dp.find_interesting_code_sequences()

# Initialization
GDBIridium()
GDBIridiumCFG()
GDBIridiumData()
GDBIridiumDiv()
