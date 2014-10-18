register_tm_clones proc near
var_18= dword ptr -18h
var_14= dword ptr -14h
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 13F3h
sub esp, 14h
lea eax, [ebx+20h]
lea edx, [ebx+20h]
sub eax, edx
sar eax, 2
mov ecx, eax
shr ecx, 1Fh
add eax, ecx
sar eax, 1
jnz short loc_8048444
loc_804843E:
add esp, 14h
pop ebx
pop ebp
retn
loc_8048444:
mov ecx, [ebx-4]
test ecx, ecx
jz short loc_804843E
mov [esp+18h+var_14], eax
mov [esp+18h+var_18], edx
call ecx
jmp short loc_804843E
register_tm_clones endp
