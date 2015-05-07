__do_global_dtors_aux proc near
push ebp
mov ebp, esp
push esi
push ebx
call __x86_get_pc_thunk_bx
add ebx, 14CAh
cmp byte ptr [ebx+24h], 0
jnz short loc_8048516
lea edx, [ebx-0E4h]
lea esi, [ebx-0E0h]
mov eax, [ebx+28h]
sub esi, edx
sar esi, 2
sub esi, 1
cmp eax, esi
jnb short loc_804850A
mov esi, esi
lea edi, [edi+0]
loc_80484F0:
add eax, 1
mov [ebx+28h], eax
call dword ptr [ebx+eax*4-0E4h]
mov eax, [ebx+28h]
cmp eax, esi
jb short loc_80484F0
loc_804850A:
call deregister_tm_clones
mov byte ptr [ebx+24h], 1
loc_8048516:
pop ebx
pop esi
pop ebp
retn
__do_global_dtors_aux endp
