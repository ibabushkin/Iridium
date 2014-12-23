sub_406FA0 proc near
var_24= qword ptr -24h
var_18= dword ptr -18h
var_10= dword ptr -10h
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
arg_0= dword ptr  4
arg_4= dword ptr  8
sub esp, 24h
mov eax, [esp+24h+arg_0]
mov [esp+24h+var_C], esi
mov ecx, [esp+24h+arg_4]
mov [esp+24h+var_8], edi
mov [esp+24h+var_10], ebx
lea edx, [eax+14h]
mov [esp+24h+var_18], edx
mov edx, [eax+10h]
mov [esp+24h+var_4], ebp
lea esi, [eax+edx*4+10h]
mov edx, 20h
lea edi, [esi+4]
mov ebx, [edi-4]
bsr eax, ebx
xor eax, 1Fh
sub edx, eax
cmp eax, 0Ah
mov [ecx], edx
jg short loc_407030
mov ecx, 0Bh
mov edx, ebx
sub ecx, eax
shr edx, cl
or edx, 3FF00000h
mov dword ptr [esp+24h+var_24+4], edx
xor edx, edx
cmp [esp+24h+var_18], esi
mov dword ptr [esp+24h+var_24], 0
jnb short loc_40700C
mov edx, [edi-8]
shr edx, cl
loc_40700C:
lea ecx, [eax+15h]
shl ebx, cl
or edx, ebx
mov dword ptr [esp+24h+var_24], edx
loc_407016:
fld [esp+24h+var_24]
mov ebx, [esp+24h+var_10]
mov esi, [esp+24h+var_C]
mov edi, [esp+24h+var_8]
mov ebp, [esp+24h+var_4]
add esp, 24h
retn
align 10h
loc_407030:
xor edx, edx
mov ebp, esi
cmp [esp+24h+var_18], esi
jnb short loc_407040
mov edx, [edi-8]
sub ebp, 4
loc_407040:
mov edi, eax
sub edi, 0Bh
jz short loc_407083
mov esi, 2Bh
mov ecx, edi
sub esi, eax
mov eax, edx
shl ebx, cl
mov ecx, esi
shr eax, cl
or ebx, 3FF00000h
or ebx, eax
xor eax, eax
cmp ebp, [esp+24h+var_18]
mov dword ptr [esp+24h+var_24], 0
mov dword ptr [esp+24h+var_24+4], ebx
jbe short loc_407078
mov eax, [ebp-4]
shr eax, cl
loc_407078:
mov ecx, edi
shl edx, cl
or eax, edx
mov dword ptr [esp+24h+var_24], eax
jmp short loc_407016
loc_407083:
or ebx, 3FF00000h
mov dword ptr [esp+24h+var_24+4], ebx
mov dword ptr [esp+24h+var_24], edx
jmp short loc_407016
sub_406FA0 endp
