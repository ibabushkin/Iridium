from abstractions import Instruction, Function

class Parser:
    def __init__(self, filepath):
        self.code = map(lambda x: x.strip(), open(filepath, 'rb').readlines())
        self.in_function = False
        self.functions = []
        self.obtain_functions()
        self.current_function_beginning_index = None
    
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
            print 'Found function %s' % i.name
            print i
            print '==========================='
            
class FunctionParser:
    def __init__(self, function):
        self.code = function.code
        self.label_indexes = []
        self.last_label = None
    
    def parse(self):
        
            
if __name__ == '__main__':
    p = Parser('tests/2.asm')
    p.print_results()