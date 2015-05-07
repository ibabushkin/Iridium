deregister_tm_clones proc near
var_4= dword ptr -4
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 155Bh
sub esp, 4
lea edx, [ebx+24h]
lea eax, [ebx+27h]
sub eax, edx
cmp eax, 6
jbe short loc_8048458
mov eax, [ebx-10h]
test eax, eax
jz short loc_8048458
sub esp, 0Ch
push edx
call eax
add esp, 10h
loc_8048458:
mov ebx, [ebp+var_4]
leave
retn
deregister_tm_clones endp
