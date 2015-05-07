register_tm_clones proc near
var_4= dword ptr -4
push ebp
mov ebp, esp
push ebx
call __x86_get_pc_thunk_bx
add ebx, 151Bh
sub esp, 4
lea edx, [ebx+24h]
lea eax, [ebx+24h]
sub eax, edx
sar eax, 2
mov ecx, eax
shr ecx, 1Fh
add eax, ecx
sar eax, 1
jz short loc_80484A2
mov ecx, [ebx-4]
test ecx, ecx
jz short loc_80484A2
sub esp, 8
push eax
push edx
call ecx
add esp, 10h
loc_80484A2:
mov ebx, [ebp+var_4]
leave
retn
register_tm_clones endp
