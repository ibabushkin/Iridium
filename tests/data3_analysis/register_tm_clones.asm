register_tm_clones proc near
var_18= dword ptr -18h
var_14= dword ptr -14h
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 141Fh
sub esp, 14h
lea eax, [ebx+28h]
lea edx, [ebx+28h]
sub eax, edx
sar eax, 2
mov ecx, eax
shr ecx, 1Fh
add eax, ecx
sar eax, 1
jnz short loc_80484B4
loc_80484AE:
add esp, 14h
pop ebx
pop ebp
retn
loc_80484B4:
mov ecx, [ebx-4]
test ecx, ecx
jz short loc_80484AE
mov [esp+18h+var_14], eax
mov [esp+18h+var_18], edx
call ecx
jmp short loc_80484AE
register_tm_clones endp
