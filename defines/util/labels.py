"""
File: labels.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: ibabushkin
Description:
    Abstractions over functions and labels are
    provided in this module.
"""

from Iridium.defines.util.instructions import Instruction


class Function(object):
    """
    A Function:
        A bunch of code and a name.
    """
    def __init__(self, name):
        self.name = name
        self.code = []
        self.instructions = []

    def __str__(self):
        return '\n'.join(self.code)

    def set_code(self, lines):
        """
        Get a higher-level representation of the
        code from the function's listing.
        """
        for j, i in enumerate(lines):
            if len(i) > 0 and not i.endswith(':'):
                if ';' in i:
                    i = i.split(';')[0][:-2]
                tokens = i.split()[0]
                mnemonic = tokens[0]
                operands = tokens[1:]
                self.instructions.append(Instruction(j, 0, mnemonic, operands))
        self.code = lines


class Label(object):
    """
    A label:
        A name, a place in the code.
    """
    def __init__(self, index, line):
        self.name = line[:-1]
        self.index = index

    def __str__(self):
        return '%s:' % self.name
