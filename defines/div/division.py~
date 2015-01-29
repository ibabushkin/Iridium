"""
File: division.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: None
Description:
    Find optimized integer divisions and recover the divisor
    in a function.
"""

import argparse
import sys
import math

from Iridium.defines.util.instructions import Instruction
from Iridium.defines.util.parser import Parser


def hex2signeddecimal(hexstr):
    """
    Take the hexdump of a dword (or any other sequence of memory) and
    interpret it as a signed integer.
    """
    return int(bin(int(hexstr, 16)), 2) - (1 << 32)


def get_divisor(magic, rshift, bitness=32):
    """
    see the explanation at
    http://reverseengineering.stackexchange.com/questions/1397/how-can-i-reverse-optimized-integer-division-modulo-by-constant-operations
    basically calculates the divisor from magic constant and shift
    amount, as well as used register size.
    """
    magic = hex2signeddecimal(magic)
    return int(
        math.ceil((2.0 ** (bitness + rshift)) / (magic + 2 ** bitness)))


class DivisionParser(Parser):

    """
    The class retrieving and workiing on the information
    present in the analyzed source, equivalent to Graph and DataParser
    """

    def __init__(self, text):
        """
        Set default threshold vales and prepare
        for analysis.
        """
        Parser.__init__(self, text)
        self.next_imul = 5  # a threshold value, see help
        self.next_sar = 9  # see directly above

    def find_interestig_code_sequences(self):
        """
        Find and analyze optimized divisions.
        """
        for index, instruction in enumerate(self.code):
            if isinstance(instruction, Instruction):
                if instruction.mnemonic == 'mov' and instruction.operands.split(
                        ', ')[1].endswith('h'):
                    destination, hexstr = instruction.operands.split(', ')
                    next_imul = self.find_next_instruction(
                        index + 1, 'imul', destination + ', %X')
                    if next_imul < self.next_imul and next_imul:
                        next_sar = self.find_next_instruction(
                            index + 1, 'sar', '%X, %X')
                        if next_sar < self.next_sar and next_sar:
                            shift = self.code[
                                index + next_sar + 1].operands.split(', ')[1]
                            magic = '0x' + hexstr.lower()[:-1]
                            print 'Found candidate for optimized integer division \
                                starting at line ' + str(index) + ':'
                            print 'constant: ' + magic + ', rshift: ' + shift
                            result = get_divisor(magic, int(shift))
                            print '--> division by ' + str(result)

    def find_next_instruction(self, start_index, mnemonic, opers):
        """
        Get the distance to the next instruction matching the args.
        Warning: might return None.
        opers should look like these examples: '%X, %X', '%X, eax', 'eax, %X'
        where %X is a wildcard
        """
        first, magic_constant = opers.split(', ')
        for index, instruction in enumerate(self.code[start_index:]):
            if isinstance(instruction, Instruction):
                if instruction.mnemonic == mnemonic:
                    operands = instruction.operands.split(', ')
                    if (first == '%X' or first == operands[0]) and (
                            magic_constant == '%X' or (
                                magic_constant == operands[1])):
                        return index


if __name__ == '__main__':
    ARG_PARSER = argparse.ArgumentParser(
        description='The division analysis module, capable to work stand-alone')
    ARG_PARSER.add_argument(
        '-s',
        '--source',
        help='Optional file to be analyzed, if not present,\
        the hard-coded-default is used (for debugging purposes)')
    ARG_PARSER.add_argument(
        '-o', '--output', help='Optional file to redirect input to')
    ARG_PARSER.add_argument('--next-imul-threshold',
                            help='''Maximal index-difference between
    the imul and the loading of the constant to consider
    the corresponding code-block an optimized division, defaults to 5.
    Use with care, default value should work in most cases.
    If it does not, it is advised to extract the parameters by hand
    and call the module in interactive mode (see below).''')
    ARG_PARSER.add_argument('--next-sar-threshold',
                            help='''Maximal index-difference between the
    right-shift and the loading of the constant to consider the corresponding
    code-block an optimized division, defaults to 9. Use with care, default
    value should work in most cases. If it does not, it is advised to
    extract the parameters by hand and call the module in interactive
    mode (see below).''')
    ARG_PARSER.add_argument(
        '--interactive',
        '-i',
        action='store_true',
        help='''Ask the user for input and process it as if
        it was extracted from an assembly-listing.
        Overrides all other options.''')
    SOURCE = '../../tests/division_analysis/main.asm'
    ARGS = ARG_PARSER.parse_args()
    if ARGS.source:
        SOURCE = ARGS.source
    if ARGS.output:
        sys.stdout = open(ARGS.output, 'wb')
    # l = map(lambda x: x.strip('\n'), open(source, 'rb').readlines())
    LINES = [line.strip('\n') for line in open(SOURCE, 'rb').readlines()]
    if not ARGS.interactive:
        DIV = DivisionParser(LINES)
        if ARGS.next_imul_threshold:
            DIV.next_imul = int(ARGS.next_imul_threshold)
        if ARGS.next_sar_threshold:
            DIV.next_sar = int(ARGS.next_sar_threshold)
        DIV.find_interestig_code_sequences()
    else:
        DIV = DivisionParser(LINES)
        MAGIC_NUMBER = raw_input(
            'Enter constant as hex number prefixed\
            by 0x (input not verified!): ')
        RIGHT_SHIFT = int(
            raw_input('Enter RIGHT_SHIFT amount\
                      (must be int, input not verified): '))
        print 'Divisor seems to be ' + \
            str(get_divisor(MAGIC_NUMBER, RIGHT_SHIFT)) + '.'
