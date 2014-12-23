sub_407340 proc near
var_1C= dword ptr -1Ch
var_18= dword ptr -18h
sub esp, 1C
mov [esp+1Ch+var_18], 0
mov [esp+1Ch+var_1C], 2
call setlocale
mov [esp+1Ch+var_18], 2Eh
mov [esp+1Ch+var_1C], eax
call strchr
mov edx, eax
xor eax, eax
test edx, edx
jz short loc_40737A
add edx, 1
mov [esp+1Ch+var_1C], edx
call atoi
loc_40737A:
add esp, 1Ch
retn
sub_407340 endp
