sub_403D90 proc near
var_44= dword ptr -44h
var_40= dword ptr -40h
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_1C= dword ptr -1Ch
var_18= dword ptr -18h
var_14= tbyte ptr -14h
var_8= dword ptr -8
arg_0= tbyte ptr  0Ch
push esi
push ebx
mov ebx, eax
sub esp, 44h
mov eax, [eax+0Ch]
test eax, eax
js short loc_403E10
add eax, 1
loc_403DA1:
fld [esp+44h+arg_0]
mov [esp+44h+var_34], eax
lea edx, [esp+44h+var_1C]
fstp [esp+44h+var_14]
mov eax, dword ptr [esp+44h+var_14]
mov [esp+44h+var_2C], edx
lea edx, [esp+44h+var_18]
mov [esp+44h+var_30], edx
mov [esp+44h+var_44], eax
mov eax, dword ptr [esp+44h+var_14+4]
mov [esp+44h+var_40], eax
mov eax, dword ptr [esp+44h+var_14+8]
mov [esp+44h+var_3C], eax
mov eax, [esp+44h+var_8]
mov [esp+44h+var_38], eax
mov eax, 2
call sub_4027D0
mov ecx, [esp+44h+var_18]
cmp ecx, 0FFFF8000h
mov esi, eax
jz short loc_403E20
mov edx, eax
mov eax, [esp+44h+var_1C]
mov [esp+44h+var_44], ebx
call sub_403540
mov [esp+44h+var_44], esi
call sub_406390
add esp, 44h
pop ebx
pop esi
retn
loc_403E10:
mov dword ptr [ebx+0Ch], 6
mov eax, 7
jmp short loc_403DA1
align 10h
loc_403E20:
mov edx, eax
mov eax, [esp+44h+var_1C]
mov ecx, ebx
call sub_402AD0
mov [esp+44h+var_44], esi
call sub_406390
add esp, 44h
pop ebx
pop esi
retn
sub_403D90 endp
