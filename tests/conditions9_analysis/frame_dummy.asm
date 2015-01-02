frame_dummy proc near
var_18= dword ptr -18h
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 12FBh
sub esp, 14h
mov eax, [ebx-0DCh]
test eax, eax
jz short loc_80484D1
mov eax, [ebx-8]
test eax, eax
jz short loc_80484D1
lea edx, [ebx-0DCh]
mov [esp+18h+var_18], edx
call eax
loc_80484D1:
add esp, 14h
pop ebx
pop ebp
jmp register_tm_clones
frame_dummy endp
