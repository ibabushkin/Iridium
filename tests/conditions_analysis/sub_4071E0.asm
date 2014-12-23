sub_4071E0 proc near
var_14= dword ptr -14h
var_10= dword ptr -10h
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
arg_0= dword ptr  14h
arg_4= dword ptr  18h
push ebp
push edi
push esi
push ebx
sub esp, 14h
mov ebp, [esp+14h+arg_0]
mov ecx, [esp+14h+arg_4]
mov edx, [ebp+10h]
lea eax, [ebp+14h]
mov [esp+14h+var_10], eax
mov eax, ecx
sar eax, 5
cmp eax, edx
jge loc_407290
add eax, 4
and ecx, 1Fh
lea edi, [ebp+edx*4+14h]
lea edx, [ebp+eax*4+0]
lea ebx, [edx+4]
mov [esp+14h+var_C], ebx
mov [esp+14h+var_14], ecx
jz loc_4072A6
mov ecx, [esp+14h+var_14]
add edx, 8
mov ebx, [ebp+eax*4+4]
mov [esp+14h+var_8], 20h
sub [esp+14h+var_8], ecx
shr ebx, cl
cmp edi, edx
jbe loc_4072E3
mov [esp+14h+var_4], ebp
mov esi, [esp+14h+var_10]
mov ebp, [esp+14h+var_8]
loc_407250:
mov eax, [edx]
mov ecx, ebp
shl eax, cl
movzx ecx, byte ptr [esp+14h+var_14]
or eax, ebx
mov [esi], eax
mov ebx, [edx]
add edx, 4
add esi, 4
shr ebx, cl
cmp edi, edx
ja short loc_407250
sub edi, [esp+14h+var_C]
mov ebp, [esp+14h+var_4]
lea eax, [edi-5]
shr eax, 2
lea eax, [ebp+eax*4+18h]
loc_40727E:
test ebx, ebx
mov [eax], ebx
jz short loc_4072CD
add eax, 4
sub eax, [esp+14h+var_10]
sar eax, 2
jmp short loc_4072D4
loc_407290:
mov dword ptr [ebp+10h], 0
loc_407297:
mov dword ptr [ebp+14h], 0
add esp, 14h
pop ebx
pop esi
pop edi
pop ebp
retn
loc_4072A6:
cmp edi, ebx
mov edx, [esp+14h+var_10]
mov eax, ebx
jbe short loc_407290
loc_4072B0:
mov ecx, [eax]
add eax, 4
mov [edx], ecx
add edx, 4
cmp edi, eax
ja short loc_4072B0
mov eax, [esp+14h+var_C]
not eax
add eax, edi
shr eax, 2
lea eax, [ebp+eax*4+18h]
loc_4072CD:
sub eax, [esp+14h+var_10]
sar eax, 2
loc_4072D4:
test eax, eax
mov [ebp+10h], eax
jz short loc_407297
add esp, 14h
pop ebx
pop esi
pop edi
pop ebp
retn
loc_4072E3:
mov eax, [esp+14h+var_10]
jmp short loc_40727E
sub_4071E0 endp
