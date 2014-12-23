sub_402B70 proc near
var_48= dword ptr -48h
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
var_C= dword ptr -0Ch
push ebp
mov ebp, esp
push edi
mov edi, ecx
push esi
xor esi, esi
push ebx
sub esp, 3Ch
mov ebx, [ecx+4]
mov [ebp+var_30], eax
mov [ebp+var_28], eax
mov eax, [ecx+0Ch]
mov [ebp+var_2C], edx
mov [ebp+var_24], edx
test eax, eax
cmovns esi, eax
add esi, 17h
test bh, 10h
mov [ebp+var_1C], eax
jz short loc_402BAA
cmp word ptr [ecx+1Ch], 0
jnz loc_402D90
loc_402BAA:
mov eax, [edi+8]
cmp esi, eax
cmovge eax, esi
add eax, 0Fh
and eax, 0FFFFFFF0h
call sub_4026E0
sub esp, eax
test bl, 80h
lea edx, [esp+48h+var_38]
mov [ebp+var_20], edx
jz short loc_402BDC
mov eax, [ebp+var_2C]
test eax, eax
js loc_402DF8
and bl, 7Fh
mov [edi+4], ebx
loc_402BDC:
mov ecx, [ebp+var_24]
mov esi, [ebp+var_28]
mov ebx, [ebp+var_20]
mov edx, ecx
or edx, esi
jz loc_402C9B
mov [ebp+var_1C], edi
mov edi, ecx
loc_402BF4:
mov [esp+48h+var_48], esi
mov [esp+48h+var_44], edi
mov [esp+48h+var_40], 0Ah
mov [esp+48h+var_3C], 0
call sub_407500
lea ecx, [ebx+1]
add eax, 30h
mov [ebx], al
mov [esp+48h+var_48], esi
mov [esp+48h+var_44], edi
mov [esp+48h+var_40], 0Ah
mov [esp+48h+var_3C], 0
mov [ebp+var_34], ecx
call sub_407640
mov ecx, [ebp+var_34]
mov esi, eax
mov edi, edx
or edx, esi
jz short loc_402C90
cmp [ebp+var_20], ecx
jz loc_402D72
mov eax, [ebp+var_1C]
test byte ptr [eax+5], 10h
jz short loc_402C74
cmp word ptr [eax+1Ch], 0
jz short loc_402C74
mov eax, ecx
sub eax, [ebp+var_20]
mov edx, eax
sar edx, 1Fh
shr edx, 1Eh
add eax, edx
and eax, 3
sub eax, edx
cmp eax, 3
jz short loc_402C80
loc_402C74:
mov ebx, ecx
jmp loc_402BF4
align 10h
loc_402C80:
lea ecx, [ebx+2]
mov byte ptr [ebx+1], 2Ch
mov ebx, ecx
jmp loc_402BF4
align 10h
loc_402C90:
mov edi, [ebp+var_1C]
mov ebx, ecx
mov eax, [edi+0Ch]
mov [ebp+var_1C], eax
loc_402C9B:
mov esi, [ebp+var_1C]
test esi, esi
jle short loc_402CBA
mov eax, [ebp+var_20]
sub eax, ebx
add eax, [ebp+var_1C]
test eax, eax
jle short loc_402CBA
add eax, ebx
loc_402CB0:
mov byte ptr [ebx], 30h
add ebx, 1
cmp ebx, eax
jnz short loc_402CB0
loc_402CBA:
cmp ebx, [ebp+var_20]
jz loc_402E10
loc_402CC3:
mov eax, [edi+8]
test eax, eax
jle short loc_402D1E
mov edx, [ebp+var_20]
sub edx, ebx
add edx, eax
mov eax, [edi+4]
test edx, edx
mov [edi+8], edx
jle short loc_402D21
test eax, 1C0h
jz short loc_402CE8
sub edx, 1
mov [edi+8], edx
loc_402CE8:
mov edx, [edi+0Ch]
test edx, edx
js loc_402DB6
loc_402CF3:
test ah, 4
jnz short loc_402D21
mov edx, [edi+8]
lea esi, [edx-1]
test edx, edx
mov [edi+8], esi
jle short loc_402D21
loc_402D05:
mov edx, edi
mov eax, 20h
call sub_4028D0
mov eax, [edi+8]
lea edx, [eax-1]
test eax, eax
mov [edi+8], edx
jg short loc_402D05
loc_402D1E:
mov eax, [edi+4]
loc_402D21:
test al, 80h
jz short loc_402D80
mov byte ptr [ebx], 2Dh
add ebx, 1
loc_402D2B:
cmp [ebp+var_20], ebx
mov esi, [ebp+var_20]
jnb short loc_402D5D
loc_402D33:
sub ebx, 1
mov edx, edi
movsx eax, byte ptr [ebx]
call sub_4028D0
cmp ebx, esi
jnz short loc_402D33
mov eax, [edi+8]
lea edx, [eax-1]
test eax, eax
mov [edi+8], edx
jle short loc_402D6A
loc_402D51:
mov edx, edi
mov eax, 20h
call sub_4028D0
loc_402D5D:
mov eax, [edi+8]
lea edx, [eax-1]
test eax, eax
mov [edi+8], edx
jg short loc_402D51
loc_402D6A:
lea esp, [ebp-0Ch]
pop ebx
pop esi
pop edi
pop ebp
retn
loc_402D72:
mov ecx, [ebp+var_20]
mov ebx, ecx
jmp loc_402BF4
align 10h
loc_402D80:
test ah, 1
jz short loc_402DA7
mov byte ptr [ebx], 2Bh
add ebx, 1
jmp short loc_402D2B
align 10h
loc_402D90:
mov eax, esi
mov edx, 55555556h
imul edx
mov eax, esi
sar eax, 1Fh
sub edx, eax
add esi, edx
jmp loc_402BAA
loc_402DA7:
test al, 40h
jz short loc_402D2B
mov byte ptr [ebx], 20h
add ebx, 1
jmp loc_402D2B
loc_402DB6:
mov edx, eax
and edx, 600h
cmp edx, 200h
jnz loc_402CF3
mov edx, [edi+8]
lea esi, [edx-1]
test edx, edx
mov [edi+8], esi
jle loc_402D21
nop
lea esi, [esi+0]
loc_402DE0:
mov byte ptr [ebx], 30h
mov eax, [edi+8]
add ebx, 1
lea edx, [eax-1]
test eax, eax
mov [edi+8], edx
jg short loc_402DE0
jmp loc_402D1E
loc_402DF8:
mov eax, [ebp+var_30]
mov edx, [ebp+var_2C]
neg eax
adc edx, 0
neg edx
mov [ebp+var_28], eax
mov [ebp+var_24], edx
jmp loc_402BDC
loc_402E10:
mov ecx, [edi+0Ch]
test ecx, ecx
jz loc_402CC3
mov byte ptr [ebx], 30h
add ebx, 1
jmp loc_402CC3
sub_402B70 endp
