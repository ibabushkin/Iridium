__do_global_dtors_aux proc near
push ebp
mov ebp, esp
push esi
push ebx
call __x86_get_pc_thunk_bx
add ebx, 136Ah
cmp byte ptr [ebx+1Ch], 0
jnz short loc_804848E
mov eax, [ebx+20h]
lea esi, [ebx-0E0h]
lea edx, [ebx-0E4h]
sub esi, edx
sar esi, 2
sub esi, 1
cmp eax, esi
jnb short loc_8048482
nop
loc_8048468:
add eax, 1
mov [ebx+20h], eax
call dword ptr [ebx+eax*4-0E4h]
mov eax, [ebx+20h]
cmp eax, esi
jb short loc_8048468
loc_8048482:
call deregister_tm_clones
mov byte ptr [ebx+1Ch], 1
loc_804848E:
pop ebx
pop esi
pop ebp
retn
__do_global_dtors_aux endp
