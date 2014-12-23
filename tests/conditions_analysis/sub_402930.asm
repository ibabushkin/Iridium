sub_402930 proc near
var_58= dword ptr -58h
var_54= dword ptr -54h
var_50= dword ptr -50h
var_40= dword ptr -40h
var_3C= dword ptr -3Ch
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
push ebp
mov ebp, edx
push edi
mov edi, eax
push esi
push ebx
mov ebx, ecx
sub esp, 4Ch
lea eax, [esp+58h+var_2C]
lea esi, [esp+58h+var_28]
mov [esp+58h+var_50], eax
mov [esp+58h+var_54], 0
mov [esp+58h+var_58], esi
call sub_405DF0
mov eax, [ebx+0Ch]
test eax, eax
js short loc_402965
cmp ebp, eax
cmovg ebp, eax
loc_402965:
mov eax, [ebx+8]
cmp ebp, eax
jge loc_4029F7
sub eax, ebp
test eax, eax
mov [ebx+8], eax
jle short loc_402983
test byte ptr [ebx+5], 4
jz loc_402A00
loc_402983:
test ebp, ebp
mov [esp+58h+var_3C], ebx
jle short loc_4029D0
loc_40298B:
movzx eax, word ptr [edi]
lea edx, [esp+58h+var_2C]
add edi, 2
mov [esp+58h+var_50], edx
mov [esp+58h+var_58], esi
mov [esp+58h+var_54], eax
call sub_405DF0
test eax, eax
jle short loc_4029D0
lea ecx, [esi+eax]
mov ebx, esi
loc_4029AE:
movsx eax, byte ptr [ebx]
add ebx, 1
mov edx, [esp+58h+var_3C]
mov [esp+58h+var_40], ecx
call sub_4028D0
mov ecx, [esp+58h+var_40]
cmp ebx, ecx
jnz short loc_4029AE
sub ebp, 1
test ebp, ebp
jg short loc_40298B
loc_4029D0:
mov ebx, [esp+58h+var_3C]
jmp short loc_4029E2
loc_4029D6:
mov edx, ebx
mov eax, 20h
call sub_4028D0
loc_4029E2:
mov eax, [ebx+8]
lea edx, [eax-1]
test eax, eax
mov [ebx+8], edx
jg short loc_4029D6
add esp, 4Ch
pop ebx
pop esi
pop edi
pop ebp
retn
loc_4029F7:
mov dword ptr [ebx+8], 0FFFFFFFFh
jmp short loc_402983
loc_402A00:
sub eax, 1
mov [ebx+8], eax
loc_402A06:
mov edx, ebx
mov eax, 20h
call sub_4028D0
mov eax, [ebx+8]
lea edx, [eax-1]
test eax, eax
mov [ebx+8], edx
jnz short loc_402A06
jmp loc_402983
sub_402930 endp
