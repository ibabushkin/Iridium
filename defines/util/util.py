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
    if string:
        if string.startswith('0x'):
            return int(string, 16)
        elif string.endswith('h'):
            return int(string[:-1], 16)
        else:
            return int(string)
    return 0
