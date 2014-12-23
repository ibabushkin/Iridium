sub_401FF0 proc near
var_8= dword ptr -8
var_4= dword ptr -4
arg_0= dword ptr  4
sub esp, 8
mov [esp+8+var_8], 400000h
call sub_401EF0
mov edx, eax
xor eax, eax
test edx, edx
jz short loc_402020
mov eax, [esp+8+arg_0]
mov [esp+8+var_8], 400000h
sub eax, 400000h
mov [esp+8+var_4], eax
call sub_401F20
loc_402020:
add esp, 8
retn
sub_401FF0 endp
