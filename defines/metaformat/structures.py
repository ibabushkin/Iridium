class Structure:
    # a class used to create a common interface
    # for all structures used by the parser.
    def __init__(self):
        self.corresponding_token = '' # the token used to represent the structure
        self.children_allowed = False
        self.children = []
        self.parent = None
        
    def get_code_begin(self):
        # return the beginnig of the structure (like "if(")
        # @ret string, C-code
        return ''
    
    def get_code_end(self):
        # return the end of the structure (like "}")
        # @ret string, C-code
        return ''
    
    def get_code(self):
		s = self.get_code_begin()
		for i in self.children:
			s += i.get_code()
		s += self.get_code_end()
		return s

class Function(Structure):
    # the abstraction of a function
    def __init__(self, name, ret='int', args=''):
        Structure.__init__(self)
        self.name = name # the name, e.g printf
        self.ret = ret # datatype that is returned
        self.args = args # a list of all args of the form ['int|a', 'char|b']
        self.corresponding_token = 'func' # see class Structure
        self.children_allowed = True
    
    def format_args(self):
        l = len(self.args)
        ret = ''
        for i, j in enumerate(self.args):
            ret += j.replace('|', ' ')
            if i < l-1:
                ret += ', '
        return ret
            
        
    def get_code_begin(self):
        # see class Structure
        return self.ret + ' ' + self.name + '('+ self.format_args() +'){\n'
    
    def get_code_end(self):
        # see class Structure
        return '}' 
                
class CodeBlock(Structure):
    # the abstraction of code block with no branches inside
    def __init__(self, first_line=0):
        Structure.__init__(self)
        self.corresponding_token = 'code' # see class Structure
        self.content_lines = [] # all lines in the ASM-listing
                                # that belong to given code block
        self.first_line = first_line # the index of the first line
        
    def get_code_begin(self):
        # see class Structure
        return '/**\n'
    
    def get_code_end(self):
        # see class Structure
        return '\n'.join(self.content_lines) + '\n**/\n'

class Loop(Structure):
    # the abstraction of a loop
    def __init__(self):
        Structure.__init__(self)
        self.condition = None
        self.corresponding_token = 'loop' # see class Structure
        self.children_allowed = True
    
    def get_code_begin(self):
        # see class Structure
        return 'while('
    
    def get_code_end(self):
        # see class Structure
        return '}\n'
        
class DoLoop(Structure):
    # the abstraction of a do-while loop
    def __init__(self):
        Structure.__init__(self)
        self.condition = None
        self.corresponding_token = 'doloop' # see class Structure
        self.children_allowed = True
    
    def get_code_begin(self):
        # see class Structure
        return 'do{'
    
    def get_code_end(self):
        # see class Structure
        return ');\n'
        
class If(Structure):
    # the abstraction of an if-block
    def __init__(self):
        Structure.__init__(self)
        self.condition = None
        self.corresponding_token = 'if' # see class Structure
        self.children_allowed = True
    
    def get_code_begin(self):
        # see class Structure
        return 'if('
    
    def get_code_end(self):
        # see class Structure
        return '}\n'

class ElseIf(Structure):
    # an else-if structure
    def __init__(self):
        Structure.__init__(self)
        self.condition = None
        self.corresponding_token = 'elseif' # see class Structure
        self.children_allowed = True
    
    def get_code_begin(self):
        # see class Structure
        return 'else if('
    
    def get_code_end(self):
        # see class Structure
        return '}\n'

class Else(Structure):
    # an else structure
    def __init__(self):
        Structure.__init__(self)
        self.corresponding_token = 'else' # see class Structure
        self.children_allowed = True
    
    def get_code_begin(self):
        # see class Structure
        return 'else{\n'
    
    def get_code_end(self):
        # see class Structure
        return '}\n'

class Condition(Structure):
    # the abstraction of a condition
    # similar to a CodeBlock
    def __init__(self, first_line, do=False):
        Structure.__init__(self)
        self.content_lines = [] # a list of all lines that are part
                                # of the condition
        self.first_line = first_line # index of the first line
        self.corresponding_token = 'condition' # see class Structure
        self.do_while_loop = do # condition inside a do-while loop?
                                # (important for rendering output)
    
    def code(self):
        # returns all lines as a string
        # @ret: string, C-code
        return '\n'.join(self.content_lines)
        
    def get_code_begin(self):
        # see class Structure
        return ''
    
    def get_code_end(self):
        # see class Structure
        # more advanced output rendering, see top
        if not self.do_while_loop:
            return '/**'+ self.code() +'*/){\n'
        return '}while(/**'+ self.code() +'**/'
