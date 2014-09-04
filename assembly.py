#! /usr/bin/env python

from defines.assembly.labels import Function, Label, FunctionLabel
from defines.assembly.instructions import Jump

class Parser:
    def __init__(self, filepath):
        self.code = map(lambda x: x.strip(), open(filepath, 'rb').readlines())
        self.in_function = False
        self.functions = []
        self.current_function_beginning_index = None
        self.obtain_functions()
    
    def obtain_functions(self):
        for index, line in enumerate(self.code):
            if not self.in_function:
                if 'proc' in line:
                    self.functions.append(Function(line.split()[0]))
                    self.in_function = True
                    self.current_function_beginning_index = index
            else:
                if 'endp' in line:
                    self.functions[-1].set_code(self.get_code(self.current_function_beginning_index, index+1))
                    self.current_function_beginning_index = None
                    self.in_function = False

    def get_code(self, start, end):
        return self.code[start:end]
        
    def print_results(self):
        for i in self.functions:
            if i.name == 'main':
                f = FunctionParser(i)
                f.parse()
                print '==========================='
                print f
                print '==========================='

            
class FunctionParser:
    def __init__(self, function):
        self.code = function.code
        #self.instructions = function.instructions
        self.labels = []
        self.func_label = FunctionLabel(function.name)
        self.last_label = self.func_label
        self.current_line = None
        self.current_line_index = None
        self.jump_mnemonics = ['jmp', 'jb', 'jnae', 'jc',
                                 'jae', 'jnb', 'jnc', 'jbe',
                                 'jna', 'ja', 'jnbe', 'jl',
                                 'jnge', 'jge', 'jnl', 'jle',
                                 'jng', 'jg', 'jnle', 'je',
                                 'jz', 'jne', 'jnz', 'jp',
                                 'jpe', 'jnp', 'jpo', 'js',
                                 'jns', 'jo', 'jno', 'jcxz',
                                 'jecxz']
        self.back_jumps = []
        self.forward_jumps = []
        self.doloop_ends = {}
        self.insertions = {}
    
    def __str__(self):
        return '\n'.join(self.code)
    
    def find_label_by_index(self, index):
        for i in self.labels:
            if i.index == index:
                return i
        return None
    
    def find_label_index_by_name(self, name):
        for i in self.labels:
            if i.name == name:
                return i.index
        return None
    
    def find_forward_jump_by_line_index(self, index):
        for i in self.forward_jumps:
            if i.index == index:
                return i
        return None
    
    def find_back_jump_by_line_index(self, index):
        for i in self.back_jumps:
            if i.index == index:
                return i
        return None
    
    def find_last_label(self, index):
        while True:
            l = self.find_label_by_index(index)
            if l:
                return l
            index -= 1
            if index == 0:
                return None
    
    def find_next_label(self, index):
        while True:
            l = self.find_label_by_index(index)
            if l:
                return l
            index += 1
            if index == len(self.code):
                return None
                
    def parse(self):
        for self.current_line_index, self.current_line in enumerate(self.code):
            if self.current_line.endswith(':'):
                self.labels.append(Label(self.current_line_index, self.current_line))
        
        for self.current_line_index, self.current_line in enumerate(self.code):
            if self.current_line.endswith(':'):
                self.last_label = self.find_label_by_index(self.current_line_index)
            else:
                tokens = self.current_line.split()
                if len(tokens) > 0:
                    if tokens[0] in self.jump_mnemonics:
                        if tokens[-1] <= self.last_label.name and self.last_label.name.startswith('loc'):
                            self.back_jumps.append(Jump(self.current_line_index, tokens[0], tokens[-1]))
                        else:
                            self.forward_jumps.append(Jump(self.current_line_index, tokens[0], tokens[-1]))
                            
        for jump in self.back_jumps:
            self.last_label = self.find_last_label(jump.index)
            beginning = self.find_label_index_by_name(jump.destination)
            if jump.mnemonic == 'jmp':
                self.append_to_insertions(beginning, '; begin loop')
                self.append_to_insertions(jump.index+1, '; end loop')
            else:
                self.find_condition(jump)
                self.append_to_insertions(beginning, '; begin doloop')
                self.append_to_insertions(jump.index+1, '; end doloop')
                #print self.last_label
                #print jump
                self.doloop_ends[self.last_label.index] = (beginning, jump.index+1)
        for jump in self.forward_jumps:
            dest = self.find_label_index_by_name(jump.destination)
            if jump.mnemonic == 'jmp':
                if dest in self.doloop_ends:
                    indexes = self.doloop_ends[dest]
                    self.replace_insertion(indexes[0], '; begin doloop', '; begin loop')
                    self.replace_insertion(indexes[1], '; end doloop', '; end loop')
                    
        #print self.doloop_ends
        for j, i in enumerate(sorted(self.insertions)):
            for k, l in enumerate(self.insertions[i]):
                self.code.insert(i+j+k, l)


    def find_condition(self, jump):
        relevant_data = []
        self.append_to_insertions(jump.index+1, '; end condition')
        for i in range(len(self.code[:jump.index]), 0, -1):
            tokens = self.code[i].split()
            if tokens[0] in ['cmp', 'test']:
                relevant_data = tokens[1:]
            elif len(relevant_data) > 0:
                relevant = False
                for j in relevant_data:
                    if j in tokens:
                        relevant = True
                if not relevant:
                    self.append_to_insertions(i+1, '; begin condition')
                    break
    
    def append_to_insertions(self, index, content):
        if index in self.insertions:
            self.insertions[index].append(content)
        else:
            self.insertions[index] = [content]
    
    def replace_insertion(self, index, old, new):
        index_2 = -1
        if index in self.insertions:
            l = self.insertions[index]
            for j, i in enumerate(l):
                if i == old:
                    index_2 = j
                    break
            l[index_2] = new
            self.insertions[index] = l
    
    #def find_parallel_execution_paths(self):
        #list_of_nodes = []
        #for self.current_line_index, self.current_line in enumerate(self.code):
            #jump = self.find_forward_jump_by_line_index(self.current_line_index)
            #if jump:
                #if jump.mnemonic != 'jmp':
                    #list_of_nodes.append(self.current_line_index)
                    



if __name__ == '__main__':
    p = Parser('tests/conditions.asm')
    p.print_results()
