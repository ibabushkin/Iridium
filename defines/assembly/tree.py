# class Tree:
# def __init__(self, obj):
#self.content = obj
#self.left = None
#self.right = None

# def set_right(self, obj):
#self.right = Tree(obj)

# def set_left(self, obj):
#self.left = Tree(obj)

# def postorder(self):
# return self.left.postorder() + self.right.postorder() + self.obj


class Tree:

    def __init__(self, obj):
        self.nodes = [TreeNode(obj)]
        self.edges = []
        self.current_node = 0

    def append(self, obj):
        self.nodes.append(TreeNode(obj))
        self.edges.append((self.current_node, len(self.nodes) - 1))
        self.current_node = len(self.nodes) - 1
        # print self.current_node

    def get_children_of(self, id):
        ret = []
        for edge in self.edges:
            if edge[0] == id:
                ret.append(edge[1])
        return ret

    def postorder(self, start=0):
        ret = [self.get_content(start).id]
        for node in self.get_children_of(start):
            ret = self.postorder(node) + ret
        return ret

    def get_content(self, id):
        return self.nodes[id].content


class TreeNode:

    def __init__(self, obj):
        self.content = obj
