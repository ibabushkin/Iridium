import argparse
import sys

from instructions import Instruction
from labels import Label
from tree import Tree
from types import *
from parser import Parser

class Graph(Parser):
    # the representation of a CFG
    def __init__(self, text):
        Parser.__init__(self, text)
        self.delimiter_lines = [] # used to split the code into nodes
        self.nodes = {} # the id is the key, thus nodes can be removed without any problems
        self.edges = [] # still a list
        self.start_node_index = 0 # entrypoint of function
        self.largest_id = None # used to find out which id to use
        self.end_node_index = None # last node
        self.generate_graph()
        self.tree = None
        self.ways = []
        self.ways2 = []
        
    def print_graph(self):
        # prints all nodes and edges, without walking them recursively
        for i in self.nodes:
            print self.nodes[i]
        for i in self.edges:
            print i
    
    def reduce(self):
        # reduce the graph
        self.generate_depth_first_spanning_tree()
        self.p = self.tree.postorder()
        print '=================='
        print 'Reducing graph ...'
        print 'postorder of dfs-tree:', self.p
        self.analyze_tree()
        self.print_fancy()
        
    def print_fancy(self):
        # output the analysis results.
        self.nodes[self.start_node_index].print_fancy() # ugly
        
    def find_node_by_label(self, label_name):
        # returns the node, that begins with a label
        # having the given name
        # @param label_name: label's name
        # @ret: node-object
        for node_index in self.nodes:
            node = self.nodes[node_index]
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
                    self.nodes[current_node_id] = Node(current_node_id, c, content, self.delimiter_lines[index+1])
                    current_node_id += 1
        for node_index in self.nodes:
            node = self.nodes[node_index]
            if node.code[-1].is_jump():
                destination = node.code[-1].get_destination()
                destination = self.find_node_by_label(destination)
                if destination:
                    self.edges.append(Edge(current_edge_id, node.id, destination.id))
                    current_edge_id += 1
                else:
                    print 'encountered jump to non-local destination, probably a call.'
            if node.code[-1].is_conditional_jump() or not node.code[-1].is_jump():
                if node.id != len(self.nodes) -1:
                    destination = self.nodes[node.id+1]
                    self.edges.append(Edge(current_edge_id, node.id, destination.id, False))
                    # "inactive edges" are handled here, those are edges that represent
                    # code-control-motion caused by not taken jumps or simply the next
                    # instruction line. Used to determine the then/else relationships
                    # in if-then-else structures.
                    current_edge_id += 1
        self.start_node_index = 0
        self.end_node_index = len(self.nodes) - 1
        self.largest_id = current_node_id
    
    def generate_depth_first_spanning_tree(self):
        # generates a dfs-tree for the graph
        # helper-function, uses self.visit_depth_first and
        # sets the tree up
        self.tree = Tree(self.nodes[self.start_node_index])
        for node_index in self.nodes:
            self.nodes[node_index].reset_flags()
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

    def is_simple_acyclic(self, node_id):
        # determines, wether given node is the beginning
        # of a simple acyclic structure (block, if-else of if-then)
        # @ret: boolean value determining result
        return self.is_block(node_id) or self.is_if_then(node_id) or self.is_if_then_else(node_id)
    
    def remove_nodes(self, id_list):
        # removes all nodes, whose id is in id_list, from the graph
        # @param id_list: a list of int's
        self.nodes = {i:self.nodes[i] for i in self.nodes if i not in id_list}
        
    
    def get_edges_for_subgraph(self, id_list):
        # returns all edges starting and ending at the given nodes
        # removes these edges from the graph afterwards.
        # @param id_nodes: a list of Node-id's
        # @ret: a list of Edge-instances
        edges = []
        for i in self.edges:
            if i.start in id_list and i.end in id_list:
                edges.append(i)
        self.edges = filter(lambda x: x not in edges, self.edges)
        return edges
    
    def replace_edges(self, new_id, id_list):
        # replaces beginning or end of all edges that are adjacent to nodes
        # identified by an element of id_list, by the value of 
        # new_id
        # @param new_id: int, the new id to be inserted into the edge
        # @param id_list: all nodes, whose edges are to be processed, given as a list of id's
        #print 'replace_edges'
        for edge in self.edges:
            if edge.end in id_list:
                #print 'be', edge.end
                edge.end = new_id
               # print 'ae', edge.end
            elif edge.start in id_list:
                #print 'bs', edge.start
                edge.start = new_id
                #print 'as', edge.start
            #print edge

    def get_nodes(self, id_list):
        return [self.nodes[i] for i in self.nodes if i in id_list]

    def insert_structure_as_node(self, id_list, structtype, start_id=0):
        # used to replace a group of nodes that are identified as a structure
        # by a special object in the graph that contains them all.
        # @param id_list: list of Node-instances - change to id's
        # @param structtype: str determining the type of structure inserted
        edges = self.get_edges_for_subgraph(id_list)
        new_id = self.largest_id
        self.largest_id += 1
        self.nodes[new_id] = StructNode(new_id, self.get_nodes(id_list), edges, structtype, start_id)
        self.replace_edges(new_id, id_list)
        if self.start_node_index in id_list:
            self.start_node_index = new_id
        self.remove_nodes(id_list)
    
    def is_block(self, node_id):
        # is a given node (part of) a block?
        # yeah, it's stupid I know...
        return len(self.get_next_nodes(node_id)) < 2
    
    def is_if_then(self, node_id):
        # is a given node beginning of an if-then-block?
        n = self.get_next_nodes(node_id)
        if len(n) == 2:
            n1 = n[0]
            n2 = n[1]
            n1_next = self.get_next_nodes(n1)
            n2_next = self.get_next_nodes(n2)
            if n2 in n1_next and len(self.get_previous_nodes(n1)) == 1\
            and len(self.get_previous_nodes(n2)) >= 2:
                return len(n1_next) == 1
            elif n1 in n2_next and len(self.get_previous_nodes(n2)) == 1\
            and len(self.get_previous_nodes(n1)) >= 2:
                return len(n2_next) == 1
        return False
     
    def is_if_then_else(self, node_id):
        # is a given node beginning of an if-else-block?
        n = self.get_next_nodes(node_id)
        if len(n) == 2:
            n1 = n[0]
            n2 = n[1]
            n1_next = self.get_next_nodes(n1)
            n2_next = self.get_next_nodes(n2)
            if len(self.get_previous_nodes(n1)) == 1 and len(self.get_previous_nodes(n2)) == 1:
                return len(n1_next) == 1 and n1_next == n2_next
        return False
    
    def get_all_visited_nodes(self):
        # returns all nodes already traversed and saved in self.ways.
        ret = []
        for i in self.ways:
            for j in i:
                if j not in ret:
                    ret.append(j)
        return ret

    def _find_all_ways(self, s=0, e=0, w=[]):
        # finds all possible paths from a given entry-node s to a node e
        # works recursively and accepts w for the current progress
        w.append(s)
        if s == e:
            self.ways.append(w)
        else:
            for i in self.get_next_nodes(s):
                if i not in w:
                    self._find_all_ways(i, e, w[:])
    
    def _check_dominance(self, a):
        # is a dominant to all currently saved paths?
        l = map(lambda x: a in x, self.ways)
        return not (False in l)

    def is_dominator(self, a, b):
        # does a dominate b?
        self.ways = []
        self._find_all_ways(0, b, [])
        return self._check_dominance(a)

    def is_target_of_back_edge(self, node_id):
        # is there a back-edge targeting given node?
        for i in self.get_previous_nodes(node_id): 
            ret = self.is_dominator(node_id, i)
            if ret: return i
        return False
    
    def get_node_list_for_replacement(self, start_id, structtype):
        # returns a list of Node-id's that are reachable from start_id
        ret = [start_id]
        if structtype == 'if-then':
            nexts = self.get_next_nodes(start_id)
            conditional = None
            for i in nexts:
                ns = self.get_next_nodes(i)
                if len(ns) != 0:
                    if ns[0] in nexts:
                        conditional = i
            ret += [conditional]
        elif structtype == 'if-then-else':
            ret += self.get_next_nodes(start_id)
        elif structtype == 'block':
            ret += self.find_linear_block(start_id)
        return list(set(ret))
        #return filter(lambda x: x.id in ret, self.nodes)
    
    def find_linear_block(self, node_id):
        # find a linear structure in a graph beginning
        # from any node, working forward.
        return self.find_linear_block_forward(node_id)
    
    def find_linear_block_backward(self, node_id, l=[]):
        # helper method
        prevs = self.get_previous_nodes(node_id)
        ret = l + [node_id]
        if len(prevs) == 1 and len(self.get_next_nodes(prevs[0])) == 1:
            ret += self.find_linear_block_backward(prevs[0], ret)
        return ret
    
    def find_linear_block_forward(self, node_id, l=[]):
        # helper method
        posts = self.get_next_nodes(node_id)
        ret = l + [node_id]
        if len(posts) == 1 and len(self.get_previous_nodes(posts[0])) == 1:
            ret += self.find_linear_block_forward(posts[0], ret)
        if len(ret) > 1:
            return ret
        return []
    
    def appendable_to_block(self, node_id):
        # is a given node already recognized as a possible block
        # appendable to the following node (that must be a block in such case)
        n = self.get_next_nodes(node_id)[0]
        appendable = isinstance(self.nodes[n], StructNode) and self.nodes[n].structtype == 'block'
        print 'appendable to', n, '...', appendable
        return appendable
    
    def append_to_block(self, node_id):
        # append given node to following block node
        n = self.nodes[self.get_next_nodes(node_id)[0]]
        n.nodes.append(self.nodes[node_id])
        for edge in self.edges:
            if edge.start == node_id and edge.end == n.id:
                n.edges.append(edge)
                n.edges[-1].end = n.start_id
                n.start_id = node_id
                self.edges.remove(edge)
                break
        if self.start_node_index == node_id:
            self.start_node_index = n.id
        for edge in self.edges:
            if edge.end == node_id:
                edge.end = n.id
        n.order_nodes_by_edges()
        self.remove_nodes([node_id])
        return n.id
    
    def calculate_paths(self, start, depth, path=[]):
        # calculate all possible controlflow-paths from a
        # given node with given depth. saves results in self.ways2.
        # works recursively, thus the path argument.
        current_path = path[:] + [start]
        next_nodes = self.get_next_nodes(start)
        if depth == 0 or len(next_nodes) == 0:
            self.ways2.append(current_path)
        else:
            for i in next_nodes:
               if not self.is_dominator(i, start):
                   self.calculate_paths(i, depth-1, current_path)
               else:
                   self.ways2.append(current_path)

    def analyze_paths(self, loop):
        # based on the calculated paths, find conditions and replace them
        # by single StructNodes, that mark them as such. Also, ugliest code
        # ever. Seriously. URGENT: rewrite if possible!!!
        visited_nodes = []
        source = self.is_target_of_back_edge(self.ways2[0][0])
        for i in self.ways2:
            for j in i:
                if j not in visited_nodes:
                    visited_nodes.append(j)
        omnipresent_nodes = visited_nodes[:]
        if loop:
            self.ways2 = filter(lambda x: source not in x, self.ways2)
        for i in visited_nodes:
            for j in self.ways2:
                if i not in j:
                    if i in omnipresent_nodes:
                        omnipresent_nodes.remove(i)
        first_knot = None # first node after structure
        #print i
        if loop:
            self.ways = []
            self._find_all_ways(self.ways2[0][0], source, [])
            #print self.ways
           # if len(self.ways) == 0:
            first_knot = i
        elif self.ways2:
            for i in self.ways2[0][1:]:
                if i in omnipresent_nodes:
                    first_knot = i
                    break     
        if first_knot: print 'found knot-node:',first_knot
        self.ways2 = map(lambda x: x[:x.index(first_knot)], self.ways2)
        structure_nodes = []
        red = True # reduce or not?
        conditions = []
        for i in self.ways2:
            for j in i:
                if j not in structure_nodes:
                    structure_nodes.append(j)
        for i in structure_nodes:
            if len(self.get_next_nodes(i)) == 2:
                self.nodes[i].comment = 'part of complex condition'
                conditions.append(i)
            else:
                self.nodes[i].comment = 'code'
            prevs = self.get_previous_nodes(i)
            for j in prevs:
                if j not in structure_nodes and i != self.ways2[0][0]:
                    red = False
        if red:
            self.insert_structure_as_node(conditions, 'condition', self.ways2[0][0])

    def analyze_node(self, node_id):
        # analyzes a node using the dfs-tree
        print '=================='
        print 'analyzing node', node_id, '...'
        struct_found = None
        loop = False
        back = self.is_target_of_back_edge(node_id)
        print 'target of backedge  ...', back
        branching = len(self.get_next_nodes(node_id)) == 2
        print 'branching ...', branching
        # using conditions analysis...
        if back:
            loop = len(self.get_next_nodes(back)) != 2
            print 'loop...', loop
        if self.is_simple_acyclic(node_id) or self.is_loop(node_id):
            print 'found simple structure.'
            self.nodes[node_id].comment = 'simple condition'
        elif branching:
            print 'couldn\'t find simple structure.'
            for ind in range(1, 10):
                self.ways2 = []
                self.calculate_paths(start=node_id, depth=5*ind)
                try:
                    self.analyze_paths(loop)
                    node_id = self.largest_id - 1
                    break
                except ValueError:
                    pass
        # normal reduction begins here...
        if self.is_simple_acyclic(node_id):
            if self.is_if_then(node_id):
                print 'found if-then.'
                nodes_to_replace = self.get_node_list_for_replacement(node_id, 'if-then')
                self.insert_structure_as_node(nodes_to_replace, 'if-then', node_id)
                struct_found = self.largest_id - 1
            elif self.is_if_then_else(node_id):
                print 'found if-then-else.'
                nodes_to_replace = self.get_node_list_for_replacement(node_id, 'if-then-else')
                self.insert_structure_as_node(nodes_to_replace, 'if-then-else', node_id)
                struct_found = self.largest_id - 1
            elif self.is_block(node_id):
                nodes_to_replace = self.get_node_list_for_replacement(node_id, 'block')
                if len(nodes_to_replace) > 1:
                    print 'found block.'
                    if not self.appendable_to_block(node_id):
                        self.insert_structure_as_node(nodes_to_replace, 'block', node_id)
                        struct_found = self.largest_id - 1
                        found_node = self.nodes[struct_found]
                        found_node.order_nodes_by_edges()
                        reverse = []
                        for j in found_node.edges:
                            reverse.append(Edge(0, j.end, j.start))
                        for j in reverse:                           
                            if j in found_node.edges:
                                print 'correcting to do-loop.'                     
                                found_node.structtype = 'do-loop'
                                found_node.compute_hll_info()
                                break
                    else:
                        print 'appending to existing block ...',
                        struct_found = self.append_to_block(node_id)
                        print 'done.'
                else:
                    print 'found nothing, block is singular.'
        elif back:
            prevs = self.get_previous_nodes(node_id)
            if node_id in prevs:
                print 'found do-loop.'
                self.insert_structure_as_node([node_id], 'do-loop', node_id)
                struct_found = node_id
            else:
                nexts = self.get_next_nodes(node_id)
                for j in nexts:
                    if node_id in self.get_next_nodes(j) and len(self.get_previous_nodes(j)) == 1:
                        print 'found while-loop.'
                        self.insert_structure_as_node([node_id, j], 'while-loop', node_id)
                        struct_found = self.largest_id - 1
        else:
            print 'found nothing.'
        if struct_found:
            print 'reduction successful, applying recursive analysis ...'
            self.analyze_node(struct_found)
    
    def is_loop(self, node_id):
        prevs = self.get_previous_nodes(node_id)
        if node_id in prevs: return True
        nexts = self.get_next_nodes(node_id)
        for ind in nexts:
            if node_id in self.get_next_nodes(ind) and len(self.get_previous_nodes(ind)) == 1:
                return True
        return False

    def cleanup_edges(self):
        # intended to delete any duplicates that might be in the edge-set
        # due to the reductions that took place. Currently not working to the full
        # extend.
        new_edges = []
        for edge in self.edges:
            found = False
            for new_edge in new_edges:
                if edge == new_edge:
                    found = True
            if not found:
                new_edges.append(edge)
        self.edges = new_edges
   
    def analyze_tree(self):
        # parsing algorithm for the dfs-tree
        for i in self.p:
            self.analyze_node(i)
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
        # deprecated, but still in use.
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
        return '\n=== '+ str(self.id) +' '+ str(self.first_index) +' '+ \
        str(self.last_index) +' ===\n'+ self.get_code_representation()
    
    def print_fancy(self, prefix='', child_prefix=''):
        # used for pseudo-HLL-view
        print prefix + 'id: ' + str(self.id) + ' type: low-level'
        for i in self.get_code_representation().split('\n'):
            print prefix + i

class StructNode:
    # a representaton of a structure inside a graph, placeholder for all nodes inside,
    # e.g. a loop, branch or whatever.
    def __init__(self, id, nodes, edges, structtype, start_id):
        self.id = id
        self.flags = None
        self.reset_flags()
        self.nodes = nodes
        self.edges = edges
        self.start_id = start_id
        self.structtype = structtype
        self.hll_info = {}
        self.compute_hll_info()

    def reset_flags(self):
        # deprecated, but still in use.
        self.flags = {'visited':False, 'reached_multiple':False}

    def order_nodes_by_edges(self):
        # used to make the output look better
        if self.structtype == 'block':
            cur_node_id = None
            ordered_nodes = []
            for i in range(0, len(self.nodes)):
                if i == 0:
                    cur_node_id = self.start_id
                ordered_nodes.append(cur_node_id)
                try:
                    cur_node_id = self.get_next_nodes(cur_node_id)[0]
                except:
                    pass
            new_nodes = []
            for i in ordered_nodes:
                for j in self.nodes:
                    if j.id == i:
                        new_nodes.append(j)
                        self.nodes.remove(j)
                        break
            self.nodes = new_nodes
        
        
            
    
    def get_next_nodes(self, node_id):
        # returns a list of all node-id's
        # that belong to direct successors of a given node
        ret = []
        for edge in self.edges:
            if edge.start == node_id:
                ret.append(edge.end)
        return list(set(ret))
    
    def get_previous_nodes(self, node_id):
        # returns a list of all node-id's that belong to direct
        # predecessos of a given node
        ret = []
        for edge in self.edges:
            if edge.end == node_id:
                ret.append(edge.start)
        return list(set(ret))
    
    def __str__(self):
        # "graphical" representation
        return str(self.id) +' '+ self.structtype + ' ' + self.get_representation()
    
    def get_representation(self):
        # output
        ret = ''
        for i in self.nodes:
            ret += str(i.id) + ' '
        return ret
    
    def hll_info_fancy(self):
        # used for pseudo-HLL-view
        ret = ''
        for i in self.hll_info:
            #print self.hll_info[i]
            if type(self.hll_info[i]) != ListType:
                ret += i + ':' + str(self.hll_info[i]) + ' '
            else:
                s = ','.join(map(lambda x: str(x), self.hll_info[i]))
                ret += i + ':' + s + ' '
        return ret
    
    def print_fancy(self, prefix='', child_prefix='|-- '):
        # pseudo-HLL-view, tree representing code as in C or any other HLL
        print prefix + 'id: ' + str(self.id) + ' type: ' + self.structtype +\
        ' starts at ' + str(self.start_id) + ':'
        prefix = prefix + '    '
        s = self.hll_info_fancy()
        if s != '':
            print prefix + s
        print prefix + child_prefix + 'nodes:'
        for i in self.nodes:
            i.print_fancy(prefix+'|   ', child_prefix)
        print prefix + child_prefix +'edges:'
        for i in self.edges:
            print '    |   ' + prefix + i.__str__()
    
    def compute_hll_info(self):
        # HLL analysis of the generated structures
        # used to determine which entrypoint a structure has, as well as
        # which of it's sub-nodes has which purpose. Sounds awful.
        if self.structtype == 'if-then':
            self.hll_info['condition'] = self.edges[0].start
            for i in self.nodes:
                if i.id != self.edges[0].start:
                    self.hll_info['then'] = i.id
        elif self.structtype == 'if-then-else':
            self.hll_info['condition'] = self.edges[0].start
            for i in self.edges:
                if not i.active:
                    self.hll_info['then'] = i.end
                else:
                    self.hll_info['else'] = i.end
        elif self.structtype == 'while-loop':
            self.hll_info['condition'] = self.start_id
            self.hll_info['body'] = self.get_other_node(self.start_id)
        elif self.structtype == 'do-loop':
            self.hll_info['condition'] = self.get_other_node(self.start_id)
            self.hll_info['body'] = self.start_id
    
    def get_other_node(self, other_id):
        # helper method.
        if len(self.nodes) == 2:
            for i in self.nodes:
                if i.id != other_id: return i.id
            

class Edge:
    # a graph-edge
    def __init__(self, id, start, end, active=True):
        self.id = id
        self.start = start
        self.end = end
        self.active = active
    
    def __str__(self):
        # not so pretty printing
        return str(self.start) +' '+ str(self.end)
    
    def __eq__(self, other):
        # are two edges identical?
        return self.start == other.start and self.end == other.end

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='The controlflow analysis module, capable to work stand-alone')
    parser.add_argument('-s', '--source', help='Optional file to be analyzed, if not present, the hard-coded-default is used (for debugging purposes)')
    parser.add_argument('-o', '--output', help='Optional file to redirect input to')
    source = '../../tests/conditions8_analysis/main.asm'
    f = parser.parse_args()
    if f.source: source = f.source
    if f.output: sys.stdout = open(f.output, 'wb')
    l = map(lambda x: x.strip('\n'), open(source, 'rb').readlines())
    g = Graph(l)
    g.print_graph()
    g.reduce()
    g.print_graph()
    
