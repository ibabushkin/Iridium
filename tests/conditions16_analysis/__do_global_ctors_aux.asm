__do_global_ctors_aux proc near
push ebp
mov ebp, esp
push esi
push ebx
call __x86_get_pc_thunk_bx
add ebx, 121Eh
mov eax, [ebx-0ECh]
lea esi, [ebx-0ECh]
cmp eax, 0FFFFFFFFh
jz short loc_8048604
lea esi, [esi+0]
loc_80485F8:
sub esi, 4
call eax
mov eax, [esi]
cmp eax, 0FFFFFFFFh
jnz short loc_80485F8
loc_8048604:
pop ebx
pop esi
pop ebp
retn
__do_global_ctors_aux endp
