"""
File: instructions.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: None
Description:
    Provides an abstraction over every single instruction.
"""


class Instruction(object):
    """
    A class representing an instruction
    """
    def __init__(self, address, size, mnemonic, operands):
        """
        Set up all the relevant data.
        """
        self.address = address
        self.size = size
        self.mnemonic = mnemonic
        self.operands = operands

    def __str__(self):
        """ Print in a ASM-like fashion. """
        return '%s %s' % (self.mnemonic, self.operands)

    def is_jump(self):
        """ Check whether the instance is representing a jump. """
        return self.mnemonic in ['jmp', 'jb', 'jnae', 'jc',
                                 'jae', 'jnb', 'jnc', 'jbe',
                                 'jna', 'ja', 'jnbe', 'jl',
                                 'jnge', 'jge', 'jnl', 'jle',
                                 'jng', 'jg', 'jnle', 'je',
                                 'jz', 'jne', 'jnz', 'jp',
                                 'jpe', 'jnp', 'jpo', 'js',
                                 'jns', 'jo', 'jno', 'jcxz',
                                 'jecxz']

    def is_call(self):
        """ Check whether the instance is representing a call. """
        return self.mnemonic == 'call'

    def is_ret(self):
        """ Check whether the instance is returning from a function. """
        return self.mnemonic in ['ret', 'retn', 'retf']

    def is_push_ebp(self):
        """ Check whether the instance is pushing ebp. """
        return self.mnemonic == 'push' and self.operands == 'ebp'

    def is_mov_ebp_esp(self):
        """ Check whether the instance is moving esp to ebp. """
        return self.mnemonic == 'mov' and self.operands == 'ebp, esp'

    def is_mov_esp_ebp(self):
        """ Check whether the instance is moving ebp to esp. """
        return self.mnemonic == 'mov' and self.operands == 'esp, ebp'

    def is_pop_ebp(self):
        """ Check whether the instance is popping ebp. """
        return self.mnemonic == 'pop' and self.operands == 'ebp'

    def is_sub(self):
        """ Check whether the instance represents a subtraction. """
        return self.mnemonic == 'sub'

    def is_unconditional_jump(self):
        """ Check whether the instance represents an unconditional jump. """
        return self.mnemonic == 'jmp'

    def is_conditional_jump(self):
        """ Check whether the instance represents a conditional jump. """
        return self.mnemonic in ['jb', 'jnae', 'jc', 'jecxz',
                                 'jae', 'jnb', 'jnc', 'jbe',
                                 'jna', 'ja', 'jnbe', 'jl',
                                 'jnge', 'jge', 'jnl', 'jle',
                                 'jng', 'jg', 'jnle', 'je',
                                 'jz', 'jne', 'jnz', 'jp',
                                 'jpe', 'jnp', 'jpo', 'js',
                                 'jns', 'jo', 'jno', 'jcxz']

    def get_destination(self):
        """
        If the instance is a jump, return its destination,
        fetching it directly from the code.
        """
        if self.is_jump():
            return self.operands.split(' ')[-1]


class Jump(object):
    """
    A jump, containing information about
    occurence, instruction and destination
    of a real instruction.
    """
    def __init__(self, line_index, mnemonic, destination):
        """
        Set the attributes.
        """
        self.index = line_index
        self.mnemonic = mnemonic
        self.destination = destination

    def __str__(self):
        """
        Print in an appropriate format.
        """
        return 'line %i: %s %s' % (self.index, self.mnemonic, self.destination)
