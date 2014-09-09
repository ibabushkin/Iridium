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
    
    def append(self, obj):
        self.nodes.append(TreeNode(obj))
        self.edges.append((self.current_node, len(self.nodes)-1))
        self.current_node = len(self.nodes) - 1
        #print self.current_node
        
class TreeNode:
    def __init__(self, obj):
        self.content = obj
