__libc_csu_init proc near
var_24= dword ptr -24h
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
arg_0= dword ptr  0Ch
arg_4= dword ptr  10h
arg_8= dword ptr  14h
push ebp
push edi
xor edi, edi
push esi
push ebx
call __x86_get_pc_thunk_bx
add ebx, 129Dh
sub esp, 1Ch
mov ebp, [esp+24h+arg_0]
lea esi, [ebx-0ECh]
call _init_proc
lea eax, [ebx-0ECh]
sub esi, eax
sar esi, 2
test esi, esi
jz short loc_80485D9
lea esi, [esi+0]
loc_80485B8:
mov eax, [esp+24h+arg_8]
mov [esp+24h+var_24], ebp
mov [esp+24h+var_1C], eax
mov eax, [esp+24h+arg_4]
mov [esp+24h+var_20], eax
call dword ptr [ebx+edi*4-0ECh]
add edi, 1
cmp edi, esi
jnz short loc_80485B8
loc_80485D9:
add esp, 1Ch
pop ebx
pop esi
pop edi
pop ebp
retn
__libc_csu_init endp
