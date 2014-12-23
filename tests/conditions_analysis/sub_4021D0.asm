sub_4021D0 proc near
var_1C= dword ptr -1Ch
mov eax, ds:dword_40A058
test eax, eax
jz short loc_4021E0
retn
align 10h
loc_4021E0:
push ebx
xor eax, eax
sub esp, 18
mov [esp+1Ch+var_1C], eax
lea ebx, [eax+1]
call sub_402140
test eax, eax
jz short loc_402257
loc_4021F5:
movzx edx, byte ptr [eax]
and edx, 0FFFFFFDFh
cmp dl, 4Dh
jnz short loc_402246
movzx edx, byte ptr [eax+1]
and edx, 0FFFFFFDFh
cmp dl, 53h
jnz short loc_402246
movzx edx, byte ptr [eax+2]
and edx, 0FFFFFFDFh
cmp dl, 56h
jnz short loc_402246
movzx edx, byte ptr [eax+3]
and edx, 0FFFFFFDFh
cmp dl, 43h
jnz short loc_402246
movzx edx, byte ptr [eax+4]
and edx, 0FFFFFFDFh
cmp dl, 52h
jnz short loc_402246
movzx edx, byte ptr [eax+5]
mov ecx, edx
and ecx, 0FFFFFFDFh
cmp cl, 54h
jz short loc_40226E
sub edx, 30h
cmp dl, 9
jbe short loc_40226E
loc_402246:
mov eax, ebx
mov [esp+1Ch+var_1C], eax
lea ebx, [eax+1]
call sub_402140
test eax, eax
jnz short loc_4021F5
loc_402257:
mov [esp+1Ch+var_1C], offset aMsvcrt_dll
call ds:LoadLibraryW
sub esp, 4
mov ds:dword_40A058, eax
jmp short loc_402283
loc_40226E:
mov [esp+1Ch+var_1C], eax
call ds:GetModuleHandleA
sub esp, 4
test eax, eax
mov ds:dword_40A058, eax
jz short loc_402257
loc_402283:
add esp, 18h
pop ebx
retn
sub_4021D0 endp
