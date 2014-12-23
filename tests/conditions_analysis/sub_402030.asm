sub_402030 proc near
var_4= dword ptr -4
sub esp, 4
mov [esp+4+var_4], 400000h
call sub_401EF0
xor edx, edx
test eax, eax
jz short loc_402051
mov eax, ds:40003Ch
movzx edx, word ptr [eax+400006h]
loc_402051:
mov eax, edx
add esp, 4
retn
sub_402030 endp
