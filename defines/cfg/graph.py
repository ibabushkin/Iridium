#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
File: graph.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: None
Description: A module intended for controlflow-analysis,
generating a graph from a assembly listing and analyzing it.
"""

import argparse
import sys

from Iridium.defines.util.labels import Label
from Iridium.defines.util.tree import Tree
from types import ListType
from Iridium.defines.util.parser import Parser


class Graph(Parser):
    """
    A Graph. Generates itself from an Assembly listing, is capable
    of analyzing itself and recovering HLL-structures from the code.
    Works using an extended version of the algorithm described by
    M. Sharir in his paper (see documentation).
    """
    def __init__(self, text):
        """
        The constructor of a Graph. Generates nodes and edges and pre-
        pares everything for analysis.
        """
        Parser.__init__(self, text)
        self.delimiter_lines = []
        # used to split the code into nodes
        self.nodes = {}
        # the id is the key, thus nodes can be removed without any problems
        self.edges = []
        # still a list
        self.start_node_index = 0
        # entrypoint of function
        self.largest_id = None
        # used to find out which id to use next when insertng
        # StructNode instances into graph
        self.end_node_index = None
        # last node, not used
        self.generate_graph()
        self.tree = None
        self.ways = []
        self.ways2 = []
        self.non_knot_nodes = []

    # output (before and after analysis)

    def print_graph(self):
        """
        Prints all nodes that are present in self.nodes.
        This does _not_ imply all nodes in the graph itself,
        since nodes can conain other nodes, if they are of type
        StructNode. Afterwards, all edges of the graph are printed.
        """
        for i in self.nodes:
            print self.nodes[i]
        for i in self.edges:
            print i

    def print_fancy(self):
        """
        Prints the first (and after an analysis, only) node of the
        graph, recursively. Thus, all recovered structures can be
        seen in the output.
        """
        print '=================='
        self.nodes[self.start_node_index].print_fancy()

    # end of section output

    # main structure (graph-level analysis and graph-generation)

    def generate_graph(self):
        """
        Generates a graph from a list of Instruction- and
        Label-instances, splits the graph at labels, jumps and compares
        (the last to ensure that "normal" code is separated from conditions)
        It's probably not the best idea to call this from a third-party
        context, unless you want to reset the graph. While this behaviour is
        not intended, it is not recommended to use, since it's easier (and
        safer) to create a new Graph-instance.
        """
        current_node_id = 0
        current_edge_id = 0
        for index, instruction in enumerate(self.code):
            if isinstance(instruction, Label):
                self.delimiter_lines.append(index)
            elif instruction.is_jump():
                self.delimiter_lines.append(index + 1)
            elif (instruction.mnemonic in ['cmp', 'test']
                  and index - 1 not in self.delimiter_lines):
                self.delimiter_lines.append(index)
        self.delimiter_lines = [0] + \
            sorted(list(set(self.delimiter_lines))) + \
            [len(self.code)]
        for index, content in enumerate(self.delimiter_lines):
            if content != len(self.code):
                code_lines = self.code[content:self.delimiter_lines[index + 1]]
                if len(code_lines) > 0:
                    self.nodes[current_node_id] = Node(
                        current_node_id,
                        code_lines,
                        content,
                        self.delimiter_lines[index + 1])
                    current_node_id += 1
        for node_index in self.nodes:
            print self.nodes[node_index]
            node = self.nodes[node_index]
            if node.code[-1].is_jump():
                destination = node.code[-1].get_destination()
                destination = self.find_node_by_label(destination)
                if destination:
                    self.edges.append(
                        Edge(current_edge_id, node.id, destination.id))
                    current_edge_id += 1
                else:
                    print 'encountered jump to non-local\
                    destination, probably a call.'
            if node.code[-1].is_conditional_jump() \
                    or not node.code[-1].is_jump():
                if node.id != len(self.nodes) - 1 \
                        and node.code[-1].mnemonic not in ['ret', 'retn']:
                    destination = self.nodes[node.id + 1]
                    self.edges.append(
                        Edge(current_edge_id, node.id, destination.id, False))
                    # "passive edges" are handled here, those are edges that
                    # represent code-control-motion caused by not taken jumps
                    # or simply the next instruction line. Used to determine
                    # the then/else relationships in if-then-else structures.
                    current_edge_id += 1
        self.start_node_index = 0
        self.end_node_index = len(self.nodes) - 1
        self.largest_id = current_node_id
        self.remove_dead_code()

    def generate_dfs_tree(self):
        """
        Generates a dfs-tree for the graph.
        This function uses self.visit_depth_first and
        sets the tree up. In most cases, you won't need
        to call it, since self.tree does not change during
        runtime.
        """
        self.tree = Tree(self.nodes[self.start_node_index])
        for node_index in self.nodes:
            self.nodes[node_index].reset_flags()
        self.visit_depth_first(self.start_node_index)

    def visit_depth_first(self, node_id):
        """
        Performs depth-first-traversal of the graph
        Keyword arguments:
            node_id -- id of node from which the traversal
                       should start working recursively
        Results:
            self.tree contains a Tree-instance / the DFS-Tree
            of the graph.
        """
        self.nodes[node_id].flags['traversed'] = True
        cur_node = self.tree.current_node
        for i in self.get_next_nodes(node_id):
            if 'traversed' not in self.nodes[i].flags:
                self.tree.append(self.nodes[i])
                self.visit_depth_first(i)
            self.tree.current_node = cur_node

    def analyze_tree(self):
        """
        Works through the nodes in the "right" order.
        Uses the postorder-traversion of self.tree, which
        is stored in self.p.
        """
        for i in self.postorder:
            self.analyze_node(i)

    def reduce(self):
        """
        Reduces the graph, prepares the enviroment
        """
        self.generate_dfs_tree()
        self.postorder = self.tree.postorder()
        print '=================='
        print 'Reducing graph ...'
        print 'postorder of dfs-tree:', self.postorder
        self.analyze_tree()
        if isinstance(self.nodes[self.start_node_index], StructNode):
            self.nodes[self.start_node_index].compute_condition()
        self.print_fancy()

    # end of section main structure

    # node analysis

    def analyze_paths(self, loop):
        """
        Based on the calculated paths, finds conditions and replaces them
        by a single StructNode-instances of type condition.
        Also, ugliest code ever. Seriously.
        Keyword arguments:
            loop -- boolean value indicating whether the
                    condition in question is a while-loop's condition
        Results:
            If a condition is present, it is reduced.
        """
        visited_nodes = []
        jump_source = self.is_target_of_back_edge(self.ways2[0][0])
        for i in self.ways2:
            for j in i:
                if j not in visited_nodes:
                    visited_nodes.append(j)
        omnipresent_nodes = visited_nodes[:]
        if loop:
            # self.ways2 = filter(lambda x: jump_source not in x, self.ways2)
            self.ways2 = [way for way in self.ways2 if jump_source not in way]
        for i in visited_nodes:
            for j in self.ways2:
                if i not in j:
                    if i in omnipresent_nodes:
                        omnipresent_nodes.remove(i)
        first_knot = None  # first node after structure
        if loop:
            self.ways = []
            self._find_all_ways(self.ways2[0][0], jump_source, [])
            first_knot = i
        elif self.ways2:
            for i in self.ways2[0][1:]:
                if i in omnipresent_nodes and i not in self.non_knot_nodes:
                    first_knot = i
                    break
        if first_knot:
            print 'found knot-node:', first_knot
        # self.ways2 = map(lambda x: x[:x.index(first_knot)], self.ways2)
        self.ways2 = [way[:way.index(first_knot)] for way in self.ways2]
        structure_nodes = []
        red = True  # reduce or not?
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
        if red and len(conditions) > 1:
            print 'reducing condition:', conditions
            self.insert_structure_as_node(
                conditions, 'condition', self.ways2[0][0])

    def analyze_node(self, node_id):
        """
        Analyzes a node and reduces found conditions (by calling analyze_paths)
        and controlflow-structures if possible.
        Keyword arguments:
            node_id -- int, valid key in self.nodes,
                        represents the node to be analyzed.
        Results:
            if a structure / and / or condition is found, it is reduced.
            If so, analyze_nodes is applied recursively on the found StructNode.
        """
        print '=================='
        print 'analyzing node', node_id, '...'
        struct_found = None
        loop = False
        back = self.is_target_of_back_edge(node_id)
        print 'target of backedge  ...', back
        branching = len(self.get_next_nodes(node_id)) == 2
        print 'branching ...', branching
        # using condition analysis...
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
                self.non_knot_nodes = []
                self.calculate_paths(start=node_id, depth=5 * ind)
                try:
                    self.analyze_paths(loop)
                    node_id = self.largest_id - 1
                    break
                except ValueError:
                    pass
        # normal reduction begins here...
        if self.is_if_then(node_id):
            nodes_to_replace = self.get_node_list_for_replacement(
                node_id, 'if-then')
            print 'if-then:', nodes_to_replace
            self.insert_structure_as_node(nodes_to_replace, 'if-then', node_id)
            struct_found = self.largest_id - 1
        elif self.is_if_then_else(node_id):
            nodes_to_replace = self.get_node_list_for_replacement(
                node_id, 'if-then-else')
            print 'if-then-else:', nodes_to_replace
            self.insert_structure_as_node(
                nodes_to_replace, 'if-then-else', node_id)
            struct_found = self.largest_id - 1
        elif self.is_block(node_id):
            nodes_to_replace = self.get_node_list_for_replacement(
                node_id, 'block')
            print 'block:', nodes_to_replace
            if len(nodes_to_replace) > 1:
                if not self.appendable_to_block(node_id):
                    self.insert_structure_as_node(
                        nodes_to_replace, 'block', node_id)
                    struct_found = self.largest_id - 1
                else:
                    print 'appending to existing block ...',
                    struct_found = self.append_to_block(node_id)
                    # self.replace_edges(struct_found, [node_id])
                    # self.remove_nodes([node_id])
                    print 'done:', struct_found
                found_node = self.nodes[struct_found]
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
                print 'found nothing, block is singular.'
        elif self.is_do_loop(node_id):
            print 'do-loop:', node_id
            self.insert_structure_as_node([node_id], 'do-loop', node_id)
            struct_found = self.largest_id - 1
        elif self.is_while_loop(node_id):
            loop_body = self.is_while_loop(node_id)
            print 'while-loop:', [node_id, loop_body]
            self.insert_structure_as_node([node_id, loop_body], 'while-loop', node_id)
            struct_found = self.largest_id - 1
        # apply recursion if needed
        if struct_found:
            print 'reduction successful.\ncurrent nodeset: |',
            for node in self.nodes:
                print node, '|',
            if len(self.edges) != 0:
                print '\ncurrent edgeset: |',
                for edge in self.edges:
                    print edge, '|',
            print '\napplying recursive analysis ...'
            self.nodes[struct_found].order_nodes_by_edges()
            self.analyze_node(struct_found)

    # end of section node analysis

    # helper methods

    def remove_dead_code(self):
        """
        Removes all nodes from the graph that are never reached
        by control flow.
        """
        nodes = self.nodes.copy()
        for node_id in self.nodes:
            found = node_id == self.start_node_index
            for edge in self.edges:
                if node_id in (edge.end, edge.start):
                    found = True
            if not found:
                nodes.pop(node_id, None)
        self.nodes = nodes

    def clean_edges(self):
        """
        Removes all edges, whose start or end isn't a valid node's id.
        This method is deprecated, it is strongly suggested that you
        don't use it.
        """
        for edge in self.edges:
            if edge.end not in self.nodes or edge.start not in self.nodes:
                self.edges.remove(edge)

    def find_node_by_label(self, label_name):
        """
        Returns the node beginning with a label
        having the given name.
        Keyword arguments:
            label_name -- label's name
        Results:
            Returns a Node-instace
        """
        for node_index in self.nodes:
            node = self.nodes[node_index]
            if isinstance(node.code[0], Label):
                if node.code[0].name == label_name:
                    return node
        return None

    def remove_nodes(self, id_list):
        """
        Removes all nodes whose id is in id_list from the graph.
        Keyword arguments:
            id_list -- a list of int's
        """
        self.nodes = {i: self.nodes[i] for i in self.nodes if i not in id_list}

    def get_edges_for_subgraph(self, id_list):
        """
        Returns all edges starting and ending at the given nodes.
        Removes these edges from the graph afterwards.
        Keyword arguments:
            id_list --  a list of Node-id's
        Results:
            Returns a list of Edge-instances.
        """
        edges = []
        for i in self.edges:
            if i.start in id_list and i.end in id_list:
                edges.append(i)
        # self.edges = filter(lambda x: x not in edges, self.edges)
        self.edges = [edge for edge in self.edges if edge not in edges]
        return edges

    def replace_edges(self, new_id, id_list):
        """
        Replaces beginning or end of all edges that are adjacent to nodes
        identified by an element of id_list, by the value of new_id.
        Keyword arguments:
            new_id -- int, the new id to be inserted into the edge
            id_list -- all nodes whose edges are to be processed,
                       given as a list of id's
        """
        replaced_edges = []
        for edge in self.edges:
            if edge.end in id_list:
                edge.end = new_id
            elif edge.start in id_list:
                replaced_edges.append(
                    Edge(None,
                         edge.start,
                         edge.end,
                         edge.active)
                )
                edge.start = new_id
        return replaced_edges

    def get_nodes(self, id_list):
        """
        Return all nodes that are identified by an element of id_list
        @param id_list: list of integers
        @ret: list of Node-instances
        """
        return [self.nodes[i] for i in self.nodes if i in id_list]

    def insert_structure_as_node(self, id_list, structtype, start_id=0):
        """
        used to replace a group of nodes that are identified as a structure
        by a special object in the graph that contains them all.
        @param id_list: list of Node-instances - change to id's
        @param structtype: str determining the type of structure inserted
        possible values are 'condition', 'do-loop', 'while-loop', 'block',
        'if-then', 'if-then-else'
        """
        edges = self.get_edges_for_subgraph(id_list)
        new_id = self.largest_id
        self.largest_id += 1
        self.nodes[new_id] = StructNode(
            new_id, self.get_nodes(id_list), edges, structtype, start_id)
        replaced_edges = self.replace_edges(new_id, id_list)
        if structtype == 'condition':
            self.nodes[new_id].replaced_edges = replaced_edges
            print 'replaced edges:',
            for i in replaced_edges:
                print i,
            print
        if self.start_node_index in id_list:
            self.start_node_index = new_id
        self.remove_nodes(id_list)
        self.edges = list(set(self.edges))

    def get_all_visited_nodes(self):
        """
        returns all nodes already traversed and somehow saved in self.ways
        @ret: list of Node-id's
        """
        ret = []
        for i in self.ways:
            for j in i:
                if j not in ret:
                    ret.append(j)
        return ret

    def _find_all_ways(self, start=0, end=0, ways=[]):
        """
        finds all possible paths from a given entry-node s to a node e
        works recursively and accepts w as a path for the current progress
        """
        ways.append(start)
        if start == end:
            self.ways.append(ways)
        else:
            for i in self.get_next_nodes(start):
                if i not in ways:
                    self._find_all_ways(i, end, ways[:])

    def _check_dominance(self, node_id):
        """
        is a dominant to all currently saved paths? (see next method)
        in other words, is a present in every element of self.ways?
        """
        # dominance_paths = map(lambda x: a in x, self.ways)
        dominance_paths = [node_id in x for x in self.ways]
        return False not in dominance_paths

    def is_dominator(self, a, b):
        """
        does a dominate b? (do all paths leading from the entrypoint to
        contain a? (per definition, a node dominates itself)
        """
        self.ways = []
        self._find_all_ways(0, b, [])
        return self._check_dominance(a)

    def get_node_list_for_replacement(self, start_id, structtype):
        """
        returns a list of Node-id's that belong to a structure of type
        structtype, beginning at start_id
        """
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

    def find_linear_block(self, node_id):
        """
        find a linear structure in a graph beginning
        at any node, working forward.
        """
        return self.find_linear_block_forward(node_id)

    def find_linear_block_backward(self, node_id, l=[]):
        """ helper method for finding blocks """
        prevs = self.get_previous_nodes(node_id)
        ret = l + [node_id]
        if len(prevs) == 1 and len(self.get_next_nodes(prevs[0])) == 1:
            ret += self.find_linear_block_backward(prevs[0], ret)
        return ret

    def find_linear_block_forward(self, node_id, l=[]):
        """ helper method for finding blocks """
        posts = self.get_next_nodes(node_id)
        ret = l + [node_id]
        if len(posts) == 1 and len(self.get_previous_nodes(posts[0])) == 1:
            ret += self.find_linear_block_forward(posts[0], ret)
        if len(ret) > 1:
            return ret
        return []

    def appendable_to_block(self, node_id):
        """
        is a given node already recognized as a possible block
        appendable to the following node (which must be a block)
        """
        n = self.get_next_nodes(node_id)[0]
        appendable = (isinstance(self.nodes[n], StructNode)
                      and self.nodes[n].structtype == 'block')
        print 'appendable to', n, '...', appendable
        return appendable

    def append_to_block(self, node_id):
        """ append given node to following block node """
        n = self.nodes[self.get_next_nodes(node_id)[0]]
        n.nodes.append(self.nodes[node_id])
        for edge in self.edges:
            if edge.start == node_id and edge.end == n.id:
                n.edges.append(Edge(edge.id, node_id, n.start_id, edge.active))
                n.edges[-1].end = n.start_id
                n.start_id = node_id
                break
        for edge in self.edges:
            if edge.start == node_id and edge.end == n.id:
                self.edges.remove(edge)
        if self.start_node_index == node_id:
            self.start_node_index = n.id
        for edge in self.edges:
            if edge.end == node_id:
                edge.end = n.id
        n.order_nodes_by_edges()
        self.remove_nodes([node_id])
        self.edges = list(set(self.edges))
        return n.id

    def calculate_paths(self, start, depth, path=[]):
        """
        calculate all possible controlflow-paths from a
        given node with given depth. saves results in self.ways2.
        works recursively, thus the path argument.
        """
        current_path = path[:] + [start]
        next_nodes = self.get_next_nodes(start)
        if depth == 0 or len(next_nodes) == 0:
            self.ways2.append(current_path)
        else:
            for i in next_nodes:
                if not self.is_dominator(i, start):
                    self.calculate_paths(i, depth - 1, current_path)
                elif len(self.get_next_nodes(start)) == 2:
                    self.non_knot_nodes.append(start)
                else:
                    self.ways2.append(current_path)

    def get_next_nodes(self, node_id):
        """
        returns a list of all node-id's
        that can be reached directly from a given node
        """
        ret = []
        for edge in self.edges:
            if edge.start == node_id:
                ret.append(edge.end)
        return list(set(ret))

    def get_previous_nodes(self, node_id):
        """
        returns a list of all node-id's that are direct
        predecessos of a given node
        """
        ret = []
        for edge in self.edges:
            if edge.end == node_id:
                ret.append(edge.start)
        return list(set(ret))

    # end of section helper methods

    # structure checks

    def is_simple_acyclic(self, node_id):
        """
        determines, wether given node is the beginning
        of a simple acyclic structure (block, if-else of if-then)
        @ret: boolean value determining result
        """
        return self.is_block(node_id) or self.is_if_then(
            node_id) or self.is_if_then_else(node_id)

    def is_block(self, node_id):
        """
        is a given node (part of) a block, or at least
        a candidate to be a block?
        """
        return len(self.get_next_nodes(node_id)) < 2

    def is_if_then(self, node_id):
        """ is a given node beginning of an if-then-block? """
        n = self.get_next_nodes(node_id)
        if len(n) == 2:
            n1 = n[0]
            n2 = n[1]
            n1_next = self.get_next_nodes(n1)
            n2_next = self.get_next_nodes(n2)
            if n2 in n1_next and len(self.get_previous_nodes(n1)) == 1 \
                    and len(self.get_previous_nodes(n2)) >= 2:
                return len(n1_next) == 1
            elif n1 in n2_next and len(self.get_previous_nodes(n2)) == 1 \
                    and len(self.get_previous_nodes(n1)) >= 2:
                return len(n2_next) == 1
        return False

    def is_if_then_else(self, node_id):
        """ is a given node beginning of an if-else-block? """
        n = self.get_next_nodes(node_id)
        if len(n) == 2:
            n1 = n[0]
            n2 = n[1]
            n1_next = self.get_next_nodes(n1)
            n2_next = self.get_next_nodes(n2)
            if len(
                    self.get_previous_nodes(n1)) == 1 and len(
                    self.get_previous_nodes(n2)) == 1:
                return len(n1_next) == 1 and n1_next == n2_next
        return False

    def is_loop(self, node_id):
        """ Are we at the beginning of a loop? """
        return self.is_do_loop(node_id) or self.is_while_loop(node_id)

    def is_do_loop(self, node_id):
        """ Are we at the beginning of a do-loop? """
        prevs = self.get_previous_nodes(node_id)
        if node_id in prevs:
            return True

    def is_while_loop(self, node_id):
        """ Are we at the beginning of a while-loop? """
        nexts = self.get_next_nodes(node_id)
        for ind in nexts:
            if node_id in self.get_next_nodes(ind) and len(
                    self.get_next_nodes(ind)) == 1 and len(
                    self.get_previous_nodes(ind)) == 1:
                return ind
        return False

    def is_target_of_back_edge(self, node_id):
        """ is there a back-edge targeting given node? """
        for i in self.get_previous_nodes(node_id):
            ret = self.is_dominator(node_id, i)
            if ret:
                return i
        return False

        # end of section structure checks


class Node:
    """
    a representation of a one-entry, one-exit sequence of code
    """

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
        self.flags = {'visited': False, 'reached_multiple': False}

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
            ret += instruction.__str__() + '\n'
        return ret

    def __str__(self):
        # "pretty" printing
        return '\n=== ' + str(self.id) + ' ' + str(self.first_index) + ' ' + \
               str(self.last_index) + ' ===\n' + self.get_code_representation()

    def print_fancy(self, prefix='', child_prefix=''):
        # used for pseudo-HLL-view, draws nodes and boxes around them
        print prefix + 'id: ' + str(self.id) + ' type: low-level'
        max_len = 0
        for i in self.get_code_representation().split('\n'):
            if len(i) > max_len:
                max_len = len(i)
        print prefix + '+' + '-' * max_len + '+'
        for i in self.get_code_representation().split('\n')[:-1]:
            print prefix + '|' + i + ' ' * (max_len - len(i)) + '|'
        print prefix + '+' + '-' * max_len + '+\n' + prefix


class StructNode:
    # a representaton of a structure inside a graph,
    # placeholder for all nodes inside, e.g. a loop, branch or whatever.

    def __init__(self, id, nodes, edges, structtype, start_id):
        self.id = id
        self.description = ''
        self.flags = None
        self.reset_flags()
        self.nodes = nodes
        self.edges = edges
        self.start_id = start_id
        self.structtype = structtype
        self.hll_info = {}
        self.compute_hll_info()
        self.cleanup_edges()

    def cleanup_edges(self):
        # delete any duplicates that might be in the edge-set
        # due to the reductions that took place.
        new_edges = []
        for edge in self.edges:
            found = False
            for new_edge in new_edges:
                if edge.equals(new_edge):
                    found = True
            if not found:
                new_edges.append(edge)
        self.edges = new_edges

    def reset_flags(self):
        # deprecated, but still in use.
        self.flags = {'visited': False, 'reached_multiple': False}

    def order_nodes_by_edges(self):
        # used to make the output look better
        cur_node_id = None
        ordered_nodes = []
        if self.structtype in ['do-loop', 'block']:
            for i in range(0, len(self.nodes)):
                if i == 0:
                    cur_node_id = self.start_id
                ordered_nodes.append(cur_node_id)
                try:
                    cur_node_id = self.get_next_nodes(cur_node_id)[0]
                except:
                    pass
        elif self.structtype == 'while-loop':
            for i in self.nodes:
                if i.id == self.hll_info['condition']:
                    ordered_nodes.append(i.id)
                    cur_node_id = i.id
            ordered_nodes.append(self.get_other_node(cur_node_id))
        if ordered_nodes:
            new_nodes = []
            for i in ordered_nodes:
                for j in self.nodes:
                    if j.id == i:
                        new_nodes.append(j)
                        self.nodes.remove(j)
                        break
            self.nodes = new_nodes

    def get_next_nodes(self, node_id, use_outer_edges=False):
        # returns a list of all node-id's
        # that belong to direct successors of a given node
        ret = []
        for edge in self.edges:
            if edge.start == node_id:
                ret.append(edge.end)
        if use_outer_edges:
            for edge in self.replaced_edges:
                if edge.start == node_id:
                    ret.append(edge.end)
        return list(set(ret))

    def get_previous_nodes(self, node_id, use_outer_edges=False):
        # returns a list of all node-id's that belong to direct
        # predecessos of a given node
        ret = []
        for edge in self.edges:
            if edge.end == node_id:
                ret.append(edge.start)
        if use_outer_edges:
            for edge in self.replaced_edges:
                if edge.end == node_id:
                    ret.append(edge.end)
        return list(set(ret))

    def __str__(self):
        # "graphical" representation
        return str(self.id) +\
            ' ' + self.structtype +\
            ' ' + self.get_representation()

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
            if not isinstance(self.hll_info[i], ListType):
                ret += i + ':' + str(self.hll_info[i]) + ' '
            else:
                s = ','.join(map(lambda x: str(x), self.hll_info[i]))
                ret += i + ':' + s + ' '
        return ret

    def get_condition_string(self):
        if self.structtype == 'condition':
            return self.description
        else:
            return ''

    def print_fancy(self, prefix='', child_prefix='|-- '):
        # pseudo-HLL-view, tree representing code as in C or any other HLL
        print prefix + 'id: ' +\
            str(self.id) + ' type: ' +\
            self.structtype + ' starts at ' +\
            str(self.start_id) + self.get_condition_string() + ':'
        prefix = prefix + '    '
        s = self.hll_info_fancy()
        if s != '':
            print prefix + s
        print prefix + child_prefix + 'nodes:'
        for i in self.nodes:
            i.print_fancy(prefix + '|   ', child_prefix)
        print prefix + child_prefix + 'edges:'
        for i in self.edges:
            print '    |   ' + prefix + i.__str__()
        if self.structtype == 'condition':
            print prefix + '|   '
            print prefix + child_prefix + 'outer edges:'
            for i in self.replaced_edges:
                print '    |   ' + prefix + i.__str__()
        print prefix

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
            if not self.hll_info['condition']:
                self.hll_info['condition'] = self.get_condition_from_block()
                # if len(self.nodes) == 2:
                #    self.hll_info['condition'] = self.get_other_node(self.start_id)
                #    self.hll_info['body'] = self.start_id
                # else:
                #    self.order_nodes_by_edges()
                #    self.hll_info['condition'] = self.nodes[-1].id

    def get_condition_from_block(self):
        return self.nodes[0].nodes[-1].id

    def get_other_node(self, other_id):
        # helper method.
        if len(self.nodes) == 2:
            for i in self.nodes:
                if i.id != other_id:
                    return i.id

    def get_condition_node(self):
        if 'condition' in self.hll_info:
            for i in self.nodes:
                if self.hll_info['condition'] == i.id:
                    return i
            if self.nodes[0].structtype == 'block':
                for i in self.nodes[0].nodes:
                    if self.hll_info['condition'] == i.id:
                        return i

    def get_node_by_id(self, id):
        for node in self.nodes:
            if node.id == id:
                return node

    def compute_condition(self, TRUE=[], FALSE=[]):
        if self.structtype in ['if-then', 'if-then-else']:
            TRUE.append(self.hll_info['then'])
        elif self.structtype in ['while-loop', 'do-loop']:
            TRUE.append(self.hll_info['body'])
        if self.structtype == 'if-then-else':
            FALSE = [self.hll_info['else']]
        if self.structtype != 'condition':
            condition_node = self.get_condition_node()
            print 'self', self
            print 'condition_node', condition_node
            if condition_node and isinstance(condition_node, StructNode):
                condition_node.compute_condition(TRUE, FALSE)
        else:
            print 'TRUE, FALSE', TRUE, FALSE
            STRUCT_TRUE = []
            STRUCT_FALSE = []
            for node in self.nodes[::-1]:
                print 'node', node
                nz = self.get_next_nodes(node.id, True)
                print 'nz', nz
                print self.get_next_nodes(nz[1]), self.get_next_nodes(nz[0])
                if nz[0] in self.get_next_nodes(nz[1], True):
                    if nz[0] in TRUE + STRUCT_TRUE:
                        TRUE.append(nz[1])
                        TRUE.append(node.id)
                        STRUCT_TRUE.append(node.id)
                        if nz[0] in STRUCT_TRUE:
                            self.description += ' || '
                        elif nz[0] in STRUCT_FALSE:
                            self.description += ' && '
                        self.description = '(%i || %i)' % (node.id, nz[1]) +\
                            self.description
                    elif nz[0] in FALSE + STRUCT_FALSE:
                        FALSE.append(nz[1])
                        FALSE.append(node.id)
                        STRUCT_FALSE.append(node.id)
                        if nz[0] in STRUCT_TRUE:
                            self.description += ' || '
                        elif nz[0] in STRUCT_FALSE:
                            self.description += ' && '
                        self.description = '(%i && %i)' % (node.id, nz[1]) +\
                            self.description
                elif nz[1] in self.get_next_nodes(nz[0], True):
                    if nz[1] in TRUE + STRUCT_TRUE:
                        TRUE.append(nz[0])
                        TRUE.append(node.id)
                        STRUCT_TRUE.append(node.id)
                        if nz[1] in STRUCT_TRUE:
                            self.description += ' || '
                        elif nz[1] in STRUCT_FALSE:
                            self.description += ' && '
                        self.description = '(%i || %i)' % (node.id, nz[0]) +\
                            self.description
                    elif nz[1] in FALSE + STRUCT_FALSE:
                        FALSE.append(nz[0])
                        FALSE.append(node.id)
                        STRUCT_FALSE.append(node.id)
                        if nz[1] in STRUCT_TRUE:
                            self.description += ' || '
                        elif nz[1] in STRUCT_FALSE:
                            self.description += ' && '
                        self.description = '(%i && %i)' % (node.id, nz[0]) +\
                            self.description
            print 'id, description:', self.id, self.description
        for index, node in enumerate(self.nodes):
            if isinstance(node, StructNode) and node.structtype != 'block':
                try:
                    FALSE = [self.nodes[index+1].id]
                    TRUE = []
                    node.compute_condition(TRUE, FALSE)
                except IndexError:
                    pass


class Edge:
    # a graph-edge

    def __init__(self, id, start, end, active=True):
        self.id = id
        self.start = start
        self.end = end
        self.active = active

    def __str__(self):
        # not so pretty printing
        return str(self.start) + '-' + str(self.end)

    def equals(self, other):
        # are two edges identical?
        return self.__eq__(other)

    def __eq__(self, other):
        # are two edges identical?
        return self.start == other.start and self.end == other.end

    def __hash__(self):
        return hash(self.__str__())


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='The controlflow analysis module,\
         capable to work stand-alone')
    parser.add_argument(
        '-s',
        '--source',
        help='Optional file to be analyzed, if not present,\
        the hard-coded-default is used (for debugging purposes)')
    parser.add_argument(
        '-o', '--output', help='Optional file to redirect input to')
    source = '../../tests/conditions14_analysis/main.asm'
    f = parser.parse_args()
    if f.source:
        source = f.source
    if f.output:
        sys.stdout = open(f.output, 'wb')
    l = map(lambda x: x.strip('\n'), open(source, 'rb').readlines())
    g = Graph(l)
    g.reduce()