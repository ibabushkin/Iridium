class Instruction:
    def __init__(self, address, size, mnemonic, operands):
        self.address = address
        self.size = size
        self.mnemonic = mnemonic
        self.operands = operands

    def __str__(self):
        return '%i: %s %s' % (self.address, self.mnemonic, self.operands)

    def is_jump(self):
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
        return self.mnemonic == 'call'

    def is_ret(self):
        return self.mnemonic in ['ret', 'retn', 'retf']

    def is_push_ebp(self):
        return self.mnemonic == 'push' and self.operands == 'ebp'

    def is_mov_ebp_esp(self):
        return self.mnemonic == 'mov' and self.operands == 'ebp, esp'

    def is_mov_esp_ebp(self):
        return self.mnemonic == 'mov' and self.operands == 'esp, ebp'

    def is_pop_ebp(self):
        return self.mnemonic == 'pop' and self.operands == 'ebp'

    def is_sub(self):
        return self.mnemonic == 'sub'
    
    def is_unconditional_jump(self):
        return self.mnemonic == 'jmp'
    
    def is_conditional_jump(self):
        return self.mnemonic in ['jb', 'jnae', 'jc', 'jecxz',
                                 'jae', 'jnb', 'jnc', 'jbe',
                                 'jna', 'ja', 'jnbe', 'jl',
                                 'jnge', 'jge', 'jnl', 'jle',
                                 'jng', 'jg', 'jnle', 'je',
                                 'jz', 'jne', 'jnz', 'jp',
                                 'jpe', 'jnp', 'jpo', 'js',
                                 'jns', 'jo', 'jno', 'jcxz']
    
    def get_destination(self):
        if self.is_jump():
            return self.operands.split(' ')[-1]

class Jump:
    def __init__(self, line_index, mnemonic, destination):
        self.index = line_index
        self.mnemonic = mnemonic
        self.destination = destination
    
    def __str__(self):
        return 'line %i: %s %s' % (self.index, self.mnemonic, self.destination)
