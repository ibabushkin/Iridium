sub_4072F0 proc near
arg_0= dword ptr  8
push ebx
mov eax, [esp+arg_0]
mov ecx, [eax+10h]
lea edx, [eax+14h]
lea ebx, [eax+ecx*4+14h]
cmp edx, ebx
jnb short loc_407329
mov ecx, [eax+14h]
xor eax, eax
test ecx, ecx
jz short loc_407316
jmp short loc_407322
align 10h
loc_407310:
mov ecx, [edx]
test ecx, ecx
jnz short loc_407322
loc_407316:
add edx, 4
add eax, 20h
cmp ebx, edx
ja short loc_407310
pop ebx
retn
loc_407322:
bsf ecx, ecx
add eax, ecx
pop ebx
retn
loc_407329:
xor eax, eax
pop ebx
retn
sub_4072F0 endp
