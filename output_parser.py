#! /bin/env python

class OutputParser:
	def __init__(self, filename):
		self.stack = []
		self.output = ''
		self.lines = map(lambda x: x.strip('\r\n'), open(filename, 'rb').readlines())
		self.prefix = ''
	
	def append_to_output(self, string):
		self.output += ('\n'+self.prefix).join(string.split('\n'))  
	
	def parse(self):
		for index, line in enumerate(self.lines):
			if line.startswith(';'):
				self.parse_structure(index, line[2:])
	
	def push_new_element(self, string, index):
		if string.startswith('func'):
			print 'Function...'
			func_name = string.split('(')[1][:-2] # get <name> from "begin func(<name>)"
			self.stack.append(Function(func_name))
		elif string.startswith('code'):
			self.stack.append(CodeBlock(index+1))
		elif string.startswith('loop'):
			self.stack.append(Loop())
		elif string.startswith('if'):
			self.stack.append(If())
		elif string.startswith('elseif'):
			self.stack.push(ElseIf())
		elif string.startswith('else'):
			self.stack.push(Else())
		elif string.startswith('condition'):
			self.stack.append(Condition(index+1))
	
	def get_lines(self, first, last):
		return self.lines[first:last]
			
		#if not string in ['code', 'loop', 'if']:
		#s	self.prefix += '\t'
				
	def parse_structure(self, index, line):
		tokens = line.split(' ')
		if tokens[0] == 'begin':
			self.push_new_element(tokens[1], index)
			self.append_to_output(self.stack[-1].get_code_begin())
			print 'push '+ self.stack[-1].corresponding_token
		elif tokens[0] == 'end':
			if tokens[1].startswith(self.stack[-1].corresponding_token):
				print 'pop '+ self.stack[-1].corresponding_token
				#if self.stack[-1].corresponding_token in ['code', 'loop', 'if']:
				#	self.prefix = self.prefix[:-1]
				if self.stack[-1].corresponding_token == 'code':
					self.stack[-1].content_lines = self.get_lines(self.stack[-1].first_line, index)
				elif self.stack[-1].corresponding_token == 'condition':
					self.stack[-1].code_lines = self.get_lines(self.stack[-1].first_line, index)
				self.append_to_output(self.stack[-1].get_code_end())
				self.stack.pop()
		else:
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
		self.do = None # do-while loop?
		self.condition = None
		self.corresponding_token = 'loop'
	
	def get_code_begin(self):
		return 'while('
	
	def get_code_end(self):
		return '}\n'
		
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
	def __init__(self, first_line):
		Structure.__init__(self)
		self.code_lines = []
		self.first_line = first_line
		self.corresponding_token = 'condition'
	
	def code(self):
		return ''.join(self.code_lines)
		
	def get_code_begin(self):
		return ''
	
	def get_code_end(self):
		return '/**'+ self.code() +'*/){\n'

o = OutputParser('tests/func.asm')
o.parse()
print o.output
