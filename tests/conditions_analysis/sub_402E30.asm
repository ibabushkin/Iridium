sub_402E30 proc near
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
var_C= dword ptr -0Ch
arg_0= dword ptr  8
push ebp
mov ebp, esp
push edi
mov edi, ecx
push esi
mov esi, edx
push ebx
sub esp, 2Ch
cmp eax, 6Fh
mov [ebp+var_28], eax
mov eax, 18h
mov [ebp+var_34], ecx
mov ecx, 12h
cmovz ecx, eax
setnz al
movzx ebx, al
movzx eax, al
add eax, 3
mov [ebp+var_1C], eax
mov eax, [ebp+arg_0]
lea ebx, ds:7[ebx*8]
mov [ebp+var_20], edx
mov eax, [eax+0Ch]
mov [ebp+var_2C], eax
mov edx, [ebp+var_2C]
xor eax, eax
test edx, edx
mov edx, [ebp+arg_0]
cmovns eax, [ebp+var_2C]
mov edx, [edx+4]
add ecx, eax
mov [ebp+var_38], edx
and dh, 10h
jz short loc_402E9E
mov eax, [ebp+arg_0]
cmp word ptr [eax+1Ch], 0
jnz loc_4030C0
loc_402E9E:
mov edx, [ebp+arg_0]
mov edx, [edx+8]
cmp ecx, edx
cmovl ecx, edx
lea eax, [ecx+0Fh]
and eax, 0FFFFFFF0h
mov [ebp+var_30], edx
call sub_4026E0
sub esp, eax
mov eax, [ebp+var_34]
or eax, [ebp+var_20]
mov [ebp+var_24], esp
jz loc_403120
mov eax, [ebp+var_28]
mov edx, ebx
mov ebx, esp
mov ecx, [ebp+var_1C]
mov byte ptr [ebp+var_1C], dl
and eax, 20h
mov [ebp+var_20], eax
jmp short loc_402EF9
align 10h
loc_402EE0:
mov [ebx-1], dl
loc_402EE3:
shrd esi, edi, cl
xor eax, eax
shr edi, cl
test cl, 20h
cmovnz esi, edi
cmovnz edi, eax
mov edx, edi
or edx, esi
jz short loc_402F15
loc_402EF9:
movzx eax, byte ptr [ebp+var_1C]
add ebx, 1
and eax, esi
lea edx, [eax+30h]
cmp dl, 39h
jle short loc_402EE0
add eax, 37h
or al, byte ptr [ebp+var_20]
mov [ebx-1], al
jmp short loc_402EE3
loc_402F15:
cmp [ebp+var_24], ebx
jz loc_403120
loc_402F1E:
mov eax, [ebp+var_2C]
test eax, eax
jle loc_4030D7
mov eax, [ebp+var_24]
sub eax, ebx
add eax, [ebp+var_2C]
test eax, eax
jle loc_4030D7
add eax, ebx
nop
lea esi, [esi+0]
loc_402F40:
mov byte ptr [ebx], 30h
add ebx, 1
cmp ebx, eax
jnz short loc_402F40
loc_402F4A:
cmp ebx, [ebp+var_24]
jz loc_403100
loc_402F53:
mov eax, ebx
sub eax, [ebp+var_24]
cmp [ebp+var_30], eax
jle loc_403003
mov edi, [ebp+var_30]
sub edi, eax
mov eax, [ebp+arg_0]
test edi, edi
mov [eax+8], edi
jle short loc_402F91
cmp [ebp+var_28], 6Fh
jz short loc_402F83
mov eax, [ebp+arg_0]
test byte ptr [eax+5], 8
jnz loc_403072
loc_402F83:
mov edx, [ebp+arg_0]
mov eax, [edx+0Ch]
test eax, eax
js loc_403089
loc_402F91:
lea esi, [edi-1]
loc_402F94:
cmp [ebp+var_28], 6Fh
jz short loc_402FA7
mov eax, [ebp+arg_0]
test byte ptr [eax+5], 8
jnz loc_403060
loc_402FA7:
test edi, edi
jle short loc_402FB4
mov eax, [ebp+arg_0]
test byte ptr [eax+5], 4
jz short loc_403020
loc_402FB4:
cmp ebx, [ebp+var_24]
jbe short loc_402FDE
mov [ebp+var_1C], edi
mov edi, [ebp+var_24]
mov [ebp+var_24], esi
mov esi, ebx
mov ebx, [ebp+arg_0]
loc_402FC7:
sub esi, 1
mov edx, ebx
movsx eax, byte ptr [esi]
call sub_4028D0
cmp esi, edi
jnz short loc_402FC7
mov edi, [ebp+var_1C]
mov esi, [ebp+var_24]
loc_402FDE:
test edi, edi
mov ebx, [ebp+arg_0]
jle short loc_402FFB
loc_402FE5:
mov eax, 20h
sub esi, 1
mov edx, ebx
call sub_4028D0
lea eax, [esi+1]
test eax, eax
jg short loc_402FE5
loc_402FFB:
lea esp, [ebp-0Ch]
pop ebx
pop esi
pop edi
pop ebp
retn
loc_403003:
mov edx, [ebp+arg_0]
mov esi, 0FFFFFFFEh
mov edi, 0FFFFFFFFh
mov dword ptr [edx+8], 0FFFFFFFFh
jmp loc_402F94
align 10h
loc_403020:
mov edi, [ebp+arg_0]
mov [ebp+var_1C], ebx
mov ebx, esi
loc_403028:
mov eax, 20h
sub ebx, 1
mov edx, edi
call sub_4028D0
lea eax, [ebx+1]
test eax, eax
jg short loc_403028
xor eax, eax
test esi, esi
mov ebx, [ebp+var_1C]
lea edi, [esi-1]
cmovns eax, esi
sub edi, eax
lea esi, [edi-1]
jmp loc_402FB4
loc_403055:
lea esi, [edi-3]
mov edi, eax
lea esi, [esi+0]
loc_403060:
movzx edx, byte ptr [ebp+var_28]
mov byte ptr [ebx+1], 30h
mov [ebx], dl
add ebx, 2
jmp loc_402FA7
loc_403072:
lea eax, [edi-2]
test eax, eax
jle short loc_403055
mov edx, [ebp+arg_0]
mov edi, eax
mov eax, [edx+0Ch]
test eax, eax
jns loc_402F91
loc_403089:
mov edx, [ebp+arg_0]
mov eax, [edx+4]
and eax, 600h
cmp eax, 200h
jnz loc_402F91
lea eax, [ebx+edi]
loc_4030A2:
mov byte ptr [ebx], 30h
add ebx, 1
cmp ebx, eax
jnz short loc_4030A2
mov esi, 0FFFFFFFEh
mov edi, 0FFFFFFFFh
jmp loc_402F94
align 10h
loc_4030C0:
mov eax, ecx
mov edx, 55555556h
imul edx
mov eax, ecx
sar eax, 1Fh
sub edx, eax
add ecx, edx
jmp loc_402E9E
loc_4030D7:
cmp [ebp+var_28], 6Fh
jnz loc_402F4A
mov eax, [ebp+arg_0]
test byte ptr [eax+5], 8
jz loc_402F4A
mov byte ptr [ebx], 30h
add ebx, 1
jmp loc_402F4A
align 10h
loc_403100:
mov edx, [ebp+arg_0]
mov eax, [edx+0Ch]
test eax, eax
jz loc_402F53
mov byte ptr [ebx], 30h
add ebx, 1
jmp loc_402F53
align 10h
loc_403120:
mov eax, [ebp+var_38]
mov edx, [ebp+arg_0]
mov ebx, [ebp+var_24]
and ah, 0F7h
mov [edx+4], eax
jmp loc_402F1E
sub_402E30 endp
