#class Tree:
    #def __init__(self, obj):
        #self.content = obj
        #self.left = None
        #self.right = None
    
    #def set_right(self, obj):
        #self.right = Tree(obj)
    
    #def set_left(self, obj):
        #self.left = Tree(obj)
    
    #def postorder(self):
        #return self.left.postorder() + self.right.postorder() + self.obj
        
class Tree:
    def __init__(self, obj):
        self.nodes = [TreeNode(obj)]
        self.edges = []
        self.current_node = 0
        #self.current_stack = []
    
    def append(self, obj):
        self.nodes.append(TreeNode(obj))
        self.edges.append((self.current_node, len(self.nodes)-1))
        #self.current_stack.append(self.current_node)
        self.current_node = len(self.nodes) - 1
    
    #def revert_stack(self):
      #  self.current_node = self.current_stack.pop()
        
class TreeNode:
    def __init__(self, obj):
        self.content = obj
