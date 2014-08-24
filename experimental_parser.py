from abstractions import Instruction, Function, Label, FunctionLabel

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
                    self.functions[-1].code = self.get_code(self.current_function_beginning_index, index+1)
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
        self.labels = []
        self.last_label = FunctionLabel(function.name)
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
        self.insertions = {}
        self.loop_beginnings = []
        self.doloop_beginnings = []
    
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
                        print 'to: ' + tokens[-1] + ' from block ' + self.last_label.name, 
                        if tokens[-1] <= self.last_label.name and self.last_label.name.startswith('loc'):
                            print 'jumping back'
                            if tokens[0] == 'jmp':
                                print 'non-conditional, end of loop (while/for)'
                                self.insertions[self.current_line_index] = '; end loop'
                            else:
                                print 'conditional, end of do-while or special loop'
                                self.insertions[self.current_line_index] = '; end doloop'
                                #self.doloop_beginnings.append(self.find_label_index_by_name(tokens[-1]))
                        else:
                            print 'jumping forward'
                            if tokens[0] == 'jmp':
                                print 'non-conditional, goto or special loop'
                                self.insertions[self.current_line_index] = '; begin doloop'
                            else:
                                print 'conditional jump out of loop (while/for)'
                                self.insertions[self.current_line_index] = '; end condition'
        for j, i in enumerate(sorted(self.insertions)):
            k = 1
            if j == 0: k = 0
            self.code.insert(i+j+k, self.insertions[i])
        for self.current_line_index, self.current_line in enumerate(self.code):
            if self.current_line == '; end doloop':
                self.doloop_beginnings.append(self.find_label_index_by_name(self.code[self.current_line_index-1].split()[-1]))
        for num, loop_beginning in enumerate(self.doloop_beginnings):
            offset = 1
            if num == 0:
                offset = 0
            if self.code[loop_beginning-2] != '; begin doloop':
                self.code.insert(loop_beginning+num+offset, '; begin doloop')
            

        
            
if __name__ == '__main__':
    p = Parser('tests/2.asm')
    p.print_results()