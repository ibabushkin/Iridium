deregister_tm_clones proc near
var_18= dword ptr -18h
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 13FBh
sub esp, 14h
lea eax, [ebx+1Fh]
lea edx, [ebx+1Ch]
sub eax, edx
cmp eax, 6
ja short loc_80483CB
loc_80483C5:
add esp, 14h
pop ebx
pop ebp
retn
loc_80483CB:
mov eax, [ebx-10h]
test eax, eax
jz short loc_80483C5
mov [esp+18h+var_18], edx
call eax
jmp short loc_80483C5
deregister_tm_clones endp
