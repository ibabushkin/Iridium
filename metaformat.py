#! /usr/bin/env python

from defines.metaformat.structures import *
from defines.metaformat.data import Tree

class MetaformatParser():
    def __init__(self, filename):
        self.tree = Tree()
        self.output = ''
        self.lines = map(lambda x: x.strip('\r\n'), open(filename, 'rb').readlines())
        self.prefix = ''

    def parse_structure(self, index, line):
        tokens = line.split(' ')
        if tokens[0] == 'begin':
            string = tokens[1]
            if string.startswith('func'):
                arguments = string.split('(')[1][:-1].split(',')
                a = []
                if len(arguments) > 2:
                    a = arguments[2:]
                result = Function(arguments[0], arguments[1], a)
            elif string.startswith('code'):
                result = CodeBlock(index+1)
            elif string.startswith('loop'):
                result = Loop()
            elif string.startswith('doloop'):
                result = DoLoop()
            elif string.startswith('if'):
                result = If()
            elif string.startswith('elseif'):
                result = ElseIf()
            elif string.startswith('else'):
                result = Else()
            elif string.startswith('condition'):
                do_param = False
                if self.tree.current_node.corresponding_token == 'doloop':
                    do_param = True
                result = Condition(index+1, do_param)    
                
            self.tree.current_node.children.append(result)
            parent = self.tree.current_node
            self.tree.current_node = self.tree.current_node.children[-1]
            self.tree.current_node.parent = parent
            
        elif tokens[0] == 'end':
            if self.tree.current_node.corresponding_token in ['code', 'condition']:
                self.tree.current_node.content_lines = self.get_lines(self.tree.current_node.first_line, index)
            self.tree.current_node = self.tree.current_node.parent
            

    def parse(self):
        # processes all lines of code in order
        # to generate output
        for index, line in enumerate(self.lines):
            if line.startswith(';'): # token recognizing
                self.parse_structure(index, line[2:])

    def get_lines(self, first, last):
        # used to retrieve a block of code
        # @param first: first line to be returned
        # @param last: first line not to be returned
        # @ret: a list of all lines including first, but not last
        #       and everything in between
        return self.lines[first:last]
    
    def generate_output(self):
        return self.tree.get_code()
        
if __name__ == '__main__':
    m = MetaformatParser('tests/func.asm')
    m.parse()
    print m.generate_output()
    
