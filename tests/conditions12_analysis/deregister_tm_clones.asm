deregister_tm_clones proc near
var_18= dword ptr -18h
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 1433h
sub esp, 14h
lea eax, [ebx+23h]
lea edx, [ebx+20h]
sub eax, edx
cmp eax, 6
ja short loc_80483FB
loc_80483F5:
add esp, 14h
pop ebx
pop ebp
retn
loc_80483FB:
mov eax, [ebx-10h]
test eax, eax
jz short loc_80483F5
mov [esp+18h+var_18], edx
call eax
jmp short loc_80483F5
deregister_tm_clones endp
