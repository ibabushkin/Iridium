sub_4069E0 proc near
var_1C= dword ptr -1Ch
arg_0= dword ptr  4
sub esp, 1Ch
mov [esp+1Ch+var_1C], 1
call sub_4067D0
test eax, eax
jz short loc_406A01
mov edx, [esp+1Ch+arg_0]
mov dword ptr [eax+10h], 1
mov [eax+14h], edx
loc_406A01:
add esp, 1Ch
retn
sub_4069E0 endp
