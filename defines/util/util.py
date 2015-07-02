"""
File: util.py
Author: Inokentiy Babushkin
Email: inokentiy.babushkin@googlemail.com
Github: ibabushkin
Description:
    Utility functions.
"""


def hex_to_num(string):
    """
    Get a string that contains a hexadecimal
    number in any format and return an int.
    """
    ret = None
    if string:
        neg = False
        if string.startswith('-'):
            neg = True
            string = string[1:]
        if string.startswith('0x'):
            ret = int(string, 16)
        elif string.endswith('h'):
            ret = int(string[:-1], 16)
        else:
            ret = int(string)
        if neg:
            ret = -ret
    return ret
