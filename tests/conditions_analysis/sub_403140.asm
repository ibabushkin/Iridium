sub_403140 proc near
var_48= dword ptr -48h
var_44= dword ptr -44h
var_40= dword ptr -40h
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_2C= dword ptr -2Ch
var_1E= word ptr -1Eh
var_1C= dword ptr -1Ch
var_C= dword ptr -0Ch
push ebp
mov ebp, esp
push edi
push esi
push ebx
mov ebx, eax
sub esp, 3Ch
cmp dword ptr [eax+10h], 0FFFFFFFDh
jz loc_4031D4
movzx edx, word ptr [eax+14h]
loc_403159:
test dx, dx
jz short loc_4031B2
mov eax, [ebx+10h]
mov [ebp+var_2C], esp
add eax, 0Fh
and eax, 0FFFFFFF0h
call sub_4026E0
sub esp, eax
lea edi, [esp+48h+var_38]
lea eax, [ebp+var_1C]
mov [ebp+var_1C], 0
mov [esp+48h+var_40], eax
mov [esp+48h+var_44], edx
mov [esp+48h+var_48], edi
call sub_405DF0
test eax, eax
jle short loc_4031C6
lea esi, [edi+eax]
loc_403196:
movsx eax, byte ptr [edi]
mov edx, ebx
add edi, 1
call sub_4028D0
cmp edi, esi
jnz short loc_403196
loc_4031A7:
mov esp, [ebp+var_2C]
lea esp, [ebp-0Ch]
pop ebx
pop esi
pop edi
pop ebp
retn
loc_4031B2:
mov edx, ebx
mov eax, 2Eh
call sub_4028D0
lea esp, [ebp-0Ch]
pop ebx
pop esi
pop edi
pop ebp
retn
loc_4031C6:
mov edx, ebx
mov eax, 2Eh
call sub_4028D0
jmp short loc_4031A7
loc_4031D4:
mov [ebp+var_1C], 0
call localeconv
lea edx, [ebp+var_1C]
mov [esp+48h+var_3C], edx
mov [esp+48h+var_40], 10h
mov eax, [eax]
mov [esp+48h+var_44], eax
lea eax, [ebp-1Eh]
mov [esp+48h+var_48], eax
call sub_4060F0
test eax, eax
jle short loc_403214
movzx edx, [ebp+var_1E]
mov [ebx+14h], dx
loc_40320C:
mov [ebx+10h], eax
jmp loc_403159
loc_403214:
movzx edx, word ptr [ebx+14h]
jmp short loc_40320C
sub_403140 endp
