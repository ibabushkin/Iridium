frame_dummy proc near
var_4= dword ptr -4
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 145Bh
sub esp, 4
lea eax, [ebx-0DCh]
mov edx, [eax]
test edx, edx
jnz short loc_8048550
loc_804853E:
mov ebx, [ebp+var_4]
leave
jmp register_tm_clones
align 10h
loc_8048550:
mov edx, [ebx-8]
test edx, edx
jz short loc_804853E
sub esp, 0Ch
push eax
call edx
add esp, 10h
jmp short loc_804853E
frame_dummy endp
