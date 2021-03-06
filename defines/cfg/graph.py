#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
File: graph.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: ibabushkin
Description: A module intended for controlflow-analysis,
generating a graph from a assembly listing and representing it.
"""


from Iridium.defines.util.labels import Label
from Iridium.defines.util.tree import Tree
from types import ListType
from Iridium.defines.util.parser import CodeCrawler


class Graph(CodeCrawler):
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
        CodeCrawler.__init__(self, text)
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
        print '==================RESULTS=================='
        print 'Graph starting at node', self.start_node_index
        for node in self.nodes:
            self.nodes[node].print_fancy()
        for edge in self.edges:
            print edge

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
                # found a label, which is the beginning of a node.
                self.delimiter_lines.append(index)
            elif instruction.is_jump():
                # found a jump, which is the end of a node
                self.delimiter_lines.append(index + 1)
            elif (instruction.mnemonic in ('cmp', 'test')
                  and index - 1 not in self.delimiter_lines):
                # found a comparison, which is used as the beginning of a node
                # to make sure conditions and code are separated.
                self.delimiter_lines.append(index)
        self.delimiter_lines = [0] + \
            sorted(list(set(self.delimiter_lines))) + \
            [len(self.code)]
        for index, content in enumerate(self.delimiter_lines):
            if content != len(self.code):
                # create a node.
                code_lines = self.code[content:self.delimiter_lines[index + 1]]
                if len(code_lines) > 0:
                    self.nodes[current_node_id] = Node(
                        current_node_id,
                        code_lines,
                        content,
                        self.delimiter_lines[index + 1])
                    current_node_id += 1
        for node_index in self.nodes:
            node = self.nodes[node_index]
            print node.code[-1]
            if node.code[-1].is_jump():
                destination = node.code[-1].get_destination()
                destination = self.find_node_by_label(destination)
                if destination:
                    # insert an edge for a jump.
                    self.edges.append(
                        Edge(current_edge_id, node.id, destination.id))
                    current_edge_id += 1
                else:
                    # oops! Should not happen, unless we have
                    # calls by jump or jumps to locations cal-
                    # culated at runtime.
                    print 'encountered jump to non-local\
                    destination, probably a call.'
            if node.code[-1].is_conditional_jump() \
                    or not node.code[-1].is_jump():
                if node.id != len(self.nodes) - 1 \
                        and node.code[-1].mnemonic not in ('ret', 'retn'):
                    destination = self.nodes[node.id + 1]
                    self.edges.append(
                        Edge(current_edge_id, node.id, destination.id, False))
                    # "passive edges" are handled here, those are edges that
                    # represent code-control-motion caused by not taken jumps
                    # or simply the next instruction line. Used to determine
                    # the then/else relationships in if-then-else structures.
                    current_edge_id += 1
        self.start_node_index = 0  # The functions's entrypoint.
        self.end_node_index = len(self.nodes) - 1  # The last node.
        # make inserting StructNodes possible:
        self.largest_id = current_node_id
        self.remove_dead_code()  # Get rid of the junk.

    # end of section main structure

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

    def get_nodes(self, id_list):
        """
        Return all nodes that are identified by an element of id_list
        @param id_list: list of integers
        @ret: list of Node-instances
        """
        return [self.nodes[i] for i in self.nodes if i in id_list]


class Node(object):
    """
    a representation of a one-entry, one-exit sequence of code
    """

    def __init__(self, id_, code, first, last):
        """
        Set the instance attributes.
        """
        self.id = id_
        self.code = code
        self.first_index = first
        self.last_index = last
        self.flags = None
        self.reset_flags()
        self.dominators = []

    def reset_flags(self):
        """
        Deprecated, but still in use.
        """
        self.flags = {'visited': False, 'reached_multiple': False}

    def get_label_if_present(self):
        """
        Returns a label's name at the beginning of
        the code-sequence, if present.
        """
        if isinstance(self.code[0], Label):
            return self.code[0].name
        return ''

    def get_code_representation(self):
        """
        Returns own code as string.
        """
        ret = ''
        for instruction in self.code:
            ret += instruction.__str__() + '\n'
        return ret

    def __str__(self):
        """ Pretty printing """
        return '\n=== ' + str(self.id) + ' ' + str(self.first_index) + ' ' + \
               str(self.last_index) + ' ===\n' + self.get_code_representation()

    def print_fancy(self, prefix=''):
        """
        Used for pseudo-HLL-view, draws nodes and boxes around them.
        """
        print prefix + 'id: ' + str(self.id) + ' type: low-level'
        max_len = 0
        for i in self.get_code_representation().split('\n'):
            if len(i) > max_len:
                max_len = len(i)
        print prefix + '+' + '-' * max_len + '+'
        for i in self.get_code_representation().split('\n')[:-1]:
            print prefix + '|' + i + ' ' * (max_len - len(i)) + '|'
        print prefix + '+' + '-' * max_len + '+\n' + prefix


class StructNode(object):
    """
    A representaton of a structure inside a graph,
    placeholder for all nodes inside, e.g. a loop, branch or whatever.
    """

    def __init__(self, id, nodes, edges, structtype, start_id):
        self.id = id
        self.description = ''
        self.flags = None
        self.reset_flags()
        self.nodes = nodes
        self.edges = edges
        self.replaced_edges = []
        self.start_id = start_id
        self.structtype = structtype
        self.hll_info = {}
        self.struct_nodes = {}
        self.structs = {}
        self.tree = None
        self.current_id = 'a'
        if self.structtype == 'condition':
            self.generate_dfs_tree()
        self.compute_hll_info()
        self.cleanup_edges()

    def generate_dfs_tree(self):
        """
        Generates a dfs-tree for the graph.
        This function uses self.visit_depth_first and
        sets the tree up. In most cases, you won't need
        to call it, since self.tree does not change during
        runtime.
        """
        self.tree = Tree(self.get_node_by_id(self.start_id))
        for node in self.nodes:
            node.reset_flags()
        self.visit_depth_first(self.start_id)

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
        self.get_node_by_id(node_id).flags['traversed'] = True
        cur_node = self.tree.current_node
        for next_node_id in self.get_next_nodes(node_id):
            if 'traversed' not in self.get_node_by_id(next_node_id).flags:
                self.tree.append(self.get_node_by_id(next_node_id))
                self.visit_depth_first(next_node_id)
            self.tree.current_node = cur_node

    def cleanup_edges(self):
        """
        Delete any duplicates that might be in the edge-set
        due to the reductions that took place.
        """
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
        """
        Clear the node's flags. Used for easier traversal.
        """
        self.flags = {'visited': False, 'reached_multiple': False}

    def order_nodes_by_edges(self):
        """
        Order the nodes in a block or loop in a senseful manner.
        Used to make the output look better.
        """
        cur_node_id = None
        ordered_nodes = []
        if self.structtype in ('do-loop', 'block'):
            for i in range(0, len(self.nodes)):
                if i == 0:
                    cur_node_id = self.start_id
                ordered_nodes.append(cur_node_id)
                n_nodes = self.get_next_nodes(cur_node_id)
                if n_nodes:
                    cur_node_id = n_nodes[0]
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
        """
        Returns a list of all node-id's
        that belong to direct successors of a given node.
        Respects structures inside a condition.
        """
        if node_id in self.structs:
            if node_id == self.struct_nodes[self.structs[node_id]][0]:
                return self.get_next_nodes(
                    self.structs[node_id], use_outer_edges)
        ret = []
        if isinstance(node_id, int):
            for edge in self.edges:
                if edge.start == node_id:
                    ret.append(edge.end)
            if use_outer_edges:
                for edge in self.replaced_edges:
                    if edge.start == node_id:
                        ret.append(edge.end)
            new_ret = []
            for n_id in ret:
                if n_id in self.structs:
                    new_ret.append(self.structs[n_id])
                else:
                    new_ret.append(n_id)
            return list(set(new_ret))
        else:
            return self.get_next_nodes(
                self.struct_nodes[node_id][1],
                use_outer_edges)

    def get_previous_nodes(self, node_id, use_outer_edges=False):
        """
        Returns a list of all node-id's that belong to direct
        predecessos of a given node.
        Respects structures inside a condition.
        """
        ret = []
        if isinstance(node_id, int):
            for edge in self.edges:
                if edge.end == node_id:
                    ret.append(edge.start)
            if use_outer_edges:
                for edge in self.replaced_edges:
                    if edge.end == node_id:
                        ret.append(edge.end)
            new_ret = []
            for n_id in ret:
                if n_id in self.structs:
                    new_ret.append(self.structs[n_id])
                else:
                    new_ret.append(n_id)
            return list(set(new_ret))
        else:
            return self.get_previous_nodes(
                self.struct_nodes[node_id][0],
                use_outer_edges)

    def __str__(self):
        """
        "Graphical" representation
        """
        return str(self.id) +\
            ' ' + self.structtype +\
            ' ' + self.get_representation()

    def get_representation(self):
        """
        Used to generate a short description.
        """
        ret = ''
        for i in self.nodes:
            ret += str(i.id) + ' '
        return ret

    def hll_info_fancy(self):
        """
        Used for pseudo-HLL-view.
        """
        ret = ''
        for i in self.hll_info:
            if not isinstance(self.hll_info[i], ListType):
                ret += i + ':' + str(self.hll_info[i]) + ' '
            else:
                temp_str = ','.join([str(x) for x in self.hll_info[i]])
                ret += i + ':' + temp_str + ' '
        return ret

    def get_condition_string(self):
        """
        If the node is a condition,
        return a string that's a valid
        approximation of the condition in C.
        """
        if self.structtype == 'condition':
            return self.description
        else:
            return ''

    def print_fancy(self, prefix='', child_prefix='|-- '):
        """
        Pseudo-HLL-view.
        print a tree representing code
        as in C or any other HLL
        """
        print prefix + 'id: ' +\
            str(self.id) + ' type: ' +\
            self.structtype + ' starts at ' +\
            str(self.start_id) + self.get_condition_string() + ':'
        prefix = prefix + '    '
        hll_info_str = self.hll_info_fancy()
        if hll_info_str != '':
            print prefix + hll_info_str
        print prefix + child_prefix + 'nodes:'
        for i in self.nodes:
            i.print_fancy(prefix + '|   ')
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
        """
        HLL analysis of the generated structures.
        Used to determine which entrypoint a structure has, as well as
        which of it's sub-nodes has which purpose.
        """
        true_node = None  # node executed if condition is true.
        false_node = None  # node executed if condition is false.
        # Both variables are used to make condition-analysis possible.
        if self.structtype == 'if-then':
            self.hll_info['condition'] = self.edges[0].start
            for i in self.nodes:
                if i.id != self.edges[0].start:
                    self.hll_info['then'] = i.id
                    true_node = i.id
        elif self.structtype == 'if-then-else':
            self.hll_info['condition'] = self.edges[0].start
            for i in self.edges:
                if not i.active:
                    self.hll_info['then'] = i.end
                    false_node = i.end
                else:
                    self.hll_info['else'] = i.end
                    true_node = i.end
        elif self.structtype == 'while-loop':
            self.hll_info['condition'] = self.start_id
            self.hll_info['body'] = self.get_other_node(self.start_id)
            true_node = self.get_other_node(self.start_id)
        elif self.structtype == 'do-loop':
            self.hll_info['condition'] = self.get_other_node(self.start_id)
            self.hll_info['body'] = self.start_id
            if not self.hll_info['condition']:
                self.hll_info['condition'] = self.get_condition_from_block()
            true_node = self.start_id
        if 'condition' in self.hll_info:
            # If a child-node is a condition, analyze it properly
            cond = self.get_node_by_id(self.hll_info['condition'])
            if self.structtype == 'do-loop' and not cond:
                cond = self.nodes[0].nodes[-1]
            if isinstance(cond, StructNode) and cond.structtype == 'condition':
                cond.generate_dfs_tree()
                cond.compute_condition(true_node, false_node)

    def get_edge_by_endpoints(self, start, end):
        """
        Get an edge-instance which is identified by its start-
        and endpoint.
        """
        if isinstance(start, str):
            start = self.struct_nodes[start][1]
        if isinstance(end, str):
            end = self.struct_nodes[end][0]
        for edge in self.edges + self.replaced_edges:
            if edge.start == start and edge.end == end:
                return edge

    def compute_condition(self, node_true, node_false):
        """
        Compute how the nodes are logically connected in a complex
        condition. Works for ||, && and simple negation (!),
        which should be sufficient.
        """
        for node_id in self.tree.postorder():
            # make recursion by iteration possible:
            while True:
                next_nodes = self.get_next_nodes(node_id, True)
                followup = None
                secondary = None
                next_nodes_1 = self.get_next_nodes(next_nodes[0], True)
                next_nodes_2 = self.get_next_nodes(next_nodes[1], True)
                if next_nodes[0] in next_nodes_2:
                    # we found an if-like structure
                    followup, secondary = next_nodes
                elif next_nodes[1] in next_nodes_1:
                    # we found an if-like structure
                    secondary, followup = next_nodes
                # Find an appropriate representation for the nodes (str)
                if isinstance(node_id, int):
                    desc_primary = str(node_id)
                    followup_edge = self.get_edge_by_endpoints(
                        node_id, followup)
                    if followup_edge and not followup_edge.active:
                        desc_primary = '!' + desc_primary
                else:
                    desc_primary = self.struct_nodes[node_id][2]
                if isinstance(secondary, int):
                    desc_secondary = str(secondary)
                    if not self.get_edge_by_endpoints(secondary,
                                                      followup).active:
                        desc_secondary = '!' + desc_secondary
                elif isinstance(secondary, str):
                    desc_secondary = self.struct_nodes[secondary][2]
                if followup and \
                        len(self.get_previous_nodes(secondary, True)) == 1:
                    # We found an || or &&
                    if followup == node_true:
                        # It's a ||, insert the struct:
                        self.struct_nodes[
                            self.current_id] = (
                                node_id, secondary,
                                '(' + desc_primary + ' || ' +
                                desc_secondary + ')')
                        # set the struct info and prepare for
                        # recursive analysis:
                        self.structs[node_id] = self.current_id
                        node_id = self.current_id
                        self.structs[secondary] = self.current_id
                        self.current_id = chr(ord(self.current_id)+1)
                    elif followup == node_false or not \
                            self.get_node_by_id(followup):
                        # It's a &&, insert the struct:
                        self.struct_nodes[
                            self.current_id] = (
                                node_id, secondary,
                                '(' + desc_primary + ' && ' +
                                desc_secondary + ')')
                        # set the struct info and prepare for
                        # recursive analysis:
                        self.structs[node_id] = self.current_id
                        node_id = self.current_id
                        self.structs[secondary] = self.current_id
                        self.current_id = chr(ord(self.current_id)+1)
                else:
                    # Nothing found, no recursive analysis needed.
                    break
        # Make the results availible to the HLL-view.
        if self.current_id != 'a':  # we have found at least something
            self.description = self.struct_nodes[chr(ord(self.current_id)-1)][2]

    def get_condition_from_block(self):
        """
        A check-less way to get a condition node from a block
        inside a do-loop (which is the last node of it).
        """
        return self.nodes[0].nodes[-1].id

    def get_other_node(self, other_id):
        """
        Helper method. Used to get the second subnode from
        a structure with two nodes, given the first subnode.
        """
        if len(self.nodes) == 2:
            for i in self.nodes:
                if i.id != other_id:
                    return i.id

    def get_condition_node(self):
        """
        Get the subnode that is the condition of the
        structure.
        """
        if 'condition' in self.hll_info:
            for i in self.nodes:
                if self.hll_info['condition'] == i.id:
                    return i
            if self.nodes[0].structtype == 'block':
                for i in self.nodes[0].nodes:
                    if self.hll_info['condition'] == i.id:
                        return i

    def get_node_by_id(self, node_id):
        """
        Return the subnode specified by id.
        Needed, since subnodes of StructNodes are saved
        in a list and keep their old id's.
        """
        for node in self.nodes:
            if node.id == node_id:
                return node


class Edge(object):
    """
    A graph-edge, that contains information about
    start, end and type of edge.
    An active edge is an executed jump, while a non-
    active edge isn't, being a simple transition to the
    next instruction.
    """

    def __init__(self, id, start, end, active=True):
        """
        Set the instance attributes.
        """
        self.id = id
        self.start = start
        self.end = end
        self.active = active

    def __str__(self):
        """ Pretty printing. """
        return str(self.start) + '-' + str(self.end)

    def equals(self, other):
        """
        Wrapper around self.__eq__
        """
        return self.__eq__(other)

    def __eq__(self, other):
        """
        Are two edges identical?
        """
        return self.start == other.start and self.end == other.end

    def __hash__(self):
        """
        Make hashing and thus sorting possible.
        """
        return hash(self.__str__())
