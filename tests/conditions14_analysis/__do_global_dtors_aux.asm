__do_global_dtors_aux proc near
push ebp
mov ebp, esp
push esi
push ebx
call __x86_get_pc_thunk_bx
add ebx, 13BEh
cmp byte ptr [ebx+20h], 0
jnz short loc_80484BE
mov eax, [ebx+24h]
lea esi, [ebx-0E0h]
lea edx, [ebx-0E4h]
sub esi, edx
sar esi, 2
sub esi, 1
cmp eax, esi
jnb short loc_80484B2
nop
loc_8048498:
add eax, 1
mov [ebx+24h], eax
call dword ptr [ebx+eax*4-0E4h]
mov eax, [ebx+24h]
cmp eax, esi
jb short loc_8048498
loc_80484B2:
call deregister_tm_clones
mov byte ptr [ebx+20h], 1
loc_80484BE:
pop ebx
pop esi
pop ebp
retn
__do_global_dtors_aux endp
