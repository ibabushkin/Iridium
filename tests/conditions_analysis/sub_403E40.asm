sub_403E40 proc near
var_7C= tbyte ptr -7Ch
var_70= dword ptr -70h
var_60= dword ptr -60h
var_5C= dword ptr -5Ch
var_58= dword ptr -58h
var_54= dword ptr -54h
var_50= dword ptr -50h
var_4A= dword ptr -4Ah
var_44= qword ptr -44h
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_24= word ptr -24h
var_20= dword ptr -20h
var_1C= word ptr -1Ch
var_18= dword ptr -18h
var_14= dword ptr -14h
var_10= dword ptr -10h
arg_0= dword ptr  14h
arg_4= dword ptr  18h
arg_8= dword ptr  1Ch
arg_C= dword ptr  20h
arg_10= dword ptr  24h
push ebp
push edi
push esi
push ebx
sub esp, 7C
mov ebp, [esp+7Ch+arg_C]
mov edi, [esp+7Ch+arg_10]
call _errno
and [esp+7Ch+arg_0], 6000h
mov eax, [eax]
mov dword ptr [esp+7Ch+var_7C], offset aPrintf_expone
mov [esp+7Ch+var_30], 0FFFFFFFFh
mov [esp+7Ch+var_2C], 0FFFFFFFFh
mov [esp+7Ch+var_50], eax
mov eax, [esp+7Ch+arg_4]
mov [esp+7Ch+var_28], 0FFFFFFFDh
mov [esp+7Ch+var_24], 0
mov [esp+7Ch+var_20], 0
mov [esp+7Ch+var_38], eax
mov eax, [esp+7Ch+arg_0]
mov [esp+7Ch+var_1C], 0
mov [esp+7Ch+var_18], 0
mov [esp+7Ch+var_34], eax
mov eax, [esp+7Ch+arg_8]
mov [esp+7Ch+var_14], eax
call getenv
test eax, eax
jz short loc_403EE2
movsx edx, byte ptr [eax]
mov eax, 2
sub edx, 30h
cmp edx, 2
jbe short loc_403EEF
loc_403EE2:
call sub_406640
and eax, 1
neg eax
add eax, 3
loc_403EEF:
mov [esp+7Ch+var_10], eax
loc_403EF3:
movsx eax, byte ptr [ebp+0]
lea esi, [ebp+1]
test eax, eax
jz loc_403FC2
loc_403F02:
cmp eax, 25h
jnz loc_403FD0
mov edx, [esp+7Ch+arg_0]
lea ecx, [esp+7Ch+var_30]
mov ebx, esi
mov [esp+7Ch+var_2C], 0FFFFFFFFh
mov [esp+7Ch+var_30], 0FFFFFFFFh
mov [esp+7Ch+var_54], ecx
xor ecx, ecx
mov [esp+7Ch+var_34], edx
movzx edx, byte ptr [ebp+1]
mov [esp+7Ch+var_58], 0
test dl, dl
jz short loc_403FB1
loc_403F42:
movsx eax, dl
sub edx, 20h
cmp dl, 5Ah
lea ebp, [ebx+1]
jbe loc_403FE0
loc_403F54:
cmp eax, 39h
jg loc_4046C3
cmp ecx, 3
ja loc_4046C3
cmp eax, 2Fh
jle loc_4046C3
test ecx, ecx
jnz loc_404598
mov ecx, 1
loc_403F7C:
mov edx, [esp+7Ch+var_54]
test edx, edx
jz short loc_403FA7
mov edx, [esp+7Ch+var_54]
mov edx, [edx]
test edx, edx
mov [esp+7Ch+var_60], edx
js loc_404665
mov edx, [esp+7Ch+var_60]
lea edx, [edx+edx*4]
lea eax, [eax+edx*2-30h]
mov edx, [esp+7Ch+var_54]
mov [edx], eax
loc_403FA7:
movzx edx, byte ptr [ebx+1]
loc_403FAB:
mov ebx, ebp
loc_403FAD:
test dl, dl
jnz short loc_403F42
loc_403FB1:
mov ebp, ebx
movsx eax, byte ptr [ebp+0]
lea esi, [ebp+1]
test eax, eax
jnz loc_403F02
loc_403FC2:
mov eax, [esp+7Ch+var_18]
add esp, 7Ch
pop ebx
pop esi
pop edi
pop ebp
retn 
align 10h
loc_403FD0:
lea edx, [esp+7Ch+var_38]
mov ebp, esi
call sub_4028D0
jmp loc_403EF3
loc_403FE0:
movzx edx, dl
jmp ds:off_4092B8[edx*4]
align 10h
loc_403FF0:
movzx edx, byte ptr [ebx+1]
mov ecx, 4
mov ebx, ebp
mov [esp+7Ch+var_58], 2
jmp short loc_403FAD
loc_404005:
mov edx, [esp+7Ch+var_58]
mov eax, edi
sub edx, 2
cmp edx, 1
jbe loc_4045A8
mov ebx, [eax]
add edi, 4
test ebx, ebx
jz loc_404296
loc_404024:
mov dword ptr [esp+7Ch+var_7C], ebx
call strlen
mov edx, eax
loc_40402E:
lea ecx, [esp+7Ch+var_38]
mov eax, ebx
call sub_402A30
jmp loc_403EF3
align 10h
loc_404040:
mov edx, [esp+7Ch+var_58]
mov eax, edi
mov [esp+7Ch+var_2C], 0FFFFFFFFh
sub edx, 2
cmp edx, 1
jbe loc_4043E8
mov eax, [eax]
lea ecx, [esp+7Ch+var_38]
mov edx, 1
add edi, 4
mov byte ptr [esp+7Ch+var_44], al
lea eax, [esp+7Ch+var_44]
call sub_402A30
jmp loc_403EF3
align 10h
loc_404080:
mov eax, [esp+7Ch+var_34]
or eax, 20h
test al, 4
mov [esp+7Ch+var_34], eax
jz loc_40441C
loc_404093:
fld tbyte ptr [edi]
lea ebx, [edi+0Ch]
fstp [esp+7Ch+var_7C]
mov edi, ebx
lea eax, [esp+7Ch+var_38]
call sub_403870
jmp loc_403EF3
align 10h
loc_4040B0:
cmp [esp+7Ch+var_58], 3
jz loc_404610
cmp [esp+7Ch+var_58], 2
jz loc_404679
movd xmm0, dword ptr [edi]
cmp [esp+7Ch+var_58], 1
movq [esp+7Ch+var_44], xmm0
lea edx, [edi+4]
jz loc_4046D8
cmp [esp+7Ch+var_58], 4
mov edi, edx
jz loc_404728
loc_4040EB:
cmp eax, 75h
jz loc_4041E8
lea edx, [esp+7Ch+var_38]
mov ecx, dword ptr [esp+7Ch+var_44+4]
mov dword ptr [esp+7Ch+var_7C], edx
mov edx, dword ptr [esp+7Ch+var_44]
call sub_402E30
jmp loc_403EF3
align 10h
loc_404110:
mov eax, [esp+7Ch+var_34]
or eax, 20h
test al, 4
mov [esp+7Ch+var_34], eax
jz loc_40437C
loc_404123:
fld tbyte ptr [edi]
lea ebx, [edi+0Ch]
fstp [esp+7Ch+var_7C]
mov edi, ebx
lea eax, [esp+7Ch+var_38]
call sub_4036F0
jmp loc_403EF3
align 10h
loc_404140:
mov eax, [esp+7Ch+var_34]
or eax, 20h
test al, 4
mov [esp+7Ch+var_34], eax
jz loc_4043A0
loc_404153:
fld tbyte ptr [edi]
lea ebx, [edi+0Ch]
fstp [esp+7Ch+var_7C]
mov edi, ebx
lea eax, [esp+7Ch+var_38]
call sub_403610
jmp loc_403EF3
align 10h
loc_404170:
mov eax, [esp+7Ch+var_34]
or eax, 20h
test al, 4
mov [esp+7Ch+var_34], eax
jz loc_4043C4
loc_404183:
fld tbyte ptr [edi]
lea ebx, [edi+0Ch]
fstp [esp+7Ch+var_7C]
mov edi, ebx
lea eax, [esp+7Ch+var_38]
call sub_403D90
jmp loc_403EF3
align 10h
loc_4041A0:
or [esp+7Ch+var_34], 80h
cmp [esp+7Ch+var_58], 3
jz loc_4045FB
cmp [esp+7Ch+var_58], 2
jz loc_404696
mov eax, [edi]
lea edx, [edi+4]
mov edi, eax
sar edi, 1Fh
cmp [esp+7Ch+var_58], 1
mov dword ptr [esp+7Ch+var_44], eax
mov dword ptr [esp+7Ch+var_44+4], edi
jz loc_4046F0
cmp [esp+7Ch+var_58], 4
mov edi, edx
jz loc_40473E
loc_4041E8:
mov eax, dword ptr [esp+7Ch+var_44]
lea ecx, [esp+7Ch+var_38]
mov edx, dword ptr [esp+7Ch+var_44+4]
call sub_402B70
jmp loc_403EF3
align 10h
loc_404200:
test ecx, ecx
jnz short loc_404215
mov ecx, [esp+7Ch+arg_0]
cmp [esp+7Ch+var_34], ecx
jz loc_4046AD
loc_404215:
movd xmm0, dword ptr [edi]
movq [esp+7Ch+var_44], xmm0
mov edx, dword ptr [esp+7Ch+var_44]
mov ecx, dword ptr [esp+7Ch+var_44+4]
lea eax, [esp+7Ch+var_38]
mov dword ptr [esp+7Ch+var_7C], eax
lea ebx, [edi+4]
mov eax, 78h
mov edi, ebx
call sub_402E30
jmp loc_403EF3
loc_404242:
cmp [esp+7Ch+var_58], 4
jz loc_4045EB
cmp [esp+7Ch+var_58], 1
mov eax, [edi]
mov edx, [esp+7Ch+var_18]
jz loc_40468B
cmp [esp+7Ch+var_58], 2
jz loc_404709
cmp [esp+7Ch+var_58], 3
mov [eax], edx
jz loc_404755
add edi, 4
jmp loc_403EF3
align 10h
loc_404280:
mov eax, [esp+7Ch+var_50]
mov dword ptr [esp+7Ch+var_7C], eax
call strerror
test eax, eax
mov ebx, eax
jnz loc_404024
loc_404296:
mov edx, 6
mov ebx, offset aNul
jmp loc_40402E
loc_4042A5:
movzx edx, byte ptr [ebx+1]
mov ecx, 4
mov [esp+7Ch+var_58], 2
cmp dl, 6Ch
jnz loc_403FAB
lea ebp, [ebx+2]
movzx edx, byte ptr [ebx+2]
mov [esp+7Ch+var_58], 3
mov ebx, ebp
jmp loc_403FAD
loc_4042D5:
movzx edx, byte ptr [ebx+1]
mov ecx, 4
mov ebx, ebp
mov [esp+7Ch+var_58], 3
jmp loc_403FAD
align 10h
loc_4042F0:
movzx edx, byte ptr [ebx+1]
mov ecx, 4
mov [esp+7Ch+var_58], 1
cmp dl, 68h
jnz loc_403FAB
lea ebp, [ebx+2]
movzx edx, byte ptr [ebx+2]
mov [esp+7Ch+var_58], 4
mov ebx, ebp
jmp loc_403FAD
loc_404320:
or [esp+7Ch+var_34], 4
mov ecx, 4
movzx edx, byte ptr [ebx+1]
mov ebx, ebp
jmp loc_403FAD
loc_404335:
movzx edx, byte ptr [ebx+1]
mov ecx, 4
mov [esp+7Ch+var_58], 2
cmp dl, 36h
jz loc_404625
cmp dl, 33h
jnz loc_403FAB
cmp byte ptr [ebx+2], 32h
jnz loc_403FAB
lea ebp, [ebx+3]
movzx edx, byte ptr [ebx+3]
mov ebx, ebp
jmp loc_403FAD
loc_404370:
mov eax, [esp+7Ch+var_34]
test al, 4
jnz loc_404123
loc_40437C:
fld qword ptr [edi]
lea ebx, [edi+8]
fstp [esp+7Ch+var_7C]
mov edi, ebx
lea eax, [esp+7Ch+var_38]
call sub_4036F0
jmp loc_403EF3
loc_404394:
mov eax, [esp+7Ch+var_34]
test al, 4
jnz loc_404153
loc_4043A0:
fld qword ptr [edi]
lea ebx, [edi+8]
fstp [esp+7Ch+var_7C]
mov edi, ebx
lea eax, [esp+7Ch+var_38]
call sub_403610
jmp loc_403EF3
loc_4043B8:
mov eax, [esp+7Ch+var_34]
test al, 4
jnz loc_404183
loc_4043C4:
fld qword ptr [edi]
lea ebx, [edi+8]
fstp [esp+7Ch+var_7C]
mov edi, ebx
lea eax, [esp+7Ch+var_38]
call sub_403D90
jmp loc_403EF3
align 10h
loc_4043E0:
mov [esp+7Ch+var_2C], 0FFFFFFFFh
loc_4043E8:
mov eax, [edi]
lea ebx, [edi+4]
mov edx, 1
lea ecx, [esp+7Ch+var_38]
mov edi, ebx
mov word ptr [esp+7Ch+var_4A], ax
lea eax, [esp+7Ch+var_4A]
call sub_402930
jmp loc_403EF3
align 10h
loc_404410:
mov eax, [esp+7Ch+var_34]
test al, 4
jnz loc_404093
loc_40441C:
fld qword ptr [edi]
lea ebx, [edi+8]
fstp [esp+7Ch+var_7C]
mov edi, ebx
lea eax, [esp+7Ch+var_38]
call sub_403870
jmp loc_403EF3
loc_404434:
test ecx, ecx
jnz loc_403F54
or [esp+7Ch+var_34], 200h
movzx edx, byte ptr [ebx+1]
mov ebx, ebp
jmp loc_403FAD
align 10h
loc_404450:
cmp ecx, 1
jbe loc_404645
loc_404459:
movzx edx, byte ptr [ebx+1]
mov ecx, 4
mov ebx, ebp
jmp loc_403FAD
align 10h
loc_404470:
test ecx, ecx
jnz loc_403FA7
or [esp+7Ch+var_34], 400h
movzx edx, byte ptr [ebx+1]
mov ebx, ebp
jmp loc_403FAD
align 10h
loc_404490:
test ecx, ecx
jnz loc_403FA7
or [esp+7Ch+var_34], 100h
movzx edx, byte ptr [ebx+1]
mov ebx, ebp
jmp loc_403FAD
align 10h
loc_4044B0:
mov eax, [esp+7Ch+var_54]
test eax, eax
jz short loc_404459
test ecx, 0FFFFFFFDh
jnz loc_4045D3
mov edx, [edi]
lea eax, [edi+4]
mov edi, [esp+7Ch+var_54]
test edx, edx
mov [edi], edx
js loc_404713
loc_4044D7:
movzx edx, byte ptr [ebx+1]
mov edi, eax
mov ebx, ebp
mov [esp+7Ch+var_54], 0
jmp loc_403FAD
align 10h
loc_4044F0:
test ecx, ecx
jnz loc_403FA7
mov [esp+7Ch+var_5C], ecx
or [esp+7Ch+var_34], 1000h
mov [esp+7Ch+var_4A+2], 0
call localeconv
lea edx, [esp+7Ch+var_4A+2]
mov [esp+7Ch+var_70], edx
mov dword ptr [esp+7Ch+var_7C+8], 10h
mov eax, [eax+4]
mov dword ptr [esp+7Ch+var_7C+4], eax
lea eax, [esp+7Ch+var_4A]
mov dword ptr [esp+7Ch+var_7C], eax
call sub_4060F0
mov ecx, [esp+7Ch+var_5C]
test eax, eax
jle short loc_404546
movzx edx, word ptr [esp+7Ch+var_4A]
mov [esp+7Ch+var_1C], dx
loc_404546:
mov [esp+7Ch+var_20], eax
movzx edx, byte ptr [ebx+1]
mov ebx, ebp
jmp loc_403FAD
loc_404555:
lea edx, [esp+7Ch+var_38]
call sub_4028D0
jmp loc_403EF3
loc_404563:
test ecx, ecx
jnz loc_403FA7
or [esp+7Ch+var_34], 800h
movzx edx, byte ptr [ebx+1]
mov ebx, ebp
jmp loc_403FAD
align 10h
loc_404580:
test ecx, ecx
jnz loc_403FA7
or [esp+7Ch+var_34], 40h
movzx edx, byte ptr [ebx+1]
mov ebx, ebp
jmp loc_403FAD
loc_404598:
cmp ecx, 2
mov edx, 3
cmovz ecx, edx
jmp loc_403F7C
loc_4045A8:
mov ebx, [edi]
mov eax, offset aNull_
lea esi, [edi+4]
mov edi, esi
test ebx, ebx
cmovz ebx, eax
mov dword ptr [esp+7Ch+var_7C], ebx
call wcslen
lea ecx, [esp+7Ch+var_38]
mov edx, eax
mov eax, ebx
call sub_402930
jmp loc_403EF3
loc_4045D3:
movzx edx, byte ptr [ebx+1]
mov ecx, 4
mov ebx, ebp
mov [esp+7Ch+var_54], 0
jmp loc_403FAD
loc_4045EB:
mov edx, [edi]
add edi, 4
mov eax, [esp+7Ch+var_18]
mov [edx], al
jmp loc_403EF3
loc_4045FB:
mov eax, [edi]
mov edx, [edi+4]
add edi, 8
mov dword ptr [esp+7Ch+var_44], eax
mov dword ptr [esp+7Ch+var_44+4], edx
jmp loc_4041E8
loc_404610:
mov ecx, [edi]
mov ebx, [edi+4]
add edi, 8
mov dword ptr [esp+7Ch+var_44], ecx
mov dword ptr [esp+7Ch+var_44+4], ebx
jmp loc_4040EB
loc_404625:
cmp byte ptr [ebx+2], 34h
jnz loc_403FAB
lea ebp, [ebx+3]
movzx edx, byte ptr [ebx+3]
mov [esp+7Ch+var_58], 3
mov ebx, ebp
jmp loc_403FAD
loc_404645:
lea ecx, [esp+7Ch+var_2C]
mov [esp+7Ch+var_2C], 0
movzx edx, byte ptr [ebx+1]
mov ebx, ebp
mov [esp+7Ch+var_54], ecx
mov ecx, 2
jmp loc_403FAD
loc_404665:
mov edx, [esp+7Ch+var_54]
sub eax, 30h
mov [edx], eax
movzx edx, byte ptr [ebx+1]
mov ebx, ebp
jmp loc_403FAD
loc_404679:
movd xmm0, dword ptr [edi]
add edi, 4
movq [esp+7Ch+var_44], xmm0
jmp loc_4040EB
loc_40468B:
mov [eax], dx
add edi, 4
jmp loc_403EF3
loc_404696:
mov eax, [edi]
add edi, 4
mov ecx, eax
sar ecx, 1Fh
mov dword ptr [esp+7Ch+var_44], eax
mov dword ptr [esp+7Ch+var_44+4], ecx
jmp loc_4041E8
loc_4046AD:
mov eax, ecx
or ah, 2
mov [esp+7Ch+var_34], eax
mov [esp+7Ch+var_2C], 8
jmp loc_404215
loc_4046C3:
lea edx, [esp+7Ch+var_38]
mov eax, 25h
call sub_4028D0
mov ebp, esi
jmp loc_403EF3
loc_4046D8:
movzx ecx, word ptr [esp+7Ch+var_44]
mov edi, edx
mov dword ptr [esp+7Ch+var_44+4], 0
mov dword ptr [esp+7Ch+var_44], ecx
jmp loc_4040EB
loc_4046F0:
movsx eax, word ptr [esp+7Ch+var_44]
mov edi, edx
mov ecx, eax
sar ecx, 1Fh
mov dword ptr [esp+7Ch+var_44], eax
mov dword ptr [esp+7Ch+var_44+4], ecx
jmp loc_4041E8
loc_404709:
mov [eax], edx
add edi, 4
jmp loc_403EF3
loc_404713:
test ecx, ecx
jnz short loc_404765
or [esp+7Ch+var_34], 400h
neg [esp+7Ch+var_30]
jmp loc_4044D7
loc_404728:
movzx edx, byte ptr [esp+7Ch+var_44]
mov dword ptr [esp+7Ch+var_44+4], 0
mov dword ptr [esp+7Ch+var_44], edx
jmp loc_4040EB
loc_40473E:
movsx eax, byte ptr [esp+7Ch+var_44]
mov edx, eax
sar edx, 1Fh
mov dword ptr [esp+7Ch+var_44], eax
mov dword ptr [esp+7Ch+var_44+4], edx
jmp loc_4041E8
loc_404755:
mov ecx, edx
add edi, 4
sar ecx, 1Fh
mov [eax+4], ecx
jmp loc_403EF3
loc_404765:
mov [esp+7Ch+var_2C], 0FFFFFFFFh
mov edi, eax
movzx edx, byte ptr [ebx+1]
mov [esp+7Ch+var_54], 0
mov ebx, ebp
jmp loc_403FAD
sub_403E40 endp
