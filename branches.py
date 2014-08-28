s = '''main proc near

loc_401518:
cmp	[esp+20h+var_4], 7
jnz	short loc_40152B
mov	[esp+20h+var_20], 37h
call	putchar

loc_40152B:
call	_getch
mov	eax, 0
leave
retn
main endp'''

lines = s.split('\n')
labels = []
forward_jumps = []
back_jumps = []
last_label = 'ZZZ'

for index, line in enumerate(lines):
    if line.endswith(':'):
        last_label = line[:-1]
    else:
        tokens = line.split()
        if len(tokens) > 0:
            if tokens[0] == 'jnz':
                if tokens[-1] > last_label:
                    forward_jumps.append((tokens[0], tokens[-1]))