"""
File: parser.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: None
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
                tokens = line.split(' ')
                if len(tokens) > 0:
                    mnemonic = tokens[0]
                    operands = line[len(mnemonic) + 1:]
                    lines.append(Instruction(index, 0, mnemonic, operands))
            index += 1
        return lines
