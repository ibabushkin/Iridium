sub_405D50 proc near
var_4C= dword ptr -4Ch
var_48= dword ptr -48h
var_44= dword ptr -44h
var_40= dword ptr -40h
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_20= dword ptr -20h
var_10= dword ptr -10h
arg_0= dword ptr  4
arg_4= dword ptr  8
arg_8= dword ptr  0Ch
arg_C= dword ptr  10h
sub esp, 4Ch
mov edx, [esp+4Ch+arg_8]
mov eax, [esp+4Ch+arg_4]
test edx, edx
mov word ptr [esp+4Ch+var_20], ax
jnz short loc_405D80
cmp ax, 0FFh
ja short loc_405DD8
mov edx, [esp+4Ch+arg_0]
mov [edx], al
mov eax, 1
loc_405D75:
add esp, 4Ch
retn 
align 10h
loc_405D80:
lea eax, [esp+4Ch+var_10]
mov [esp+4Ch+var_30], eax
mov eax, [esp+4Ch+arg_C]
mov [esp+4Ch+var_10], 0
mov [esp+4Ch+var_34], 0
mov [esp+4Ch+var_40], 1
mov [esp+4Ch+var_38], eax
mov eax, [esp+4Ch+arg_0]
mov [esp+4Ch+var_48], 0
mov [esp+4Ch+var_4C], edx
mov [esp+4Ch+var_3C], eax
lea eax, [esp+4Ch+var_20]
mov [esp+4Ch+var_44], eax
call ds:WideCharToMultiByte
sub esp, 20h
test eax, eax
jz short loc_405DD8
mov edx, [esp+4Ch+var_10]
test edx, edx
jz short loc_405D75
loc_405DD8:
call _errno
mov dword ptr [eax], 2Ah
mov eax, 0FFFFFFFFh
add esp, 4Ch
retn
sub_405D50 endp
