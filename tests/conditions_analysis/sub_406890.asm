sub_406890 proc near
arg_0= dword ptr  8
push ebx
sub esp, 8
mov ebx, [esp+8+arg_0]
test ebx, ebx
jz short loc_4068D0
cmp dword ptr [ebx+4], 9
jg short loc_4068C7
xor eax, eax
call sub_4066A0
mov eax, [ebx+4]
mov edx, ds:dword_40A3E0[eax*4]
mov ds:dword_40A3E0[eax*4], ebx
xor eax, eax
mov [ebx], edx
add esp, 8
pop ebx
jmp sub_406760
loc_4068C7:
add esp, 8
pop ebx
jmp free
loc_4068D0:
add esp, 8
pop ebx
retn
sub_406890 endp
