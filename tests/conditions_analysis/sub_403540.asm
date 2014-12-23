sub_403540 proc near
var_38= dword ptr -38h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
arg_0= dword ptr  8
push ebp
sub ecx, 1
push edi
mov ebp, eax
push esi
mov eax, ecx
push ebx
mov ebx, 66666667h
sub esp, 2Ch
mov esi, 1
sar eax, 1Fh
mov edi, [esp+38h+arg_0]
mov [esp+38h+var_1C], eax
mov eax, ecx
mov [esp+38h+var_24], edx
imul ebx
mov [esp+38h+var_20], ecx
sar ecx, 1Fh
sar edx, 2
mov ebx, edx
sub ebx, ecx
jz short loc_403593
mov ecx, 66666667h
loc_403580:
mov eax, ebx
add esi, 1
imul ecx
sar ebx, 1Fh
sar edx, 2
sub edx, ebx
mov ebx, edx
jnz short loc_403580
loc_403593:
mov eax, [edi+28h]
mov edx, [edi+8]
cmp esi, eax
cmovl esi, eax
lea eax, [esi+2]
cmp edx, eax
jg short loc_403600
mov dword ptr [edi+8], 0FFFFFFFFh
loc_4035AC:
mov edx, [esp+38h+var_24]
mov ecx, 1
mov eax, ebp
mov [esp+38h+var_38], edi
add esi, 1
call sub_403220
mov eax, [edi+28h]
mov [edi+0Ch], eax
mov eax, [edi+4]
mov edx, eax
and eax, 20h
or edx, 1C0h
or eax, 45h
mov [edi+4], edx
mov edx, edi
call sub_4028D0
mov eax, [esp+38h+var_20]
mov ecx, edi
add [edi+8], esi
mov edx, [esp+38h+var_1C]
call sub_402B70
add esp, 2Ch
pop ebx
pop esi
pop edi
pop ebp
retn
align 10h
loc_403600:
sub edx, eax
mov [edi+8], edx
jmp short loc_4035AC
sub_403540 endp
