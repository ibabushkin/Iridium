sub_403610 proc near
var_40= dword ptr -40h
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_18= dword ptr -18h
var_14= dword ptr -14h
var_10= tbyte ptr -10h
var_4= dword ptr -4
arg_0= tbyte ptr  10h
push edi
push esi
push ebx
mov ebx, eax
sub esp, 40h
mov eax, [eax+0Ch]
test eax, eax
js loc_4036C0
loc_403623:
fld [esp+40h+arg_0]
mov [esp+40h+var_30], eax
lea edx, [esp+40h+var_18]
fstp [esp+40h+var_10]
mov eax, dword ptr [esp+40h+var_10]
mov [esp+40h+var_28], edx
lea edx, [esp+40h+var_14]
mov [esp+40h+var_2C], edx
mov [esp+40h+var_40], eax
mov eax, dword ptr [esp+40h+var_10+4]
mov [esp+40h+var_3C], eax
mov eax, dword ptr [esp+40h+var_10+8]
mov [esp+40h+var_38], eax
mov eax, [esp+40h+var_4]
mov [esp+40h+var_34], eax
mov eax, 3
call sub_4027D0
mov ecx, [esp+40h+var_14]
cmp ecx, 0FFFF8000h
mov edi, eax
jz short loc_4036D1
mov edx, eax
mov eax, [esp+40h+var_18]
mov [esp+40h+var_40], ebx
call sub_403220
mov eax, [ebx+8]
lea edx, [eax-1]
test eax, eax
mov [ebx+8], edx
jle short loc_4036AA
loc_403691:
mov edx, ebx
mov eax, 20h
call sub_4028D0
mov ecx, [ebx+8]
lea esi, [ecx-1]
test ecx, ecx
mov [ebx+8], esi
jg short loc_403691
loc_4036AA:
mov [esp+40h+var_40], edi
call sub_406390
add esp, 40h
pop ebx
pop esi
pop edi
retn
align 10h
loc_4036C0:
mov dword ptr [ebx+0Ch], 6
mov eax, 6
jmp loc_403623
loc_4036D1:
mov edx, eax
mov eax, [esp+40h+var_18]
mov ecx, ebx
call sub_402AD0
mov [esp+40h+var_40], edi
call sub_406390
add esp, 40h
pop ebx
pop esi
pop edi
retn
sub_403610 endp
