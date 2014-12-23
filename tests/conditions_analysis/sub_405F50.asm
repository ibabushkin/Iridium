sub_405F50 proc near
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_8= dword ptr -8
arg_0= dword ptr  0Ch
arg_4= dword ptr  10h
arg_8= dword ptr  14h
arg_C= dword ptr  18h
arg_10= dword ptr  1Ch
arg_14= dword ptr  20h
push esi
push ebx
sub esp, 34
mov ebx, [esp+34h+arg_4]
mov esi, [esp+34h+arg_C]
test ebx, ebx
jz loc_4060C5
mov edx, [esp+34h+arg_8]
test edx, edx
jz loc_4060D0
mov eax, [esi]
mov dword ptr [esi], 0
mov [esp+34h+var_8], eax
movzx eax, byte ptr [ebx]
test al, al
jz loc_406020
cmp [esp+34h+arg_14], 1
jbe short loc_406000
cmp byte ptr [esp+34h+var_8], 0
jnz loc_406031
mov edx, [esp+34h+arg_10]
mov [esp+34h+var_30], eax
mov [esp+34h+var_34], edx
call ds:IsDBCSLeadByteEx
sub esp, 8
test eax, eax
jz short loc_406000
cmp [esp+34h+arg_8], 1
jbe loc_4060DA
mov eax, [esp+34h+arg_0]
mov edx, [esp+34h+arg_10]
mov [esp+34h+var_20], 1
mov [esp+34h+var_28], 2
mov [esp+34h+var_24], eax
mov [esp+34h+var_2C], ebx
mov [esp+34h+var_30], 8
mov [esp+34h+var_34], edx
call ds:MultiByteToWideChar
sub esp, 18h
test eax, eax
jz short loc_406071
loc_405FF5:
add esp, 34h
mov eax, 2
pop ebx
pop esi
retn
loc_406000:
mov eax, [esp+34h+arg_10]
test eax, eax
jnz short loc_406083
movzx eax, byte ptr [ebx]
mov edx, [esp+34h+arg_0]
mov [edx], ax
add esp, 34h
mov eax, 1
pop ebx
pop esi
retn
align 10h
loc_406020:
mov eax, [esp+34h+arg_0]
mov word ptr [eax], 0
xor eax, eax
loc_40602B:
add esp, 34h
pop ebx
pop esi
retn 
loc_406031:
mov byte ptr [esp+34h+var_8+1], al
lea eax, [esp+34h+var_8]
mov edx, [esp+34h+arg_0]
mov [esp+34h+var_2C], eax
mov eax, [esp+34h+arg_10]
mov [esp+34h+var_20], 1
mov [esp+34h+var_28], 2
mov [esp+34h+var_24], edx
mov [esp+34h+var_30], 8
mov [esp+34h+var_34], eax
call ds:MultiByteToWideChar
sub esp, 18
test eax, eax
jnz short loc_405FF5
loc_406071:
call _errno
mov dword ptr [eax], 2Ah
mov eax, 0FFFFFFFFh
jmp short loc_40602B
loc_406083:
mov eax, [esp+34h+arg_0]
mov edx, [esp+34h+arg_10]
mov [esp+34h+var_20], 1
mov [esp+34h+var_28], 1
mov [esp+34h+var_24], eax
mov [esp+34h+var_2C], ebx
mov [esp+34h+var_30], 8
mov [esp+34h+var_34], edx
call ds:MultiByteToWideChar
sub esp, 18h
test eax, eax
jz short loc_406071
mov eax, 1
jmp loc_40602B
loc_4060C5:
add esp, 34h
xor eax, eax
pop ebx
pop esi
retn
align 10h
loc_4060D0:
mov eax, 0FFFFFFFEh
jmp loc_40602B
loc_4060DA:
movzx eax, byte ptr [ebx]
mov [esi], al
mov eax, 0FFFFFFFEh
jmp loc_40602B
sub_405F50 endp
