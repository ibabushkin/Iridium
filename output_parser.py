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
			print 'Function...'
			func_name = string.split('(')[1][:-2] # get <name> from "begin func(<name>)"
			self.stack.append(Function(func_name))
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
			if tokens[1].startswith(self.stack[-1].corresponding_token): # data-validation
				print 'pop '+ self.stack[-1].corresponding_token # debug
				#if self.stack[-1].corresponding_token in ['code', 'loop', 'if']:
				#	self.prefix = self.prefix[:-1]
				if self.stack[-1].corresponding_token == 'code':
					self.stack[-1].content_lines = self.get_lines(self.stack[-1].first_line, index)
				elif self.stack[-1].corresponding_token == 'condition':
					self.stack[-1].code_lines = self.get_lines(self.stack[-1].first_line, index)
				self.append_to_output(self.stack[-1].get_code_end()) # output...
				self.stack.pop()
		else: # other cases, like vars and args... currently no extensive feature-set
			if tokens[0].startswith('bytes'):
				pass
		

class Structure:
	def __init__(self):
		self.corresponding_token = ''
		
	def get_code_begin(self):
		pass
	
	def get_code_end(self):
		pass

class Function(Structure):
	def __init__(self, name, ret='int', args=[]):
		Structure.__init__(self)
		self.name = name
		self.ret = ret
		self.args = args
		self.corresponding_token = 'func'
	
	def get_code_begin(self):
		return self.ret + ' ' + self.name + '(){\n'
	
	def get_code_end(self):
		return '}' 
				
class CodeBlock(Structure):
	def __init__(self, first_line=0):
		Structure.__init__(self)
		self.corresponding_token = 'code'
		self.content_lines = []
		self.first_line = first_line
		
	def get_code_begin(self):
		return '/**\n'
	
	def get_code_end(self):
		return '\n'.join(self.content_lines) + '\n**/\n'

class Loop(Structure):
	def __init__(self):
		Structure.__init__(self)
		#self.do = None # do-while loop?
		self.condition = None
		self.corresponding_token = 'loop'
	
	def get_code_begin(self):
		return 'while('
	
	def get_code_end(self):
		return '}\n'
		
class DoLoop(Structure):
	def __init__(self):
		Structure.__init__(self)
		#self.do = None # do-while loop?
		self.condition = None
		self.corresponding_token = 'doloop'
	
	def get_code_begin(self):
		return 'do{'
	
	def get_code_end(self):
		return ');\n'
		
class If(Structure):
	def __init__(self):
		Structure.__init__(self)
		self.condition = None
		self.corresponding_token = 'if'
	
	def get_code_begin(self):
		return 'if('
	
	def get_code_end(self):
		return '}\n'

class ElseIf(Structure):
	def __init__(self):
		Structure.__init__(self)
		self.condition = None
		self.corresponding_token = 'elseif'
	
	def get_code_begin(self):
		return 'else if('
	
	def get_code_end(self):
		return '}\n'

class Else(Structure):
	def __init__(self):
		Structure.__init__(self)
		self.corresponding_token = 'else'
	
	def get_code_begin(self):
		return 'else{\n'
	
	def get_code_end(self):
		return '}\n'

class Condition(Structure):
	def __init__(self, first_line, do=False):
		Structure.__init__(self)
		self.code_lines = []
		self.first_line = first_line
		self.corresponding_token = 'condition'
		self.do_while_loop = do
	
	def code(self):
		return '\n'.join(self.code_lines)
		
	def get_code_begin(self):
		return ''
	
	def get_code_end(self):
		if not self.do_while_loop:
			return '/**'+ self.code() +'*/){\n'
		return '}while(/**'+ self.code() +'**/'


if __name__ == '__main__':
	o = OutputParser('tests/func.asm') # feed a new file...
	o.parse() # parse it...
	print '=============END OF DEBUG=============='
	print o.output # print the results.
