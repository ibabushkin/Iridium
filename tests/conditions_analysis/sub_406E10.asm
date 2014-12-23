sub_406E10 proc near
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
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
sub esp, 3Ch
mov edi, [esp+3Ch+arg_0]
mov ebx, [esp+3Ch+arg_4]
mov [esp+3Ch+var_3C], edi
mov [esp+3Ch+var_38], ebx
call sub_406DA0
cmp eax, 0
jz loc_406F45
jl loc_406F77
xor esi, esi
loc_406E3C:
mov eax, [edi+4]
mov [esp+3Ch+var_3C], eax
call sub_4067D0
test eax, eax
mov [esp+3Ch+var_18], eax
jz loc_406F87
mov ebp, [edi+10h]
lea edx, [ebx+14h]
xor ecx, ecx
mov [eax+0Ch], esi
lea esi, [edi+14h]
mov eax, [ebx+10h]
mov [esp+3Ch+var_24], esi
lea edi, [edi+ebp*4+14h]
mov [esp+3Ch+var_14], edi
mov edi, [esp+3Ch+var_18]
lea eax, [ebx+eax*4+14h]
mov [esp+3Ch+var_10], ebp
xor ebx, ebx
mov ebp, edx
mov [esp+3Ch+var_1C], eax
add edi, 14h
mov [esp+3Ch+var_20], edi
nop
lea esi, [esi+0]
loc_406E90:
mov esi, [esp+3Ch+var_24]
xor edx, edx
xor edi, edi
mov eax, [esi]
mov esi, [ebp+0]
sub eax, esi
mov esi, [esp+3Ch+var_20]
sbb edx, edi
sub eax, ecx
sbb edx, ebx
add ebp, 4
mov ecx, edx
xor ebx, ebx
add [esp+3Ch+var_24], 4
and ecx, 1
mov edx, eax
mov [esi], eax
add esi, 4
cmp [esp+3Ch+var_1C], ebp
mov [esp+3Ch+var_20], esi
ja short loc_406E90
mov esi, [esp+3Ch+var_24]
cmp [esp+3Ch+var_14], esi
mov edi, [esp+3Ch+var_20]
mov ebp, [esp+3Ch+var_10]
jbe short loc_406F1C
mov [esp+3Ch+var_1C], ebp
mov ebp, [esp+3Ch+var_14]
loc_406EE3:
mov eax, [esi]
xor edx, edx
sub eax, ecx
sbb edx, ebx
add esi, 4
mov ecx, edx
xor ebx, ebx
and ecx, 1
mov edx, eax
mov [edi], eax
add edi, 4
cmp ebp, esi
ja short loc_406EE3
mov ebx, [esp+3Ch+var_24]
mov ecx, [esp+3Ch+var_14]
mov esi, [esp+3Ch+var_20]
mov ebp, [esp+3Ch+var_1C]
not ebx
lea eax, [ebx+ecx]
shr eax, 2
lea edi, [esi+eax*4+4]
loc_406F1C:
test edx, edx
jnz short loc_406F32
mov eax, ebp
neg eax
lea eax, [edi+eax*4]
loc_406F27:
sub ebp, 1
mov edx, [eax+ebp*4-4]
test edx, edx
jz short loc_406F27
loc_406F32:
mov eax, [esp+3Ch+var_18]
mov [eax+10h], ebp
loc_406F39:
mov eax, [esp+3Ch+var_18]
add esp, 3Ch
pop ebx
pop esi
pop edi
pop ebp
retn
loc_406F45:
mov [esp+3Ch+var_3C], 0
call sub_4067D0
test eax, eax
mov [esp+3Ch+var_18], eax
jz short loc_406F87
mov eax, [esp+3Ch+var_18]
mov dword ptr [eax+10h], 1
mov dword ptr [eax+14h], 0
mov eax, [esp+3Ch+var_18]
add esp, 3Ch
pop ebx
pop esi
pop edi
pop ebp
retn
loc_406F77:
mov eax, edi
mov esi, 1
mov edi, ebx
mov ebx, eax
jmp loc_406E3C
loc_406F87:
mov [esp+3Ch+var_18], 0
jmp short loc_406F39
sub_406E10 endp
