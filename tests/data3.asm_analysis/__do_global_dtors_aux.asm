__do_global_dtors_aux proc near
push ebp
mov ebp, esp
push esi
push ebx
call __x86_get_pc_thunk_bx
add ebx, 13CEh
cmp byte ptr [ebx+28h], 0
jnz short loc_804852E
mov eax, [ebx+2Ch]
lea esi, [ebx-0E0h]
lea edx, [ebx-0E4h]
sub esi, edx
sar esi, 2
sub esi, 1
cmp eax, esi
jnb short loc_8048522
nop
loc_8048508:
add eax, 1
mov [ebx+2Ch], eax
call dword ptr [ebx+eax*4-0E4h]
mov eax, [ebx+2Ch]
cmp eax, esi
jb short loc_8048508
loc_8048522:
call deregister_tm_clones
mov byte ptr [ebx+28h], 1
loc_804852E:
pop ebx
pop esi
pop ebp
retn
__do_global_dtors_aux endp
