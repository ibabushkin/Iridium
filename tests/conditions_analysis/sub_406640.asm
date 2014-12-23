sub_406640 proc near
var_1C= dword ptr -1Ch
var_18= dword ptr -18h
mov edx, dword_408038
test edx, edx
jnz short loc_406650
mov eax, ds:dword_40A3D0
retn
loc_406650:
sub esp, 1Ch
call sub_4021D0
mov [esp+1Ch+var_18], offset a_get_output_f
mov [esp+1Ch+var_1C], eax
call ds:GetProcAddress
sub esp, 8
test eax, eax
jz short loc_406686
call eax
mov edx, 1
mov dword_408038, edx
mov ds:dword_40A3D0, eax
add esp, 1Ch
retn
loc_406686:
xor edx, edx
mov eax, ds:dword_40A3D0
mov dword_408038, edx
add esp, 1Ch
retn
sub_406640 endp
