deregister_tm_clones proc near
var_18= dword ptr -18h
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 145Fh
sub esp, 14h
lea eax, [ebx+2Bh]
lea edx, [ebx+28h]
sub eax, edx
cmp eax, 6
ja short loc_804846B
loc_8048465:
add esp, 14h
pop ebx
pop ebp
retn
loc_804846B:
mov eax, [ebx-10h]
test eax, eax
jz short loc_8048465
mov [esp+18h+var_18], edx
call eax
jmp short loc_8048465
deregister_tm_clones endp
