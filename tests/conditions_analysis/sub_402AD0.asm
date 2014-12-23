sub_402AD0 proc near
var_20= dword ptr -20h
var_10= dword ptr -10h
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
sub esp, 2Ch
test eax, eax
mov [esp+2Ch+var_10], ebx
mov [esp+2Ch+var_C], esi
mov [esp+2Ch+var_8], edi
mov [esp+2Ch+var_4], ebp
mov dword ptr [ecx+0Ch], 0FFFFFFFFh
jz short loc_402B35
mov ebp, [ecx+4]
lea edi, [esp+2Ch+var_20+1]
mov byte ptr [esp+2Ch+var_20], 2Dh
lea eax, [esp+2Ch+var_20]
loc_402AFE:
and ebp, 20h
xor esi, esi
loc_402B03:
movzx ebx, byte ptr [edx+esi]
and ebx, 0FFFFFFDFh
or ebx, ebp
mov [edi+esi], bl
add esi, 1
cmp esi, 3
jnz short loc_402B03
lea edx, [edi+3]
sub edx, eax
call sub_402A30
mov ebx, [esp+2Ch+var_10]
mov esi, [esp+2Ch+var_C]
mov edi, [esp+2Ch+var_8]
mov ebp, [esp+2Ch+var_4]
add esp, 2Ch
retn
loc_402B35:
mov ebp, [ecx+4]
test ebp, 100h
jz short loc_402B50
mov byte ptr [esp+2Ch+var_20], 2Bh
lea edi, [esp+2Ch+var_20+1]
lea eax, [esp+2Ch+var_20]
jmp short loc_402AFE
align 10h
loc_402B50:
test ebp, 40h
jz short loc_402B67
mov byte ptr [esp+2Ch+var_20], 20h
lea edi, [esp+2Ch+var_20+1]
lea eax, [esp+2Ch+var_20]
jmp short loc_402AFE
loc_402B67:
lea eax, [esp+2Ch+var_20]
mov edi, eax
jmp short loc_402AFE
sub_402AD0 endp
