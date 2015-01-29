"""
File: tree.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: None
Description:
    A tree used to store DFS-trees for the CFG-module.
"""


class Tree(object):
    """
    The tree mentioned in the module-docstring.
    Probably a Gingko.
    """
    def __init__(self, obj):
        self.nodes = [TreeNode(obj)]
        self.edges = []
        self.current_node = 0

    def append(self, obj):
        """
        Append an object as a node to the tree.
        Use the current node as the place for insertion.
        """
        self.nodes.append(TreeNode(obj))
        self.edges.append((self.current_node, len(self.nodes) - 1))
        self.current_node = len(self.nodes) - 1
        # print self.current_node

    def get_children_of(self, index):
        """
        Get a node's children.
        """
        ret = []
        for edge in self.edges:
            if edge[0] == index:
                ret.append(edge[1])
        return ret

    def postorder(self, start=0):
        """
        Get the postorder traversal of the tree.
        """
        ret = [self.get_content(start).id]
        for node in self.get_children_of(start):
            ret = self.postorder(node) + ret
        return ret

    def get_content(self, index):
        """
        Get the object saved in a node.
        """
        return self.nodes[index].content


class TreeNode(object):
    """
    A node for the tree.
    Can save an object.
    """
    def __init__(self, obj):
        self.content = obj
