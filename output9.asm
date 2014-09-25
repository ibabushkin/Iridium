main proc near
var_4= dword ptr -4
push ebp
mov ebp, esp
sub esp, 10h
mov [ebp+var_4], 0
jmp short loc_80484F7
loc_80484EB:
cmp [ebp+var_4], 7
jnz short loc_80484F3
jmp short locret_80484FD
loc_80484F3:
add [ebp+var_4], 1
loc_80484F7:
cmp [ebp+var_4], 13h
jle short loc_80484EB
locret_80484FD:
leave
retn
main endp
