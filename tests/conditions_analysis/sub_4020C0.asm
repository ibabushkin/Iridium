sub_4020C0 proc near
var_4= dword ptr -4
sub esp, 4
mov [esp+4+var_4], 400000h
call sub_401EF0
xor edx, edx
test eax, eax
mov eax, 400000h
cmovnz edx, eax
add esp, 4
mov eax, edx
retn
sub_4020C0 endp
