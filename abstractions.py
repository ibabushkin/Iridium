class Function:
    def __init__(self, name):
        self.name = name
        self.code = []
        
    def __str__(self):
        return '\n'.join(self.code)
        
class Label:
    def __init__(self, index, line):
        self.name = line[:-1]
        self.index = index

class FunctionLabel(Label):
    def __init__(self, name):
        Label.__init__(self, 0, name+':')

class Instruction:
    def __init__(self, address, size, mnemonic, operands):
        self.address = address
        self.size = size
        self.mnemonic = mnemonic
        self.operands = operands

    def __str__(self):
        return '0x%x:\t%s\t%s' % (self.address, self.mnemonic, self.operands)

    def is_jump(self):
        return self.mnemonic in ['jmp', 'jb', 'jnae', 'jc',
                                 'jae', 'jnb', 'jnc', 'jbe',
                                 'jna', 'ja', 'jnbe', 'jl',
                                 'jnge', 'jge', 'jnl', 'jle',
                                 'jng', 'jg', 'jnle', 'je',
                                 'jz', 'jne', 'jnz', 'jp',
                                 'jpe', 'jnp', 'jpo', 'js',
                                 'jns', 'jo', 'jno', 'jcxz',
                                 'jecxz', 'call']

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
