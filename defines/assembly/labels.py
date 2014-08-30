class Function:
    def __init__(self, name):
        self.name = name
        self.code = []
        
    def __str__(self):
        return '\n'.join(self.code)
        
class Label:
    def __init__(self, index, line):
        self.name = line[:-1]
        self.index = index
    
    def __str__(self):
        return '%s at %i' % (self.name, self.index)

class FunctionLabel(Label):
    def __init__(self, name):
        Label.__init__(self, 0, name+':')


