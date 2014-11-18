import argparse
import sys
import math

from instructions import Instruction
from labels import Label

class DivisionParser:
    # the module retrieving and workiing on the information
    # present in the analyzed source, equivalent to Graph and DataParser
    def __init__(self, text):
        self.text = text # raw code
        self.code = self.get_code_from_text() # medium-level code representation
        self.next_imul = 5 # some threshold value, see help
        self.next_sar = 9 # see directly above
    
    def get_code_from_text(self):
        # same as in Graph. maybe we should use some Parent-Class?
        # yep. it's time for that
        l = []
        index = 0
        for line in self.text:
            if line.endswith(':'):
                l.append(Label(index, line))
            else:
                tokens = line.split(' ')
                if len(tokens) > 0:
                    m = tokens[0]
                    o = line[len(m)+1:]
                    l.append(Instruction(index, 0, m, o))
            index += 1
        return l
    
    def hex2signeddecimal(self, hexstr):
        # take the hexdump of a dword (or any other sequence of memory) and
        # interpret it as a signed integer
        return int(bin(int(hexstr, 16)), 2) - (1 << 32)
    
    def find_interestig_code_sequences(self):
        # find and analyze optimized divisions.
        for index, instruction in enumerate(self.code):
            if isinstance(instruction, Instruction):
                if instruction.mnemonic == 'mov' and instruction.operands.split(', ')[1].endswith('h'):
                    d, hexstr = instruction.operands.split(', ')
                    next_imul = self.find_next_instruction(index+1, 'imul', d+', %X')
                    if next_imul < self.next_imul and next_imul:
                        next_sar = self.find_next_instruction(index+1, 'sar', '%X, %X')
                        if next_sar < self.next_sar and next_sar:
                            shift = self.code[index+next_sar+1].operands.split(', ')[1]
                            magic = '0x' + hexstr.lower()[:-1]
                            print 'Found candidate for optimized integer division starting at line ' + str(index) + ':'
                            print 'constant: '+ magic + ', rshift: '+ shift
                            result = self.get_divisor(magic, int(shift))
                            print '--> division by '+ str(result)
                    
    
    def find_next_instruction(self, start_index, mnemonic, opers):
        # get the distance to the next instruction matching the args. Warning: might return None.
        # opers should look like these examples: '%X, %X', '%X, eax', 'eax, %X'
        # where %X is a wildcard
        first, second = opers.split(', ')
        for index, instruction in enumerate(self.code[start_index:]):
            if isinstance(instruction, Instruction):
                if instruction.mnemonic == mnemonic:
                    operands = instruction.operands.split(', ')
                    if (first == '%X' or first == operands[0]) and (second == '%X' or second == operands[1]):
                        return index
        
    def get_divisor(self, magic, rshift, bitness=32):
        # see the explanation at http://reverseengineering.stackexchange.com/questions/1397/how-can-i-reverse-optimized-integer-division-modulo-by-constant-operations
        # basically calculates the divisor from magic constant and shift amount, as well as used register size.
        magic = self.hex2signeddecimal(magic)
        return int(math.ceil((2.0**(bitness+rshift))/(magic+2**bitness)))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='The division analysis module, capable to work stand-alone')
    parser.add_argument('-s', '--source', help='Optional file to be analyzed, if not present, the hard-coded-default is used (for debugging purposes)')
    parser.add_argument('-o', '--output', help='Optional file to redirect input to')
    parser.add_argument('--next-imul-threshold', help='''Maximal index-difference between the imul and the
    loading of the constant to consider the corresponding code-block an optimized division, defaults to 5. Use with care, default value should work in most cases.
    If it does not, it is advised to extract the parameters by hand and call the module in interactive mode (see below).''')
    parser.add_argument('--next-sar-threshold', help='''Maximal index-difference between the right-shift and the
    loading of the constant to consider the corresponding code-block an optimized division, defaults to 9. Use with care, default value should work in most cases.
    If it does not, it is advised to extract the parameters by hand and call the module in interactive mode (see below).''')
    parser.add_argument('--interactive', '-i', action='store_true', help='Ask the user for input and process it as if it was extracted from an assembly-listing. Overrides all other options.')
    source = '../../tests/division.asm_analysis/main.asm'
    f = parser.parse_args()
    if f.source: source = f.source
    if f.output: sys.stdout = open(f.output, 'wb')
    l = map(lambda x: x.strip('\n'), open(source, 'rb').readlines())
    if not f.interactive:
        d = DivisionParser(l)
        if f.next_imul_threshold: d.next_imul = int(f.next_imul_threshold)
        if f.next_sar_threshold: d.next_sar = int(f.next_sar_threshold)
        d.find_interestig_code_sequences()
    else:
        d = DivisionParser(l)
        magic = raw_input('Enter constant as hex number prefixed by 0x (input not verified!): ')
        rshift = int(raw_input('Enter rshift amount (must be int, input not verified): '))
        print 'Divisor seems to be '+ str(d.get_divisor(magic, rshift)) + '.'
    
