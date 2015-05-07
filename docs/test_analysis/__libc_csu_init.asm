__libc_csu_init proc near
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_14= dword ptr -14h
arg_0= dword ptr  10h
arg_4= dword ptr  14h
arg_8= dword ptr  18h
push ebp
push edi
push esi
xor esi, esi
push ebx
call __x86_get_pc_thunk_bx
add ebx, 1329h
sub esp, 2Ch
mov ebp, [esp+30h+arg_0]
mov edi, [esp+30h+arg_4]
call _init_proc
lea eax, [ebx-0ECh]
lea edx, [ebx-0ECh]
sub edx, eax
sar edx, 2
mov [esp+30h+var_14], edx
jz short loc_80486AD
nop
lea esi, [esi+0]
loc_8048690:
mov eax, [esp+30h+arg_8]
mov [esp+30h+var_2C], edi
mov [esp+30h+var_30], ebp
mov [esp+30h+var_28], eax
call dword ptr [ebx+esi*4-0ECh]
inc esi
cmp esi, [esp+30h+var_14]
jnz short loc_8048690
loc_80486AD:
add esp, 2Ch
pop ebx
pop esi
pop edi
pop ebp
retn
__libc_csu_init endp
