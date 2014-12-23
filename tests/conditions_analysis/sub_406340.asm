sub_406340 proc near
var_14= dword ptr -14h
arg_0= dword ptr  0Ch
arg_4= dword ptr  10h
arg_8= dword ptr  14h
push esi
push ebx
sub esp, 14h
mov eax, [esp+14h+arg_8]
mov ebx, [esp+14h+arg_0]
mov esi, [esp+14h+arg_4]
mov [esp+14h+var_14], eax
call sub_406300
movzx edx, byte ptr [ebx]
lea ecx, [ebx+1]
test dl, dl
mov [eax], dl
mov edx, eax
jz short loc_406376
loc_406367:
movzx ebx, byte ptr [ecx]
add edx, 1
add ecx, 1
test bl, bl
mov [edx], bl
jnz short loc_406367
loc_406376:
test esi, esi
jz short loc_40637C
mov [esi], edx
loc_40637C:
add esp, 14h
pop ebx
pop esi
retn
sub_406340 endp
