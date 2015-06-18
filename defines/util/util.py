def hex_to_num(string):
    if string.startswith('0x'):
        return int(string, 16)
    elif string.endswith('h'):
        return int(string[:-1], 16)
    else:
        return int(string)
