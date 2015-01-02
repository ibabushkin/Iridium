register_tm_clones proc near
var_18= dword ptr -18h
var_14= dword ptr -14h
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 13BBh
sub esp, 14h
lea eax, [ebx+1Ch]
lea edx, [ebx+1Ch]
sub eax, edx
sar eax, 2
mov ecx, eax
shr ecx, 1Fh
add eax, ecx
sar eax, 1
jnz short loc_8048414
loc_804840E:
add esp, 14h
pop ebx
pop ebp
retn
loc_8048414:
mov ecx, [ebx-4]
test ecx, ecx
jz short loc_804840E
mov [esp+18h+var_14], eax
mov [esp+18h+var_18], edx
call ecx
jmp short loc_804840E
register_tm_clones endp
