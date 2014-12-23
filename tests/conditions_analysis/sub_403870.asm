sub_403870 proc near
var_60= dword ptr -60h
var_5C= dword ptr -5Ch
var_58= dword ptr -58h
var_50= dword ptr -50h
var_4C= dword ptr -4Ch
var_48= dword ptr -48h
var_44= dword ptr -44h
var_3A= dword ptr -3Ah
var_28= dword ptr -28h
arg_0= tbyte ptr  10h
push ebp
push edi
push esi
mov esi, eax
push ebx
sub esp, 5Ch
fld [esp+60h+arg_0]
fld st
fstp tbyte ptr [esp+60h+var_3A+2]
fxam
fstsw ax
and ax, 4500h
cmp ax, 100h
jz loc_403D0C
movzx edx, word ptr [esp+30h]
mov ebx, edx
and ebx, 8000h
jnz loc_403A42
loc_4038A9:
fxam
fstsw ax
fstp st
and ax, 4500h
cmp ax, 500h
jz loc_403D1E
and dx, 7FFFh
jz loc_403A50
mov edi, [esp+60h+var_3A+2]
sub dx, 3FFFh
mov ebp, [esp+2Ch]
loc_4038D6:
mov eax, [esi+0Ch]
cmp eax, 0Eh
ja loc_40397E
test ebp, ebp
js short loc_4038FE
mov ecx, edi
mov ebx, ebp
lea esi, [esi+0]
loc_4038F0:
shld ebx, ecx, 1
add ecx, ecx
test ebx, ebx
jns short loc_4038F0
mov edi, ecx
mov ebp, ebx
loc_4038FE:
mov ecx, edi
mov ebx, ebp
shrd ecx, ebp, 1
mov edi, 4
mov [esp+60h+var_60], ecx
mov ecx, 0Eh
xor ebp, ebp
shr ebx, 1
sub ecx, eax
mov [esp+60h+var_5C], ebx
lea ebx, ds:0[ecx*4]
mov ecx, ebx
xor ebx, ebx
shld ebp, edi, cl
shl edi, cl
test cl, 20h
cmovnz ebp, edi
cmovnz edi, ebx
add [esp+60h+var_60], edi
adc [esp+60h+var_5C], ebp
mov edi, [esp+60h+var_5C]
test edi, edi
js loc_403D04
mov edi, [esp+60h+var_60]
mov ebp, [esp+60h+var_5C]
shld ebp, edi, 1
add edi, edi
mov [esp+60h+var_60], edi
mov [esp+60h+var_5C], ebp
loc_40395D:
mov ebp, [esp+60h+var_5C]
mov ecx, 0Fh
xor ebx, ebx
mov edi, [esp+60h+var_60]
sub ecx, eax
shl ecx, 2
shrd edi, ebp, cl
shr ebp, cl
and ecx, 20h
cmovnz edi, ebp
cmovnz ebp, ebx
loc_40397E:
mov ecx, ebp
or ecx, edi
jz loc_403D2E
lea ecx, [esp+60h+var_28]
mov eax, edi
mov [esp+60h+var_58], ecx
mov ebx, ecx
mov ecx, [esi+4]
mov word ptr [esp+60h+var_44], dx
mov edx, ebp
mov [esp+60h+var_48], ecx
and ecx, 800h
mov [esp+60h+var_4C], ecx
mov ecx, [esp+60h+var_48]
and ecx, 20h
mov [esp+60h+var_50], ecx
jmp short loc_4039F8
align 10h
loc_4039C0:
mov edi, [esi+0Ch]
test edi, edi
jle short loc_4039CD
sub edi, 1
mov [esi+0Ch], edi
loc_4039CD:
shrd eax, edx, 4
shr edx, 4
loc_4039D4:
test ebp, ebp
jz short loc_403A30
loc_4039D8:
cmp ebp, 9
jle short loc_403A3D
movzx ecx, byte ptr [esp+60h+var_50]
add ebp, 37h
or ebp, ecx
loc_4039E7:
mov ecx, ebp
mov [ebx], cl
add ebx, 1
loc_4039EE:
mov edi, edx
or edi, eax
jz loc_403AC0
loc_4039F8:
mov ebp, eax
and ebp, 0Fh
cmp ebp, eax
jnz short loc_4039C0
cmp ebx, [esp+60h+var_58]
ja short loc_403A16
mov edi, [esp+60h+var_4C]
test edi, edi
jnz short loc_403A16
mov ecx, [esi+0Ch]
test ecx, ecx
jle short loc_403A1C
loc_403A16:
mov byte ptr [ebx], 2Eh
add ebx, 1
loc_403A1C:
cmp edx, 0
ja short loc_403A90
cmp eax, 1
ja short loc_403A90
xor eax, eax
xor edx, edx
test ebp, ebp
jnz short loc_4039D8
db 66h
nop
loc_403A30:
cmp ebx, [esp+60h+var_58]
ja short loc_403A3D
mov ecx, [esi+0Ch]
test ecx, ecx
js short loc_4039EE
loc_403A3D:
add ebp, 30h
jmp short loc_4039E7
loc_403A42:
or dword ptr [esi+4], 80h
jmp loc_4038A9
align 10h
loc_403A50:
mov ebp, [esp+2Ch]
xor edx, edx
mov edi, [esp+60h+var_3A+2]
mov eax, ebp
or eax, edi
jz loc_4038D6
test ebp, ebp
js loc_403D6C
mov eax, 0FFFFC001h
mov ecx, edi
mov ebx, ebp
loc_403A75:
shld ebx, ecx, 1
mov edx, eax
add ecx, ecx
sub eax, 1
test ebx, ebx
jns short loc_403A75
mov edi, ecx
mov ebp, ebx
jmp loc_4038D6
align 10h
loc_403A90:
movzx edi, word ptr [esp+60h+var_44]
sub edi, 1
loc_403A98:
shrd eax, edx, 1
mov ecx, edi
shr edx, 1
cmp edx, 0
lea edi, [ecx-1]
ja short loc_403A98
cmp eax, 1
ja short loc_403A98
mov word ptr [esp+60h+var_44], cx
xor eax, eax
xor edx, edx
jmp loc_4039D4
align 10h
loc_403AC0:
cmp ebx, [esp+60h+var_58]
movzx edx, word ptr [esp+60h+var_44]
jz loc_403D67
mov ebp, [esp+60h+var_48]
mov [esp+60h+var_4C], ebp
loc_403AD7:
mov edi, [esi+8]
test edi, edi
mov [esp+60h+var_44], edi
jle loc_403CC9
movsx edx, dx
mov eax, ebx
mov [esp+60h+var_50], edx
mov edx, [esi+0Ch]
sub eax, [esp+60h+var_58]
test edx, edx
lea ecx, [eax+edx]
mov edx, [esp+60h+var_48]
cmovg eax, ecx
and edx, 1C0h
cmp edx, 1
sbb edx, edx
lea edi, [eax+edx+6]
mov eax, [esp+60h+var_50]
mov edx, 66666667h
imul edx
mov eax, [esp+60h+var_50]
sar edx, 2
sar eax, 1Fh
mov ecx, edx
sub ecx, eax
jz loc_403D5D
mov ebp, 2
loc_403B35:
mov eax, 66666667h
add edi, 1
imul ecx
add ebp, 1
sar ecx, 1Fh
sar edx, 2
sub edx, ecx
mov ecx, edx
jnz short loc_403B35
movsx ebp, bp
loc_403B51:
cmp [esp+60h+var_44], edi
jle short loc_403BB0
mov eax, [esp+60h+var_44]
sub eax, edi
test [esp+60h+var_48], 600h
jnz loc_403CDA
lea edx, [eax-1]
test eax, eax
mov [esi+8], edx
jle short loc_403BB7
loc_403B75:
mov edx, esi
mov eax, 20h
call sub_4028D0
mov eax, [esi+8]
lea edx, [eax-1]
test eax, eax
mov [esi+8], edx
jg short loc_403B75
mov ecx, [esi+4]
mov [esp+60h+var_4C], ecx
test byte ptr [esp+60h+var_4C], 80h
jz short loc_403BBE
lea esi, [esi+0]
loc_403BA0:
mov edx, esi
mov eax, 2Dh
call sub_4028D0
jmp short loc_403BD7
align 10h
loc_403BB0:
mov dword ptr [esi+8], 0FFFFFFFFh
loc_403BB7:
test byte ptr [esp+60h+var_4C], 80h
jnz short loc_403BA0
loc_403BBE:
test [esp+60h+var_4C], 100h
jnz loc_403CE2
test byte ptr [esp+60h+var_4C], 40h
jnz loc_403CF3
loc_403BD7:
mov edx, esi
mov eax, 30h
call sub_4028D0
mov eax, [esi+4]
mov edx, esi
and eax, 20h
or eax, 58h
call sub_4028D0
mov eax, [esi+8]
test eax, eax
jle short loc_403C1F
test byte ptr [esi+5], 2
jz short loc_403C1F
sub eax, 1
mov [esi+8], eax
loc_403C06:
mov edx, esi
mov eax, 30h
call sub_4028D0
mov eax, [esi+8]
lea edx, [eax-1]
test eax, eax
mov [esi+8], edx
jg short loc_403C06
loc_403C1F:
cmp ebx, [esp+60h+var_58]
mov edi, [esp+60h+var_58]
ja short loc_403C54
jmp short loc_403C7C
align 10h
loc_403C30:
movzx eax, word ptr [esi+1Ch]
test ax, ax
mov word ptr [esp+60h+var_3A], ax
jz short loc_403C50
mov ecx, esi
mov edx, 1
lea eax, [esp+60h+var_3A]
call sub_402930
db 66h
nop
loc_403C50:
cmp ebx, edi
jz short loc_403C7C
loc_403C54:
sub ebx, 1
movsx eax, byte ptr [ebx]
cmp eax, 2Eh
jz short loc_403CC0
cmp eax, 2Ch
jz short loc_403C30
mov edx, esi
call sub_4028D0
jmp short loc_403C50
align 10h
loc_403C70:
mov edx, esi
mov eax, 30h
call sub_4028D0
loc_403C7C:
mov eax, [esi+0Ch]
lea edx, [eax-1]
test eax, eax
mov [esi+0Ch], edx
jg short loc_403C70
mov eax, [esi+4]
mov edx, esi
and eax, 20h
or eax, 50h
call sub_4028D0
mov eax, [esp+60h+var_50]
mov ecx, esi
add [esi+8], ebp
or dword ptr [esi+4], 1C0h
mov edx, eax
sar edx, 1Fh
call sub_402B70
loc_403CB3:
add esp, 5Ch
pop ebx
pop esi
pop edi
pop ebp
retn
align 10h
loc_403CC0:
mov eax, esi
call sub_403140
jmp short loc_403C50
loc_403CC9:
movsx edx, dx
mov ebp, 2
mov [esp+60h+var_50], edx
jmp loc_403BB7
loc_403CDA:
mov [esi+8], eax
jmp loc_403BB7
loc_403CE2:
mov edx, esi
mov eax, 2Bh
call sub_4028D0
jmp loc_403BD7
loc_403CF3:
mov edx, esi
mov eax, 20h
call sub_4028D0
jmp loc_403BD7
loc_403D04:
add edx, 1
jmp loc_40395D
loc_403D0C:
fstp st
mov ecx, esi
mov edx, offset unk_409284
xor eax, eax
call sub_402AD0
jmp short loc_403CB3
loc_403D1E:
mov ecx, esi
mov edx, offset unk_409288
mov eax, ebx
call sub_402AD0
jmp short loc_403CB3
loc_403D2E:
mov edi, [esi+4]
lea ebx, [esp+60h+var_28]
mov [esp+60h+var_58], ebx
mov [esp+60h+var_48], edi
loc_403D3D:
test eax, eax
jle short loc_403D76
mov ecx, [esp+60h+var_48]
mov [esp+60h+var_4C], ecx
loc_403D49:
mov byte ptr [esp+60h+var_28], 2Eh
lea ebx, [esp+60h+var_28+1]
loc_403D52:
mov byte ptr [ebx], 30h
add ebx, 1
jmp loc_403AD7
loc_403D5D:
mov ebp, 2
jmp loc_403B51
loc_403D67:
mov eax, [esi+0Ch]
jmp short loc_403D3D
loc_403D6C:
mov edx, 0FFFFC002h
jmp loc_4038D6
loc_403D76:
mov ebx, [esp+60h+var_48]
test [esp+60h+var_48], 800h
mov [esp+60h+var_4C], ebx
mov ebx, [esp+60h+var_58]
jz short loc_403D52
jmp short loc_403D49
sub_403870 endp
