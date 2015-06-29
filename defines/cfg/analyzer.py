#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
File: analyzer.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: ibabushkin
Description: Analyzing the controlflow of a Graph.
"""

import argparse
import sys

from Iridium.defines.util.tree import Tree
from Iridium.defines.cfg.graph import Graph, StructNode, Edge


class GraphAnalyzer(object):
    """
    A Class intended to analyze a Graph-Instance during reduction.
    """
    def __init__(self, graph):
        """
        The constructor of a GraphAnalyzer. Analyzes the given graph-Instance
        and reduces it.
        """
        self.graph = graph
        self.tree = None
        self.postorder = []
        self.ways = []
        self.ways2 = []
        self.non_knot_nodes = []

    def generate_dfs_tree(self):
        """
        Generates a dfs-tree for the graph.
        This function uses self.visit_depth_first and
        sets the tree up. In most cases, you won't need
        to call it, since self.tree does not change during
        runtime.
        """
        self.tree = Tree(self.graph.nodes[self.graph.start_node_index])
        for node_index in self.graph.nodes:
            self.graph.nodes[node_index].reset_flags()
        self.visit_depth_first(self.graph.start_node_index)

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
        self.graph.nodes[node_id].flags['traversed'] = True
        cur_node = self.tree.current_node
        for next_node_id in self.get_next_nodes(node_id):
            if 'traversed' not in self.graph.nodes[next_node_id].flags:
                self.tree.append(self.graph.nodes[next_node_id])
                self.visit_depth_first(next_node_id)
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
        self.graph.print_graph()
        self.generate_dfs_tree()
        self.postorder = self.tree.postorder()
        print '=================='
        print 'Analyzer is reducing graph ...'
        print 'Postorder of dfs-tree:', self.postorder
        self.analyze_tree()
        self.graph.print_fancy()

    def reduce_condition(self, loop):
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
            self.ways2 = [way for way in self.ways2 if jump_source not in way]
        for i in visited_nodes:
            for j in self.ways2:
                if i not in j:
                    if i in omnipresent_nodes:
                        omnipresent_nodes.remove(i)
        first_knot = None  # first node after structure
        if self.ways2[0][0] in omnipresent_nodes:
            omnipresent_nodes.remove(self.ways2[0][0])
        if loop:
            for i in omnipresent_nodes:
                if jump_source not in self.get_next_nodes(i):
                    first_knot = i
                    break
        elif self.ways2:
            for i in self.ways2[0][1:]:
                if i in omnipresent_nodes and i not in self.non_knot_nodes:
                    first_knot = i
                    break
        if first_knot:
            print 'found knot-node:', first_knot
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
                self.graph.nodes[i].comment = 'part of complex condition'
                conditions.append(i)
            else:
                self.graph.nodes[i].comment = 'code'
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
            self.graph.nodes[node_id].comment = 'simple condition'
        elif branching:
            print 'couldn\'t find simple structure.'
            for ind in range(0, 4):
                self.ways2 = []
                self.non_knot_nodes = []
                self.calculate_paths(start=node_id, depth=5 + ind)
                try:
                    if self.ways2:
                        self.reduce_condition(loop)
                        node_id = self.graph.largest_id - 1
                        break
                except ValueError:
                    print 'No reduction of condition possible, retrying...'
        # normal reduction begins here...
        if self.is_if_then(node_id):
            nodes_to_replace = self.get_node_list_for_replacement(
                node_id, 'if-then')
            print 'if-then:', nodes_to_replace
            self.insert_structure_as_node(nodes_to_replace, 'if-then', node_id)
            struct_found = self.graph.largest_id - 1
        elif self.is_if_then_else(node_id):
            nodes_to_replace = self.get_node_list_for_replacement(
                node_id, 'if-then-else')
            print 'if-then-else:', nodes_to_replace
            self.insert_structure_as_node(
                nodes_to_replace, 'if-then-else', node_id)
            struct_found = self.graph.largest_id - 1
        elif self.is_block(node_id):
            nodes_to_replace = self.get_node_list_for_replacement(
                node_id, 'block')
            print 'block:', nodes_to_replace
            if len(nodes_to_replace) > 1:
                if not self.appendable_to_block(node_id):
                    self.insert_structure_as_node(
                        nodes_to_replace, 'block', node_id)
                    struct_found = self.graph.largest_id - 1
                else:
                    print 'appending to existing block ...',
                    struct_found = self.append_to_block(node_id)
                    # self.replace_edges(struct_found, [node_id])
                    # self.remove_nodes([node_id])
                    print 'done:', struct_found
                found_node = self.graph.nodes[struct_found]
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
            struct_found = self.graph.largest_id - 1
        elif self.is_while_loop(node_id):
            loop_body = self.is_while_loop(node_id)
            print 'while-loop:', [node_id, loop_body]
            self.insert_structure_as_node([node_id, loop_body],
                                          'while-loop', node_id)
            struct_found = self.graph.largest_id - 1
        # apply recursion if needed
        if struct_found:
            print 'reduction successful.\ncurrent nodeset: |',
            for node in self.graph.nodes:
                print node, '|',
            if len(self.graph.edges) != 0:
                print '\ncurrent edgeset: |',
                for edge in self.graph.edges:
                    print edge, '|',
            print '\napplying recursive analysis ...'
            self.graph.nodes[struct_found].order_nodes_by_edges()
            self.analyze_node(struct_found)

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
        for i in self.graph.edges:
            if i.start in id_list and i.end in id_list:
                edges.append(i)
        # self.edges = filter(lambda x: x not in edges, self.edges)
        self.graph.edges = [edge for edge in self.graph.edges
                            if edge not in edges]
        return edges

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
        new_id = self.graph.largest_id
        self.graph.largest_id += 1
        self.graph.nodes[new_id] = StructNode(
            new_id, self.graph.get_nodes(id_list), edges, structtype, start_id)
        replaced_edges = self.replace_edges(new_id, id_list)
        if structtype == 'condition':
            self.graph.nodes[new_id].replaced_edges = replaced_edges
            print 'replaced edges:',
            for i in replaced_edges:
                print i,
            print
        if self.graph.start_node_index in id_list:
            self.graph.start_node_index = new_id
        self.graph.remove_nodes(id_list)
        self.graph.edges = list(set(self.graph.edges))

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
        dominance_paths = [node_id in x for x in self.ways]
        return False not in dominance_paths

    def is_dominator(self, node_a, node_b):
        """
        does node a dominate node b? (do all paths leading from the entrypoint
        to contain a? (per definition, a node dominates itself)
        """
        self.ways = []
        self._find_all_ways(0, node_b, [])
        return self._check_dominance(node_a)

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
                next_nodes = self.get_next_nodes(i)
                if len(next_nodes) != 0:
                    if next_nodes[0] in nexts:
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

    def find_linear_block_backward(self, node_id, block_nodes=[]):
        """ helper method for finding blocks """
        prevs = self.get_previous_nodes(node_id)
        ret = block_nodes + [node_id]
        if len(prevs) == 1 and len(self.get_next_nodes(prevs[0])) == 1:
            ret += self.find_linear_block_backward(prevs[0], ret)
        return ret

    def find_linear_block_forward(self, node_id, block_nodes=[]):
        """ helper method for finding blocks """
        posts = self.get_next_nodes(node_id)
        ret = block_nodes + [node_id]
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
        next_nodes = self.get_next_nodes(node_id)[0]
        appendable = (isinstance(self.graph.nodes[next_nodes], StructNode)
                      and self.graph.nodes[next_nodes].structtype == 'block')
        print 'appendable to', next_nodes, '...', appendable
        return appendable

    def append_to_block(self, node_id):
        """ append given node to following block node """
        next_node = self.graph.nodes[self.get_next_nodes(node_id)[0]]
        next_node.nodes.append(self.graph.nodes[node_id])
        for edge in self.graph.edges:
            if edge.start == node_id and edge.end == next_node.id:
                next_node.edges.append(Edge(edge.id,
                                            node_id,
                                            next_node.start_id,
                                            edge.active))
                next_node.edges[-1].end = next_node.start_id
                next_node.start_id = node_id
                break
        for edge in self.graph.edges:
            if edge.start == node_id and edge.end == next_node.id:
                self.graph.edges.remove(edge)
        if self.graph.start_node_index == node_id:
            self.graph.start_node_index = next_node.id
        for edge in self.graph.edges:
            if edge.end == node_id:
                edge.end = next_node.id
        next_node.order_nodes_by_edges()
        self.graph.remove_nodes([node_id])
        self.graph.edges = list(set(self.graph.edges))
        return next_node.id

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
                elif len(next_nodes) == 2:
                    self.non_knot_nodes.append(start)
                else:
                    self.ways2.append(current_path)

    def get_next_nodes(self, node_id):
        """
        returns a list of all node-id's
        that can be reached directly from a given node
        """
        ret = []
        for edge in self.graph.edges:
            if edge.start == node_id:
                ret.append(edge.end)
        return list(set(ret))

    def get_previous_nodes(self, node_id):
        """
        returns a list of all node-id's that are direct
        predecessos of a given node
        """
        ret = []
        for edge in self.graph.edges:
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
        next_nodes = self.get_next_nodes(node_id)
        if len(next_nodes) == 2:
            next_1 = next_nodes[0]
            next_2 = next_nodes[1]
            n1_next = self.get_next_nodes(next_1)
            n2_next = self.get_next_nodes(next_2)
            if next_2 in n1_next and len(self.get_previous_nodes(next_1)) == 1 \
                    and len(self.get_previous_nodes(next_2)) >= 2:
                return len(n1_next) == 1
            elif next_1 in n2_next and len(self.get_previous_nodes(next_2)) == 1 \
                    and len(self.get_previous_nodes(next_1)) >= 2:
                return len(n2_next) == 1
        return False

    def is_if_then_else(self, node_id):
        """ is a given node beginning of an if-else-block? """
        next_nodes = self.get_next_nodes(node_id)
        if len(next_nodes) == 2:
            next_1 = next_nodes[0]
            next_2 = next_nodes[1]
            n1_next = self.get_next_nodes(next_1)
            n2_next = self.get_next_nodes(next_2)
            len_prev_next_1 = len(self.get_previous_nodes(next_1))
            len_prev_next_2 = len(self.get_previous_nodes(next_2))
            if len_prev_next_1 == 1 and len_prev_next_2 == 1:
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
            if node_id in self.get_next_nodes(ind) and \
                    len(self.get_next_nodes(ind)) == 1 and \
                    len(self.get_previous_nodes(ind)) == 1:
                return ind
        return False

    def is_target_of_back_edge(self, node_id):
        """ is there a back-edge targeting given node? """
        for i in self.get_previous_nodes(node_id):
            ret = self.is_dominator(node_id, i)
            if ret:
                return i
        return False

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
        for edge in self.graph.edges:
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


if __name__ == '__main__':
    ARG_PARSER = argparse.ArgumentParser(
        description='The controlflow analysis module,\
         capable to work stand-alone')
    ARG_PARSER.add_argument(
        '-s',
        '--source',
        help='Optional file to be analyzed, if not present,\
        the hard-coded-default is used (for debugging purposes)')
    ARG_PARSER.add_argument(
        '-o', '--output', help='Optional file to redirect input to')
    SOURCE = '../../tests/conditions18_analysis/main.asm'
    ARGS = ARG_PARSER.parse_args()
    if ARGS.source:
        SOURCE = ARGS.source
    if ARGS.output:
        sys.stdout = open(ARGS.output, 'wb')
    LINES = [line.strip('\n') for line in open(SOURCE, 'rb').readlines()]
    GRAPH_ANALYZER = GraphAnalyzer(Graph(LINES))
    GRAPH_ANALYZER.reduce()
