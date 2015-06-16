"""
File: parser.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: ibabushkin
Description:
    A module that makes traversing the code of a file
    in some manner possible.
"""

from Iridium.defines.util.instructions import Instruction
from Iridium.defines.util.labels import Label


class CodeCrawler(object):
    """
    The parent class for all modules.
    Intended to extract the code and make
    access easy.
    """
    def __init__(self, text):
        self.text = text  # raw code
        self.code = self.get_code_from_text()

    def get_code_from_text(self):
        """
        Extract the code from the listing and
        save it in a high-levle representation.
        """
        lines = []
        index = 0
        for line in self.text:
            if line.endswith(':'):
                lines.append(Label(index, line))
            else:
                if ' ' in line:
                    end_of_mnemonic = line.index(' ')
                    mnemonic = line[:end_of_mnemonic]
                    operands = line[end_of_mnemonic+1:]
                    if ',' in operands:
                        end_of_op1 = operands.index(',')
                        op1 = operands[:end_of_op1]
                        op2 = operands[end_of_op1+1:]
                        if op2.startswith(' '):
                            op2 = op2[1:]
                        operands = (op1, op2)
                    else:
                        operands = (operands,)
                    lines.append(Instruction(index, 0, mnemonic, operands))
                else:
                    lines.append(Instruction(index, 0, line, tuple()))
            index += 1
        return lines
