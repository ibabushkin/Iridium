class Tree:
    def __init__(self):
        self.root = Node()
        self.current_node = self.root
    
    def get_code(self):
        return self.root.children[-1].get_code()

class Node:
    def __init__(self):
        self.children = []
