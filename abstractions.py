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
    
    def __str__(self):
        return '%s at %i' % (self.name, self.index)

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

class Jump:
    def __init__(self, line_index, mnemonic, destination):
        self.index = line_index
        self.mnemonic = mnemonic
        self.destination = destination
    
    def __str__(self):
        return 'line %i: %s %s' % (self.index, self.mnemonic, self.destination)

class CPU:
    def __init__(self):
        self.registers = {'eax':0, 'ebx':0, 'ecx':0, 'edx':0, 'esi':0, 'edi':0}
        self.flags = {'cf':False, 'pf':False, 'af':False, 'zf':False, 'sf':False, 'of':False}
        self.index = 0
    
    def execute(self, mnemonic, operands):
        if operands[0] in self.registers: operand[0] = self.registers[operand[0]]
        if operands[1] in self.registers: operand[1] = self.registers[operand[1]]
        if mnemonic == 'cmp':
            result = operands[0] - operands[1]
            
        