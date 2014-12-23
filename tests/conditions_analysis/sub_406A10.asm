sub_406A10 proc near
var_5C= dword ptr -5Ch
var_44= dword ptr -44h
var_40= dword ptr -40h
var_38= dword ptr -38h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
var_18= dword ptr -18h
var_14= dword ptr -14h
var_10= dword ptr -10h
arg_0= dword ptr  14h
arg_4= dword ptr  18h
push ebp
push edi
push esi
push ebx
sub esp, 5Ch
mov esi, [esp+5Ch+arg_0]
mov ecx, [esp+5Ch+arg_4]
mov ebp, [esi+10h]
mov ebx, [ecx+10h]
cmp ebp, ebx
jge short loc_406A35
mov eax, ebp
mov ebp, ebx
mov ebx, eax
mov eax, esi
mov esi, ecx
mov ecx, eax
loc_406A35:
lea edi, [ebp+ebx+0]
xor eax, eax
cmp edi, [esi+8]
mov [esp+5Ch+var_1C], edi
setnle al
add eax, [esi+4]
mov [esp+5Ch+var_38], ecx
mov [esp+5Ch+var_5C], eax
call sub_4067D0
mov ecx, [esp+5Ch+var_38]
test eax, eax
mov [esp+5Ch+var_14], eax
jz loc_406B5C
mov edx, [esp+5Ch+var_14]
add eax, 14h
lea edx, [edx+edi*4+14h]
mov [esp+5Ch+var_10], edx
mov edx, eax
mov edi, [esp+5Ch+var_10]
cmp eax, [esp+5Ch+var_10]
jnb short loc_406A8D
nop
loc_406A80:
mov dword ptr [edx], 0
add edx, 4
cmp edi, edx
ja short loc_406A80
loc_406A8D:
lea edi, [esi+14h]
mov [esp+5Ch+var_18], edi
lea edi, [ecx+14h]
lea ecx, [ecx+ebx*4+14h]
lea esi, [esi+ebp*4+14h]
cmp edi, ecx
mov [esp+5Ch+var_28], esi
mov [esp+5Ch+var_2C], edi
mov [esp+5Ch+var_20], ecx
mov [esp+5Ch+var_24], eax
jnb short loc_406B1B
loc_406AB3:
mov edi, [esp+5Ch+var_2C]
mov ebp, [edi]
add edi, 4
mov [esp+5Ch+var_2C], edi
test ebp, ebp
jz short loc_406B0C
mov ecx, [esp+5Ch+var_24]
xor esi, esi
xor edi, edi
mov ebx, [esp+5Ch+var_18]
loc_406AD0:
mov eax, [ebx]
mul ebp
mov [esp+5Ch+var_44], eax
mov eax, [ecx]
mov [esp+5Ch+var_40], edx
xor edx, edx
add [esp+5Ch+var_44], eax
adc [esp+5Ch+var_40], edx
add [esp+5Ch+var_44], esi
adc [esp+5Ch+var_40], edi
add ebx, 4
mov edi, [esp+5Ch+var_40]
mov edx, [esp+5Ch+var_44]
mov esi, edi
xor edi, edi
mov [ecx], edx
add ecx, 4
cmp [esp+5Ch+var_28], ebx
ja short loc_406AD0
mov [ecx], esi
loc_406B0C:
mov edi, [esp+5Ch+var_2C]
add [esp+5Ch+var_24], 4
cmp [esp+5Ch+var_20], edi
ja short loc_406AB3
loc_406B1B:
mov eax, [esp+5Ch+var_1C]
test eax, eax
jle short loc_406B51
mov edi, [esp+5Ch+var_10]
mov ebx, [edi-4]
test ebx, ebx
jnz short loc_406B51
mov eax, [esp+5Ch+var_1C]
mov edx, [esp+5Ch+var_1C]
neg eax
lea eax, [edi+eax*4]
jmp short loc_406B48
align 10h
loc_406B40:
mov ecx, [eax+edx*4-4]
test ecx, ecx
jnz short loc_406B4D
loc_406B48:
sub edx, 1
jnz short loc_406B40
loc_406B4D:
mov [esp+5Ch+var_1C], edx
loc_406B51:
mov edi, [esp+5Ch+var_1C]
mov eax, [esp+5Ch+var_14]
mov [eax+10h], edi
loc_406B5C:
mov eax, [esp+5Ch+var_14]
add esp, 5Ch
pop ebx
pop esi
pop edi
pop ebp
retn
sub_406A10 endp
