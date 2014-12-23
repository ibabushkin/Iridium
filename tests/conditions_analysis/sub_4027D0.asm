sub_4027D0 proc near
var_48= dword ptr -48h
var_44= dword ptr -44h
var_40= dword ptr -40h
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
var_10= dword ptr -10h
var_C= dword ptr -0Ch
arg_0= dword ptr  8
arg_4= dword ptr  0Ch
arg_8= dword ptr  10h
arg_C= dword ptr  14h
arg_10= dword ptr  18h
arg_14= dword ptr  1Ch
arg_18= dword ptr  20h
push ebx
mov ecx, eax
sub esp, 48h
mov eax, [esp+48h+arg_0]
mov [esp+48h+var_28], eax
mov eax, [esp+48h+arg_4]
mov [esp+24h], eax
mov eax, [esp+48h+arg_8]
mov [esp+48h+var_20], eax
mov eax, [esp+48h+arg_C]
fld tbyte ptr [esp+48h+var_28]
mov [esp+48h+var_1C], eax
fxam
fstsw ax
fstp st
test ah, 1
jz short loc_402820
test ah, 4
jz loc_4028A0
mov [esp+48h+var_10], 3
movzx edx, word ptr [esp+48h+var_20]
xor eax, eax
jmp short loc_402834
loc_402820:
test ah, 4
jnz short loc_402881
movzx edx, word ptr [esp+48h+var_20]
xor eax, eax
mov [esp+48h+var_10], 0
loc_402834:
and edx, 8000h
loc_40283A:
mov ebx, [esp+48h+arg_18]
mov [ebx], edx
lea edx, [esp+48h+var_C]
mov [esp+48h+var_2C], edx
mov edx, [esp+48h+arg_14]
mov [esp+48h+var_38], ecx
mov [esp+48h+var_44], eax
mov [esp+48h+var_48], offset unk_40801C
mov [esp+48h+var_30], edx
mov edx, [esp+48h+arg_10]
mov [esp+48h+var_34], edx
lea edx, [esp+48h+var_10]
mov [esp+48h+var_3C], edx
lea edx, [esp+48h+var_28]
mov [esp+48h+var_40], edx
call sub_404790
add esp, 48h
pop ebx
retn
loc_402881:
test ah, 40h
jz short loc_4028B0
mov [esp+48h+var_10], 2
movzx edx, word ptr [esp+48h+var_20]
mov eax, 0FFFFBFC3h
jmp short loc_402834
align 10h
loc_4028A0:
mov [esp+48h+var_10], 4
xor eax, eax
xor edx, edx
jmp short loc_40283A
align 10h
loc_4028B0:
movzx edx, word ptr [esp+48h+var_20]
mov [esp+48h+var_10], 1
mov eax, edx
and eax, 7FFFh
sub eax, 403Eh
jmp loc_402834
sub_4027D0 endp
