sub_401750 proc near
var_1C= dword ptr -1Ch
arg_0= dword ptr  4
sub esp, 1Ch
mov eax, [esp+1Ch+arg_0]
mov [esp+1Ch+var_1C], eax
call sub_401690
cmp eax, 1
sbb eax, eax
add esp, 1Ch
retn
sub_401750 endp
