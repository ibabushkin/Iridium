import sys
sys.path.append('C:\Users\Admin\Desktop\pefile-1.2.10-139')

import pefile
import capstone

def is_hex(s):
    if s.startswith('0x'):
        s = s[2:]
    for i in s:
        if i not in '0123456789abcdefABCDEF':
            return False
    return True

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

class Label:
    def __init__(self, index, address):
        self.index = index
        self.address = address

    def __str__(self):
        return 'L%i@0x%x:' % (self.index, self.address)

class Parser:
    def __init__(self, code):
        self.code = code # list of Instruction()-instances
        self.current_instruction_index = 0
        self.current_instruction = self.code[0]

    def parse(self):
        for i in self.code:
            print i

class LabelParser(Parser):
    def __init__(self, code):
        Parser.__init__(self, code)
        self.jump_addresses = []
        self.labels = []
        self.label_dict = {}
        self.callers = []

    def get_dict_from_labels(self):
        dic = {}
        for i in self.labels:
            dic[i.address] = i.__str__()
        return dic
    
    def parse(self):
        for self.current_instruction in self.code:
            if self.current_instruction.is_jump():
                self.jump_addresses.append(self.current_instruction.operands)
        self.jump_addresses = list(set(filter(is_hex, self.jump_addresses)))
        #print self.jump_addresses
        for num_label, jump_address in enumerate(self.jump_addresses):
            self.labels.append(Label(num_label, int(jump_address, 16)))
        #for i in self.labels: print i
        print 
        for label in self.labels:
            for self.current_instruction_index, self.current_instruction in enumerate(self.code):
                if int(self.current_instruction.address) == int(label.address):
                    self.code.insert(self.current_instruction_index, label)
                    break
        self.label_dict = self.get_dict_from_labels()
        #print self.label_dict
        for self.current_instruction_index, self.current_instruction in enumerate(self.code):
            if isinstance(self.current_instruction, Instruction):
                if self.current_instruction.is_jump():
                    #print self.current_instruction.operands
                    if (self.current_instruction.operands in self.jump_addresses) and (int(self.current_instruction.operands, 16) in self.label_dict):
                        #print self.label_dict[int(self.current_instruction.operands, 16)]
                        self.current_instruction.operands = self.label_dict[int(self.current_instruction.operands, 16)][:-1]
                if self.current_instruction.is_call():
                    self.callers.append(self.current_instruction)
        for self.current_instruction_index, self.current_instruction in enumerate(self.code):
            # push ebp
            # mov ebp, esp
            # sub esp, X

            # mov esp, ebp
            # pop ebp
            # ret(n/f)
            if isinstance(self.current_instruction, Instruction):
                if self.current_instruction.is_push_ebp() and self.code[self.current_instruction_index+1].is_mov_ebp_esp() and self.code[self.current_instruction_index+2].is_sub():
                    print 'Encountered function with standard prologue at 0x%x.' % self.current_instruction.address
                    print 'Corresponding Label (?): '+ self.code[self.current_instruction_index-1].__str__()
                elif self.current_instruction.is_mov_esp_ebp() and self.code[self.current_instruction_index+1].is_pop_ebp() and self.code[self.current_instruction_index+2].is_ret():
                    print 'Encountered standard epilogue at 0x%x' % self.current_instruction.address
        

class Loader:
    def __init__(self, path):
        self.pe = pefile.PE(path)
        self.ep = self.pe.OPTIONAL_HEADER.AddressOfEntryPoint
        self.md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_32)
        self.code_section_content = self.get_code_section()
        self.code = [Instruction(address, size, mnemonic, op_str) for (address, size, mnemonic, op_str) in self.md.disasm_lite(self.code_section_content, self.ep)]

    def get_code_section(self):
        for section in self.pe.sections:
            if section.Name.startswith('.text'):
                return self.pe.get_memory_mapped_image()[section.VirtualAddress:section.VirtualAddress+section.Misc_VirtualSize]
        
    def output_sections(self):
        for section in self.pe.sections:
            print 'Section: %s. Virtual Address: 0x%x, Virtual Size: 0x%x, Size of raw Data: 0x%x' % (section.Name, hex(section.VirtualAddress), hex(section.Misc_VirtualSize), section.SizeOfRawData)

if __name__ == '__main__':
    l = Loader('D:\Ino\Development and Hacking\RE Material\compiled\\31.exe')
    pl = LabelParser(l.code)
    pl.parse()
    #p = Parser(pl.code)
    #p.parse()
    print hex(l.ep)
