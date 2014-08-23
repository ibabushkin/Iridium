from __future__ import print_function

import pefile
import capstone

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
        
    def is_mov_edi_edi(self):
        return self.mnemonic == 'mov' and self.operands == 'edi, edi'

    def is_pop_ebp(self):
        return self.mnemonic == 'pop' and self.operands == 'ebp'

    def is_sub(self):
        return self.mnemonic == 'sub'
    
    def is_leave(self):
        return self.mnemonic == 'leave'

class Parser:
    def __init__(self, code):
        self.code = code # list of Instruction()-instances
        self.current_instruction_index = 0
        self.current_instruction = self.code[0]
        self.file = open('output.txt', 'wb')

    def parse(self):
        for i in self.code:
            print(i, file=self.file)

class FunctionParser(Parser):
	def __init__(self, code):
		Parser.__init__(self, code)
	
	def encounter_epilogue(self):
		return (self.current_instruction.is_mov_esp_ebp() and \
		self.code[self.current_instruction_index+1].is_pop_ebp() and \
		self.code[self.current_instruction_index+2].is_ret()) or \
		(self.current_instruction.is_pop_ebp() and \
		self.code[self.current_instruction_index+1].is_ret()) or \
		(self.current_instruction.is_leave() and \
		self.code[self.current_instruction_index+1].is_ret())

	def encounter_prologue(self):
		return (self.current_instruction.is_push_ebp() and self.code[self.current_instruction_index+1].is_mov_ebp_esp()) or \
		(self.code[self.current_instruction_index+2].is_mov_edi_edi() and self.current_instruction.is_push_ebp() and self.code[self.current_instruction_index+1].is_mov_ebp_esp())
	
	
	def parse(self):
		for self.current_instruction_index, self.current_instruction in enumerate(self.code):
			#if isinstance(self.current_instruction, Instruction):
			try:
				if self.encounter_prologue():
					print('encountered function')
				elif self.encounter_epilogue():
					print('encoutered end of function')
			except:
				pass
        
        

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
            print('Section: %s. Virtual Address: 0x%x, Virtual Size: 0x%x, Size of raw Data: 0x%x' % (section.Name, hex(section.VirtualAddress), hex(section.Misc_VirtualSize), section.SizeOfRawData))


if __name__ == '__main__':
    l = Loader('tests/1.exe')
    #pl = LabelParser(l.code)
    #pl.parse()
    p = FunctionParser(l.code)
    p.parse()
    print(hex(l.ep))
