from instructions import Instruction
from labels import Label
from tree import Tree


class Graph:
    # the representation of a CFG
    def __init__(self, text):
        # @param text: list of code-lines
        self.text = text
        self.code = self.get_code_from_text() # generating a list of Instruction-
                                              # and Label-instances
        self.delimiter_lines = []             # "borders" of the nodes
        self.nodes = []
        self.edges = []
        self.start_node_index = 0        # node to be entered first by CPU
        self.end_node_index = None            # node determining the end of execution
        self.generate_graph()
        self.tree = None
        self.generate_depth_first_spanning_tree()
        self.p = self.tree.postorder()
        self.ways = []
        #print self.is_target_of_back_edge(self.nodes[8])
        self.analyze_tree()
        for i in self.nodes:
            print i
        for i in self.edges:
            print i
    
    def get_code_from_text(self):
        # creates a list of objects carifieing the working of the
        # corresponding line
        # @ret: list of objects
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
        # returns the node, that begins with a label
        # having the given name
        # @param label_name: label's name
        # @ret: node-object
        for node in self.nodes:
            if isinstance(node.code[0], Label):
                if node.code[0].name == label_name:
                    return node
        return None
    
    def generate_graph(self):
        # generates a graph from a list of Instruction- and
        # Label-instances
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
                #print destination
                destination = self.find_node_by_label(destination)
                self.edges.append(Edge(current_edge_id, node.id, destination.id))
                current_edge_id += 1
            if node.code[-1].is_conditional_jump() or not node.code[-1].is_jump():
                if node.id != len(self.nodes) -1:
                    destination = self.nodes[node.id+1]
                    self.edges.append(Edge(current_edge_id, node.id, destination.id))
                    current_edge_id += 1
        self.start_node_index = 0
        self.end_node_index = len(self.nodes) - 1
    
    def generate_depth_first_spanning_tree(self):
        # generates a dfs-tree for the graph
        # helper-function, uses self.visit_depth_first and
        # sets the tree up
        self.tree = Tree(self.nodes[self.start_node_index])
        self.visit_depth_first(self.start_node_index)
    
    def visit_depth_first(self, node_id):
        # df-traversal of the graph
        # @param node_id: id of node from
        # which the traversal should start
        # working recursively
        self.nodes[node_id].flags['traversed'] = True
        cur_node = self.tree.current_node
        for i in self.get_next_nodes(node_id):
            if not 'traversed' in self.nodes[i].flags:
                self.tree.append(self.nodes[i])
                self.visit_depth_first(i)
            self.tree.current_node = cur_node
    
    def is_simple_acyclic(self, node):
        # determines, wether given node is the beginning
        # of a simple acyclic structure (block, if-else of if-then)
        # @ret: boolean value determining result
        return self.is_block(node) or self.is_if_then(node)\
                or self.is_if_then_else(node)
    
    def remove_nodes(self, id_list):
        # removes all nodes, whose id is in id_list from the graph
        # @param id_list: a list of int's
        nodes = [self.nodes[i] for i in id_list]
        self.nodes = filter(lambda x: x not in id_list, self.nodes)
        print self.nodes
    
    def get_edges_for_subgraph(self, nodes):
        # returns all edges between the given nodes
        # removes these edges from graph afterwards.
        # @param nodes: a list of Node-instances
        # @ret: a list of Edge-instances
        id_list = [i.id for i in nodes]
        edges = []
        for i in self.edges:
            if i.start in id_list and i.end in id_list:
                edges.append(i)
        self.edges = filter(lambda x: x not in edges, self.edges)
        return edges
    
    def replace_edges(self, new_id, id_list):
        # replaces all edges, that are adjacent to a node
        # identified by an id in id_list, by the value of 
        # new_id
        # @param new_id: int, the new id to be inserted int the edge
        # @param id_list: all nodes, whose edges are to be processed
        for index, edge in enumerate(self.edges):
            if edge.end in id_list:
                self.edges[index].end = new_id
            elif edge.start in id_list:
                self.edges[index].start = new_id
    
    def insert_structure_as_node(self, nodes, structtype):
        # used to replace a group of nodes that are identified as a structure
        # by a special object in the graph that contains them all.
        # @param nodes: list of Node-instances
        # @param structtype: str determining the type of structure inserted
        edges = self.get_edges_for_subgraph(nodes)
        id_list = [i.id for i in nodes]
        self.nodes.append(StructNode(len(self.nodes), nodes, edges, structtype))
        self.replace_edges(len(self.nodes)-1, id_list)
        if self.start_node_index in id_list:
            self.start_node_index = len(self.nodes)-1
        #print id_list
        #self.remove_nodes(id_list)
    
    def is_block(self, node):
        # is a given node (part of) a block?
        return len(self.get_next_nodes(node.id)) < 2
    
    def is_if_then(self, node):
        # is a given node beginning of an if-block?
        n = self.get_next_nodes(node.id)
        if len(n) == 2:
            n1 = n[0]
            n2 = n[1]
            n1_next = self.get_next_nodes(n1)
            n2_next = self.get_next_nodes(n2)
            if n2 in n1_next:
                return len(n1_next) == 1
            elif n1 in n2_next:
                return len(n2_next) == 1
        return False
    
    def is_if_then_else(self, node):
        # is a given node begnning of an if-else-block?
        n = self.get_next_nodes(node.id)
        if len(n) == 2:
            n1 = n[0]
            n2 = n[1]
            n1_next = self.get_next_nodes(n1)
            n2_next = self.get_next_nodes(n2)
            return len(n1_next) == 1 and n1_next == n2_next
        return False

    def _find_all_ways(self, s=0, e=0, w=[]):
        w.append(s)
        if s == e:
            self.ways.append(w)
        else:
            for i in self.get_next_nodes(s):
                if i not in w:
                    self._find_all_ways(i, e, w)
    
    def _check_dominance(self, a):
        l = map(lambda x: a in x, self.ways)
        return not (False in l)
    
    def is_dominator(self, a, b):
        self.ways = []
        self._find_all_ways(0, b, [])
        return self._check_dominance(a)
    
    def is_target_of_back_edge(self, node):
        # is there a back-edge targeting given node?
        for i in self.get_previous_nodes(node.id): 
            if self.is_dominator(node.id, i):
                return True
        return False
    
    def get_node_list_for_replacement(self, start, structtype):
        # returns a list of Node-instances that are reachable from start
        # under certain conditions
        ret = [start.id]
        if structtype == 'if-then':
            nexts = self.get_next_nodes(start.id)
            conditional = None
            for i in nexts:
                ns = self.get_next_nodes(i)
                if len(ns) != 0:
                    if ns[0] in nexts:
                        conditional = i
            ret += [conditional]
            #ret += self.get_next_nodes(start.id)
        elif structtype == 'if-then-else':
            ret += self.get_next_nodes(start.id)
            #ret += self.get_next_nodes(ret[-1])
        elif structtype == 'block':
            ret += self.find_linear_block(start.id)
        ret = list(set(ret))
        if len(ret) > 1:
            pass#print ret
        return filter(lambda x: x.id in ret, self.nodes)
    
    def find_linear_block(self, id):
        return list(set(self.find_linear_block_forward(id) + self.find_linear_block_backward(id)))
    
    def find_linear_block_backward(self, id, l=[]):
        prevs = self.get_previous_nodes(id)
        ret = l + [id]
        if len(prevs) == 1 and len(self.get_next_nodes(prevs[0])) == 1:
            ret += self.find_linear_block_backward(prevs[0], ret)
        return ret
        
    def find_linear_block_forward(self, id, l=[]):
        posts = self.get_next_nodes(id)
        ret = l + [id]
        if len(posts) == 1 and len(self.get_previous_nodes(posts[0])) == 1:
            ret += self.find_linear_block_forward(posts[0], ret)
        if len(ret) > 1:
            return ret
        return []
    
    def analyze_node(self, n, i):
        struct_found = None
        if self.is_simple_acyclic(n):
            if self.is_if_then(n):
                print str(i) +':'+ 'if-then'
                nodes_to_replace = self.get_node_list_for_replacement(n, 'if-then')
                self.insert_structure_as_node(nodes_to_replace, 'if-then')
                struct_found = self.nodes[-1]
                #print self.edges
            elif self.is_if_then_else(n):
                print str(i) +':'+ 'if-then-else'
                nodes_to_replace = self.get_node_list_for_replacement(n, 'if-then-else')
                self.insert_structure_as_node(nodes_to_replace, 'if-then-else')
                struct_found = self.nodes[-1]
                #print self.edges
            elif self.is_block(n):
                nodes_to_replace = self.get_node_list_for_replacement(n, 'block')
                if len(nodes_to_replace) > 1:
                    print str(i) +':'+ 'block'
                    self.insert_structure_as_node(nodes_to_replace, 'block')
                    struct_found = self.nodes[-1]
        elif self.is_target_of_back_edge(n):
            prevs = self.get_previous_nodes(n.id)
            if n.id in prevs:
                print str(i) +':'+ 'self-loop'
                self.insert_structure_as_node([n], 'self-loop')
                struct_found = self.nodes[-1]
            else:
                nexts = self.get_next_nodes(n.id)
                for j in nexts:
                    if n.id in self.get_next_nodes(j):
                        print str(i) +':'+ 'while-loop'
                        self.insert_structure_as_node([n, self.nodes[j]], 'while-loop')
                        struct_found = self.nodes[-1]
        if struct_found:
            self.analyze_node(struct_found, struct_found.id)
    
    def cleanup_edges(self):
        new_edges = []
        for edge in self.edges:
            found = False
            for new_edge in new_edges:
                if edge == new_edge:
                    found = True
            if not found:
                new_edges.append(edge)
        #print self.edges == new_edges
        self.edges = new_edges
    
    def analyze_tree(self):
        # parsing algorithm for the dfs-tree, rudimental
        for i in self.p:
            n = self.nodes[i]
            self.analyze_node(n, i)
            self.cleanup_edges()
                        
    
    def get_next_nodes(self, node_id):
        # returns a list of all node-id's
        # that can be reached directly from a given node
        ret = []
        for edge in self.edges:
            if edge.start == node_id:
                ret.append(edge.end)
        return list(set(ret))
    
    def get_previous_nodes(self, node_id):
        # returns a list of alll node-id's that are direct
        # predecessos of a given node
        ret = []
        for edge in self.edges:
            if edge.end == node_id:
                ret.append(edge.start)
        return list(set(ret))
    
    def traverse(self):
        # traversing-algorithm for the graph
        # uses self.visit recursively
        # deprecated
        current_node_index = self.start_node_index
        self.visit(current_node_index)
        for i in self.nodes:
            print i.id, i.flags
    
    def visit(self, node_index):
        # recursive visiting and flag-setting of graph nodes
        # deprecated
        self.nodes[node_index].flags['visited'] = True
        next_nodes = self.get_next_nodes(node_index)
        for next_node in next_nodes:
            if next_node <= node_index:
                self.nodes[next_node].flags['loop_beginning'] = True
                self.nodes[next_node].flags['reached_multiple'] = True
                self.nodes[node_index].flags['loop_end'] = True
                if self.nodes[node_index].code[-1].is_conditional_jump():
                    self.nodes[node_index].flags['loop_condition'] = True
                else:
                    self.nodes[next_node].flags['loop_condition'] = True
            if not self.nodes[next_node].flags['visited']:
                self.visit(next_node)
            else:
                self.nodes[next_node].flags['reached_multiple'] = True
                prev_nodes = self.get_previous_nodes(next_node)
            

class Node:
    # a representation of a one-entry, one-exit sequence of code
    def __init__(self, id, code, first, last):
        self.id = id
        self.code = code
        self.first_index = first
        self.last_index = last
        self.flags = None
        self.reset_flags()
        self.dominators = []
    
    def reset_flags(self):
        self.flags = {'visited':False, 'reached_multiple':False}
    
    def get_label_if_present(self):
        # returns a label's name at the beginning of
        # the code-sequence, if present
        if isinstance(self.code[0], Label):
            return self.code[0].name
        return ''
    
    def get_code_representation(self):
        # returns own code as string
        ret = ''
        for instruction in self.code:
            ret += instruction.__str__() +'\n'
        return ret
    
    def __str__(self):
        # pretty printing
        return '\n=== '+ str(self.id) +' '+ str(self.first_index) +' '+ str(self.last_index) +' ===\n'+ self.get_code_representation()
    
    def print_fancy(self, prefix='', child_prefix=''):
        print prefix + str(self.id)

class StructNode:
    # a representaton of a structure inside a graph, placeholder for all nodes inside
    def __init__(self, id, nodes, edges, structtype):
        self.id = id
        self.nodes = nodes
        self.edges = edges
        self.structtype = structtype
    
    def __str__(self):
        return str(self.id) +' '+ self.structtype + ' ' + self.get_representation()
    
    def get_representation(self):
        ret = ''
        for i in self.nodes:
            ret += str(i.id) + ' '
        return ret
    
    def print_fancy(self, prefix='', child_prefix='|-- '):
        print prefix + 'id: ' + str(self.id) + ' type: ' + self.structtype + ':'
        prefix = prefix + '    '
        print prefix + child_prefix + 'nodes:'
        for i in self.nodes:
            i.print_fancy(prefix+'|   ', child_prefix)
        print prefix + child_prefix +'edges:'
        for i in self.edges:
            print '    |   ' + prefix + i.__str__()

class Edge:
    # a graph-edge
    def __init__(self, id, start, end):
        self.id = id
        self.start = start
        self.end = end
    
    def __str__(self):
        # not so pretty printing
        return str(self.start) +' '+ str(self.end)
    
    def __eq__(self, other): 
        return self.start == other.start and self.end == other.end

if __name__ == '__main__':
    # test stuff
    l = map(lambda x: x.strip('\n'), open('../../output2.asm', 'rb').readlines())
    g = Graph(l)
    print
    g.nodes[g.start_node_index].print_fancy()
    
