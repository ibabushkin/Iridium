sub_402A30 proc near
push edi
mov edi, eax
mov eax, [ecx+0Ch]
push esi
mov esi, edx
push ebx
mov ebx, ecx
test eax, eax
js short loc_402A45
cmp edx, eax
cmovg esi, eax
loc_402A45:
mov eax, [ebx+8]
cmp esi, eax
jge short loc_402AC0
sub eax, esi
test eax, eax
mov [ebx+8], eax
jle short loc_402A7A
test byte ptr [ebx+5], 4
jnz short loc_402A7A
sub eax, 1
mov [ebx+8], eax
loc_402A61:
mov edx, ebx
mov eax, 20h
call sub_4028D0
mov eax, [ebx+8]
lea edx, [eax-1]
test eax, eax
mov [ebx+8], edx
jnz short loc_402A61
loc_402A7A:
test esi, esi
jz short loc_402AAC
db 66h
nop
loc_402A80:
movsx eax, byte ptr [edi]
mov edx, ebx
add edi, 1
call sub_4028D0
sub esi, 1
jnz short loc_402A80
mov eax, [ebx+8]
lea edx, [eax-1]
test eax, eax
mov [ebx+8], edx
jle short loc_402AB9
nop
loc_402AA0:
mov edx, ebx
mov eax, 20h
call sub_4028D0
loc_402AAC:
mov eax, [ebx+8]
lea edx, [eax-1]
test eax, eax
mov [ebx+8], edx
jg short loc_402AA0
loc_402AB9:
pop ebx
pop esi
pop edi
retn
align 10h
loc_402AC0:
mov dword ptr [ebx+8], 0FFFFFFFFh
jmp short loc_402A7A
sub_402A30 endp
