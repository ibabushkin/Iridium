#! /bin/env python

class OutputParser:
	# the main abstraction of the parsing process. see bottom of file for usage.
	def __init__(self, filename):
		self.stack = [] # stack of current structures
		self.output = '' # output (C-source)
		self.lines = map(lambda x: x.strip('\r\n'), open(filename, 'rb').readlines()) # lines of ASM-source
		self.prefix = '' # used for indentation, currently not used
	
	def append_to_output(self, string):
		# append new statement to output
		# @param string: raw value of output chunk
		self.output += ('\n'+self.prefix).join(string.split('\n'))  
	
	def parse(self):
		# processes all lines of code in order
		# to generate output
		for index, line in enumerate(self.lines):
			if line.startswith(';'): # token recognizing
				self.parse_structure(index, line[2:])
	
	def push_new_element(self, string, index):
		# appends new structure on the stack.
		# used for if's, else's, loops...
		# @param string: token representing the
		# structure to be created, see metaformat-specs(-de).txt
		# for details.
		# @param index: the numer of the current line in the ASM-listing
		if string.startswith('func'): # self-explanatory...
			print 'Function...' # debug
			arguments = string.split('(')[1][:-1].split(',')
			a = []
			if len(arguments) > 2:
				a = arguments[2:]
			self.stack.append(Function(arguments[0], arguments[1], a)) # name, ret. the rest
		elif string.startswith('code'):
			self.stack.append(CodeBlock(index+1))
		elif string.startswith('loop'):
			self.stack.append(Loop())
		elif string.startswith('doloop'):
			self.stack.append(DoLoop())
		elif string.startswith('if'):
			self.stack.append(If())
		elif string.startswith('elseif'):
			self.stack.push(ElseIf())
		elif string.startswith('else'):
			self.stack.push(Else())
		elif string.startswith('condition'):
			do_param = False
			if self.stack[-1].corresponding_token == 'doloop':
				do_param = True
			self.stack.append(Condition(index+1, do_param))
	
	def get_lines(self, first, last):
		# used to retrieve a block of code
		# @param first: first line to be returned
		# @param last: first line not to be returned
		# @ret: a list of all lines including first, but not last
		#       and everything in between
		return self.lines[first:last]
				
	def parse_structure(self, index, line):
		# used to parse one specific token, performing
		# necessary operations on the stack.
		# @param index: the index of the current line (ASM-listing)
		# @param line: the line as a string
		tokens = line.split(' ')
		if tokens[0] == 'begin': # opening a new strucutre? (see specs)
			self.push_new_element(tokens[1], index)
			self.append_to_output(self.stack[-1].get_code_begin()) # output...
			print 'push '+ self.stack[-1].corresponding_token # debug
		elif tokens[0] == 'end': # popping a structure?
			
			##if tokens[1].startswith(self.stack[-1].corresponding_token): # data-validation
			# removed to fit docs ^^
			
			print 'pop '+ self.stack[-1].corresponding_token # debug
			#if self.stack[-1].corresponding_token in ['code', 'loop', 'if']:
			#	self.prefix = self.prefix[:-1]
			if self.stack[-1].corresponding_token in ['code', 'condition']:
				self.stack[-1].content_lines = self.get_lines(self.stack[-1].first_line, index)
			self.append_to_output(self.stack[-1].get_code_end()) # output...
			self.stack.pop()
		else: # other cases, like vars and args... currently no extensive feature-set
			if tokens[0].startswith('bytes'):
				pass
		

class Structure:
	# a class used to create a common interface
	# for all structures used by the parser.
	def __init__(self):
		self.corresponding_token = '' # the token used to represent the structure
		
	def get_code_begin(self):
		# return the beginnig of the structure (like "if(")
		# @ret string, C-code
		return ''
	
	def get_code_end(self):
		# return the end of the structure (like "}")
		# @ret string, C-code
		return ''

class Function(Structure):
	# the abstraction of a function
	def __init__(self, name, ret='int', args=''):
		Structure.__init__(self)
		self.name = name # the name, e.g printf
		self.ret = ret # datatype that is returned
		self.args = args # a list of all args of the form ['int|a', 'char|b']
		self.corresponding_token = 'func' # see class Structure
	
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
		#self.condition = None # not used
		self.corresponding_token = 'loop' # see class Structure
	
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
		#self.condition = None # not used
		self.corresponding_token = 'doloop' # see class Structure
	
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
		#self.condition = None # not used
		self.corresponding_token = 'if' # see class Structure
	
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
		#self.condition = None # not used
		self.corresponding_token = 'elseif' # see class Structure
	
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


if __name__ == '__main__':
	o = OutputParser('tests/func.asm') # feed a new file...
	o.parse() # parse it...
	print '=============END OF DEBUG=============='
	print o.output # print the results.
