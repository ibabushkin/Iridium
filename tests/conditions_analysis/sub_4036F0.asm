sub_4036F0 proc near
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
sub esp, 40
mov eax, [eax+0Ch]
cmp eax, 0
jl loc_403827
jz loc_403810
loc_40370A:
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
mov eax, 2
call sub_4027D0
mov esi, [esp+40h+var_14]
cmp esi, 0FFFF8000h
mov edi, eax
jz loc_403842
cmp esi, 0FFFFFFFDh
jl short loc_4037D8
mov eax, [ebx+0Ch]
cmp esi, eax
jg short loc_4037D8
test byte ptr [ebx+5], 8
jnz loc_403838
mov [esp+40h+var_40], edi
call strlen
sub eax, esi
test eax, eax
mov [ebx+0Ch], eax
js loc_403851
loc_40378C:
mov eax, [esp+40h+var_18]
mov edx, edi
mov ecx, esi
mov [esp+40h+var_40], ebx
call sub_403220
mov eax, [ebx+8]
lea edx, [eax-1]
test eax, eax
mov [ebx+8], edx
jle short loc_4037FC
lea esi, [esi+0]
loc_4037B0:
mov edx, ebx
mov eax, 20h
call sub_4028D0
mov ecx, [ebx+8]
lea esi, [ecx-1]
test ecx, ecx
mov [ebx+8], esi
jg short loc_4037B0
mov [esp+40h+var_40], edi
call sub_406390
add esp, 40h
pop ebx
pop esi
pop edi
retn 
loc_4037D8:
test byte ptr [ebx+5], 8
jnz short loc_403821
mov [esp+40h+var_40], edi
call strlen
sub eax, 1
mov [ebx+0Ch], eax
loc_4037EC:
mov eax, [esp+40h+var_18]
mov ecx, esi
mov edx, edi
mov [esp+40h+var_40], ebx
call sub_403540
loc_4037FC:
mov [esp+40h+var_40], edi
call sub_406390
add esp, 40h
pop ebx
pop esi
pop edi
retn
align 10h
loc_403810:
mov dword ptr [ebx+0Ch], 1
mov eax, 1
jmp loc_40370A
loc_403821:
sub dword ptr [ebx+0Ch], 1
jmp short loc_4037EC
loc_403827:
mov dword ptr [ebx+0Ch], 6
mov eax, 6
jmp loc_40370A
loc_403838:
sub eax, esi
mov [ebx+0Ch], eax
jmp loc_40378C
loc_403842:
mov edx, eax
mov eax, [esp+40h+var_18]
mov ecx, ebx
call sub_402AD0
jmp short loc_4037FC
loc_403851:
mov edx, [ebx+8]
test edx, edx
jle loc_40378C
add eax, edx
mov [ebx+8], eax
jmp loc_40378C
sub_4036F0 endp
