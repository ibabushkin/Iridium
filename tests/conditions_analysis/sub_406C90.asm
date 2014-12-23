sub_406C90 proc near
var_3C= dword ptr -3Ch
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
mov ebp, [esp+3Ch+arg_0]
mov esi, [esp+3Ch+arg_4]
mov eax, [ebp+10h]
mov ebx, esi
mov edx, [ebp+4]
sar ebx, 5
add eax, ebx
mov edi, eax
mov [esp+3Ch+var_14], eax
mov eax, [ebp+8]
add edi, 1
cmp edi, eax
jle short loc_406CC9
lea esi, [esi+0]
loc_406CC0:
add eax, eax
add edx, 1
cmp edi, eax
jg short loc_406CC0
loc_406CC9:
mov [esp+3Ch+var_3C], edx
call sub_4067D0
test eax, eax
mov [esp+3Ch+var_20], eax
jz loc_406D67
add eax, 14h
test ebx, ebx
jle short loc_406CFC
xor edx, edx
loc_406CE6:
mov dword ptr [eax+edx*4], 0
add edx, 1
cmp edx, ebx
jnz short loc_406CE6
mov ecx, [esp+3Ch+var_20]
lea eax, [ecx+edx*4+14h]
loc_406CFC:
mov ecx, [ebp+10h]
and esi, 1Fh
lea edx, [ebp+14h]
mov [esp+3Ch+var_1C], esi
lea ebx, [ebp+ecx*4+14h]
jz short loc_406D73
mov [esp+3Ch+var_18], 20h
mov [esp+3Ch+var_10], ebp
mov ebp, ebx
sub [esp+3Ch+var_18], esi
xor esi, esi
loc_406D23:
mov ebx, [edx]
movzx ecx, byte ptr [esp+3Ch+var_1C]
shl ebx, cl
movzx ecx, byte ptr [esp+3Ch+var_18]
or ebx, esi
mov [eax], ebx
mov esi, [edx]
add edx, 4
add eax, 4
shr esi, cl
cmp ebp, edx
ja short loc_406D23
mov [eax], esi
mov eax, [esp+3Ch+var_14]
mov ebp, [esp+3Ch+var_10]
add eax, 2
test esi, esi
cmovnz edi, eax
loc_406D55:
mov eax, [esp+3Ch+var_20]
sub edi, 1
mov [eax+10h], edi
mov [esp+3Ch+var_3C], ebp
call sub_406890
loc_406D67:
mov eax, [esp+3Ch+var_20]
add esp, 3Ch
pop ebx
pop esi
pop edi
pop ebp
retn
loc_406D73:
mov ecx, [edx]
add edx, 4
mov [eax], ecx
add eax, 4
cmp ebx, edx
jbe short loc_406D55
mov ecx, [edx]
add edx, 4
mov [eax], ecx
add eax, 4
cmp ebx, edx
ja short loc_406D73
jmp short loc_406D55
sub_406C90 endp
