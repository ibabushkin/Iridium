from instructions import Instruction

class Function:
    def __init__(self, name):
        self.name = name
        self.code = []
        self.instructions = []
        
    def __str__(self):
        return '\n'.join(self.code)
    
    def set_code(self, l):
        for j, i in enumerate(l):
            if len(i) > 0 and not i.endswith(':'):
                m = i.split()[0]
                o = i[len(m)+1:]
                if ';' in o:
                    #print o
                    o = o.split(';')[0][:-2]
                    #print o
                self.instructions.append(Instruction(j, 0, m, o))
        self.code = l
        
class Label:
    def __init__(self, index, line):
        self.name = line[:-1]
        self.index = index
    
    def __str__(self):
        return '%s:' % self.name

class FunctionLabel(Label):
    def __init__(self, name):
        Label.__init__(self, 0, name+':')


