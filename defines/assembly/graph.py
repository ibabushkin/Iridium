from instructions import Instruction
from labels import Label
class Graph:
    def __init__(self, text):
        self.text = text
        self.code = self.get_code_from_text()
        self.delimiter_lines = []
        self.nodes = []
        self.edges = []
        self.start = None
        self.end = None
        self.generate_graph()
    
    def get_code_from_text(self):
        # Instruction(self, address, size, mnemonic, operands)
        # Label(self, index, line)
        l = []
        index = 0
        for line in self.text:
            if line.endswith(':'):
                l.append(Label(index, line))
            else:
                tokens = line.split(' ')
                if len(tokens) > 0:
                    m = tokens[0]
                    o = line[len(m)+1:]
                    l.append(Instruction(index, 0, m, o))
            index += 1
        return l
    
    def find_node_by_label(self, label_name):
        for node in self.nodes:
            if isinstance(node.code[0], Label):
                if node.code[0].name == label_name:
                    return node
        return None
    
    def generate_graph(self):
        current_node_id = 0
        current_edge_id = 0
        for index, instruction in enumerate(self.code):
            if isinstance(instruction, Label):
                self.delimiter_lines.append(index)
            elif instruction.is_jump():
                self.delimiter_lines.append(index+1)
        self.delimiter_lines = [0] + sorted(list(set(self.delimiter_lines))) + [len(self.code)]
        for index, content in enumerate(self.delimiter_lines):
            if content != len(self.code):
                c = self.code[content:self.delimiter_lines[index+1]]
                if len(c) > 0:
                    self.nodes.append(Node(current_node_id, c, content, self.delimiter_lines[index+1]))
                    current_node_id += 1
        for node in self.nodes:
            if node.code[-1].is_jump():
                destination = node.code[-1].get_destination()
                destination = self.find_node_by_label(destination)
                self.edges.append(Edge(current_edge_id, node.id, destination.id))
                current_edge_id += 1
            if node.code[-1].is_conditional_jump():
                #try:
                print node.code[-1].mnemonic, node.code[-1].operands
                destination = self.nodes[node.id+1]
                self.edges.append(Edge(current_edge_id, node.id, destination.id))
                current_edge_id += 1
                #except:
                 #   pass
        for i in self.nodes:
            print i
                
class Node:
    def __init__(self, id, code, first, last):
        self.id = id
        self.code = code
        self.first_index = first
        self.last_index = last
    
    def get_label_if_present(self):
        if isinstance(self.code[0], Label):
            return self.code[0].name
        return ''
    
    def get_code_representation(self):
        ret = ''
        for instruction in self.code:
            ret += instruction.__str__() +'\n'
        return ret
    
    def __str__(self):
        return '\n=== '+ str(self.id) +' '+ str(self.first_index) +' '+ str(self.last_index) +' ===\n'+ self.get_code_representation()

class Edge:
    def __init__(self, id, start, end):
        self.id = None
        self.start = None
        self.end = None

if __name__ == '__main__':
    l = map(lambda x: x.strip('\n'), open('../../output1.asm', 'rb').readlines())
    g = Graph(l)
