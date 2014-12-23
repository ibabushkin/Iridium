sub_401F20 proc near
arg_0= dword ptr  0Ch
arg_4= dword ptr  10h
push esi
push ebx
mov edx, [esp+arg_0]
mov ebx, [esp+arg_4]
add edx, [edx+3Ch]
movzx esi, word ptr [edx+6]
movzx eax, word ptr [edx+14h]
test esi, esi
lea eax, [edx+eax+18h]
jz short loc_401F58
xor edx, edx
nop
loc_401F40:
mov ecx, [eax+0Ch]
cmp ecx, ebx
ja short loc_401F4E
add ecx, [eax+8]
cmp ebx, ecx
jb short loc_401F5A
loc_401F4E:
add edx, 1
add eax, 28h
cmp edx, esi
jb short loc_401F40
loc_401F58:
xor eax, eax
loc_401F5A:
pop ebx
pop esi
retn
sub_401F20 endp
