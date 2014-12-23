sub_4063B0 proc near
var_68= dword ptr -68h
var_64= dword ptr -64h
var_50= dword ptr -50h
var_4C= dword ptr -4Ch
var_44= dword ptr -44h
var_40= dword ptr -40h
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
arg_0= dword ptr  8
arg_4= dword ptr  0Ch
push ebp
xor eax, eax
push edi
push esi
push ebx
sub esp, 5Ch
mov ecx, [esp+68h+arg_4]
mov ebx, [esp+68h+arg_0]
mov edx, [ecx+10h]
cmp edx, [ebx+10h]
jg loc_4065C3
add ebx, 14h
mov ebp, ecx
mov [esp+68h+var_24], ebx
mov ebx, [esp+68h+arg_4]
lea esi, [edx-1]
mov [esp+68h+var_28], esi
mov esi, [esp+68h+arg_0]
add edx, 3
lea ecx, [ecx+edx*4+4]
add ebp, 14h
mov [esp+68h+var_30], ecx
mov ebx, [ebx+edx*4+4]
mov eax, [esi+edx*4+4]
xor edx, edx
mov ecx, ebx
add ecx, 1
div ecx
test eax, eax
mov [esp+68h+var_2C], eax
mov [esp+68h+var_20], eax
jz loc_4064FF
mov eax, [esp+68h+var_24]
xor esi, esi
xor edi, edi
mov [esp+68h+var_44], ebp
mov ecx, esi
mov ebx, edi
mov [esp+68h+var_1C], ebp
mov [esp+68h+var_40], 0
mov [esp+68h+var_3C], 0
mov ebp, eax
lea esi, [esi+0]
loc_406440:
mov esi, [esp+68h+var_44]
mov eax, [esp+68h+var_2C]
mov [esp+68h+var_34], 0
mul dword ptr [esi]
mov [esp+68h+var_50], eax
add [esp+68h+var_50], ecx
mov eax, [esp+68h+var_50]
mov [esp+68h+var_4C], edx
adc [esp+68h+var_4C], ebx
add esi, 4
mov ebx, [esp+68h+var_4C]
xor edi, edi
mov [esp+68h+var_44], esi
mov esi, [ebp+0]
mov [esp+68h+var_38], eax
mov ecx, ebx
xor ebx, ebx
sub esi, [esp+68h+var_38]
sbb edi, [esp+68h+var_34]
sub esi, [esp+68h+var_40]
sbb edi, [esp+68h+var_3C]
mov [esp+68h+var_3C], 0
mov [ebp+0], esi
mov esi, [esp+68h+var_44]
add ebp, 4
mov eax, edi
and eax, 1
cmp [esp+68h+var_30], esi
mov [esp+68h+var_40], eax
jnb short loc_406440
mov eax, [esp+68h+var_28]
mov ecx, [esp+68h+arg_0]
mov ebp, [esp+68h+var_1C]
add eax, 4
mov edi, [ecx+eax*4+4]
test edi, edi
jnz short loc_4064FF
lea eax, [ecx+eax*4]
cmp [esp+68h+var_24], eax
jnb short loc_4064F4
mov esi, [eax]
test esi, esi
jnz short loc_4064F4
mov ecx, [esp+68h+var_24]
mov edx, [esp+68h+var_28]
jmp short loc_4064E6
align 10h
loc_4064E0:
mov ebx, [eax]
test ebx, ebx
jnz short loc_4064F0
loc_4064E6:
sub eax, 4
sub edx, 1
cmp ecx, eax
jb short loc_4064E0
loc_4064F0:
mov [esp+68h+var_28], edx
loc_4064F4:
mov esi, [esp+68h+var_28]
mov ebx, [esp+68h+arg_0]
mov [ebx+10h], esi
loc_4064FF:
mov ecx, [esp+68h+arg_4]
mov ebx, [esp+68h+arg_0]
mov [esp+68h+var_64], ecx
mov [esp+68h+var_68], ebx
call sub_406DA0
test eax, eax
js loc_4065BF
mov esi, [esp+68h+var_2C]
xor ebx, ebx
mov ecx, [esp+68h+var_24]
mov [esp+68h+var_40], ebp
add esi, 1
mov [esp+68h+var_44], ecx
xor ecx, ecx
mov [esp+68h+var_20], esi
loc_406536:
mov eax, [esp+68h+var_40]
xor edi, edi
xor edx, edx
mov ebp, [esp+68h+var_44]
mov esi, [eax]
add eax, 4
mov [esp+68h+var_40], eax
mov eax, [ebp+0]
sub eax, esi
sbb edx, edi
sub eax, ecx
sbb edx, ebx
xor ebx, ebx
mov [ebp+0], eax
mov ecx, edx
mov eax, [esp+68h+var_40]
add ebp, 4
and ecx, 1
cmp [esp+68h+var_30], eax
mov [esp+68h+var_44], ebp
jnb short loc_406536
mov eax, [esp+68h+var_28]
mov ecx, [esp+68h+arg_0]
add eax, 4
mov edi, [ecx+eax*4+4]
test edi, edi
jnz short loc_4065BF
lea eax, [ecx+eax*4]
cmp [esp+68h+var_24], eax
jnb short loc_4065B4
mov esi, [eax]
test esi, esi
jnz short loc_4065B4
mov ecx, [esp+68h+var_24]
mov edx, [esp+68h+var_28]
jmp short loc_4065A6
align 10h
loc_4065A0:
mov ebx, [eax]
test ebx, ebx
jnz short loc_4065B0
loc_4065A6:
sub eax, 4
sub edx, 1
cmp ecx, eax
jb short loc_4065A0
loc_4065B0:
mov [esp+68h+var_28], edx
loc_4065B4:
mov esi, [esp+68h+var_28]
mov ebx, [esp+68h+arg_0]
mov [ebx+10h], esi
loc_4065BF:
mov eax, [esp+68h+var_20]
loc_4065C3:
add esp, 5Ch
pop ebx
pop esi
pop edi
pop ebp
retn
sub_4063B0 endp
