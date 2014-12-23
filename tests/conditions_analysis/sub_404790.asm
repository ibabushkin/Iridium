sub_404790 proc near
var_9C= dword ptr -9Ch
var_98= dword ptr -98h
var_94= dword ptr -94h
var_8C= qword ptr -8Ch
var_84= dword ptr -84h
var_7C= qword ptr -7Ch
var_74= dword ptr -74h
var_70= dword ptr -70h
var_6C= dword ptr -6Ch
var_68= dword ptr -68h
var_64= qword ptr -64h
var_5C= dword ptr -5Ch
var_58= dword ptr -58h
var_54= dword ptr -54h
var_50= dword ptr -50h
var_4C= dword ptr -4Ch
var_48= dword ptr -48h
var_44= dword ptr -44h
var_40= dword ptr -40h
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= qword ptr -2Ch
var_24= dword ptr -24h
var_20= dword ptr -20h
var_10= dword ptr -10h
arg_0= dword ptr  14h
arg_4= dword ptr  18h
arg_8= dword ptr  1Ch
arg_C= dword ptr  20h
arg_10= dword ptr  24h
arg_14= dword ptr  28h
arg_18= dword ptr  2Ch
arg_1C= dword ptr  30h
push ebp
push edi
push esi
push ebx
xor ebx, ebx
sub esp, 9Ch
mov edx, [esp+9Ch+arg_C]
mov esi, [edx]
mov eax, esi
and eax, 0FFFFFFCFh
mov [edx], eax
mov eax, esi
and eax, 7
cmp eax, 4
ja loc_40485
jmp ds:off_409438[eax*4
loc_4047C1:
movzx eax, byte ptr [ecx-1]
mov esi, ecx
jmp short loc_4047E3
loc_4047C9:
fstp st
fstp st
fstp st
jmp short loc_4047E3
loc_4047D1:
fstp st
fstp st
fstp st
fstp st
jmp short loc_4047E3
loc_4047DB:
fstp st
fstp st
fstp st
fstp st
loc_4047E3:
cmp al, 39h
lea ecx, [esi-1]
jnz loc_405B86
cmp ecx, ebx
jnz short loc_4047C1
add [esp+9Ch+var_24], 1
mov eax, 31h
mov byte ptr [ebx], 30h
loc_4047FF:
mov [ecx], al
mov ecx, [esp+9Ch+var_24]
mov dword ptr [esp+9Ch+var_7C], 20h
add ecx, 1
mov [esp+9Ch+var_70], ecx
loc_404814:
mov [esp+9Ch+var_9C], ebp
call sub_406890
mov eax, [esp+9Ch+arg_1C]
mov ecx, [esp+9Ch+var_70]
mov edx, [esp+9Ch+arg_18]
mov byte ptr [esi], 0
test eax, eax
mov [edx], ecx
jz short loc_404840
mov eax, [esp+9Ch+arg_1C]
mov [eax], esi
loc_404840:
mov edx, [esp+9Ch+arg_C]
mov ecx, dword ptr [esp+9Ch+var_7C]
or [edx], ecx
lea esi, [esi+0]
loc_404850:
add esp, 9Ch
mov eax, ebx
pop ebx
pop esi
pop edi
pop ebp
retn
align 10h
loc_404860:
mov eax, [esp+9Ch+arg_0]
xor edx, edx
mov edi, [eax]
cmp edi, 20h
jle short loc_40487E
mov eax, 20h
loc_404875:
add eax, eax
add edx, 1
cmp edi, eax
jg short loc_404875
loc_40487E:
mov [esp+9Ch+var_9C], edx
call sub_4067D0
mov edx, [esp+9Ch+arg_8]
mov ebp, eax
lea eax, [edi-1]
sar eax, 5
lea ebx, [edx+eax*4]
mov eax, [esp+9Ch+arg_8]
lea edx, [ebp+14h]
mov ecx, edx
mov [esp+9Ch+var_74], edx
loc_4048A8:
mov edx, [eax]
add eax, 4
mov [ecx], edx
add ecx, 4
cmp ebx, eax
jnb short loc_4048A8
mov edx, [esp+9Ch+var_74]
sub ecx, edx
sar ecx, 2
nop
loc_4048C0:
lea eax, [ecx-1]
mov ebx, [ebp+eax*4+14h]
test ebx, ebx
jnz loc_404D71
test eax, eax
mov ecx, eax
jnz short loc_4048C0
mov dword ptr [ebp+10h], 0
mov [esp+9Ch+var_58], 0
loc_4048E4:
mov [esp+9Ch+var_9C], ebp
call sub_4072F0
mov ecx, [esp+9Ch+arg_4]
mov [esp+9Ch+var_4C], ecx
test eax, eax
mov [esp+9Ch+var_10], eax
jnz loc_404D48
loc_404906:
mov ecx, [ebp+10h]
test ecx, ecx
jnz loc_4049D0
mov [esp+9Ch+var_9C], ebp
call sub_406890
loc_404919:
mov ecx, [esp+9Ch+arg_18]
mov eax, [esp+9Ch+arg_1C]
mov dword ptr [ecx], 1
mov [esp+9Ch+var_94], 1
mov [esp+9Ch+var_98], eax
mov [esp+9Ch+var_9C], offset a
call sub_406340
add esp, 9Ch
mov ebx, eax
mov eax, ebx
pop ebx
pop esi
pop edi
pop ebp
retn
loc_404954:
mov edx, [esp+9Ch+arg_18]
mov ecx, [esp+9Ch+arg_1C]
mov dword ptr [edx], 0FFFF8000h
mov [esp+9Ch+var_94], 3
mov [esp+9Ch+var_98], ecx
mov [esp+9Ch+var_9C], offset aNa
call sub_406340
add esp, 9Ch
mov ebx, eax
mov eax, ebx
pop ebx
pop esi
pop edi
pop ebp
retn
align 10h
loc_404990:
mov ecx, [esp+9Ch+arg_18]
mov eax, [esp+9Ch+arg_1C]
mov dword ptr [ecx], 0FFFF8000h
mov [esp+9Ch+var_94], 8
mov [esp+9Ch+var_98], eax
mov [esp+9Ch+var_9C], offset aInfinit
call sub_406340
add esp, 9Ch
mov ebx, eax
mov eax, ebx
pop ebx
pop esi
pop edi
pop ebp
retn 
align 10h
loc_4049D0:
lea eax, [esp+9Ch+var_10]
mov [esp+9Ch+var_98], eax
mov [esp+9Ch+var_9C], ebp
call sub_406FA0
mov ecx, [esp+9Ch+var_4C]
mov edx, [esp+9Ch+var_58]
lea eax, [ecx+edx-1]
fstp [esp+9Ch+var_64]
mov ecx, dword ptr [esp+9Ch+var_64+4]
mov edx, eax
mov [esp+9Ch+var_20], eax
sar edx, 1Fh
mov ebx, edx
xor ebx, eax
and ecx, 0FFFFFh
sub ebx, edx
or ecx, 3FF00000h
sub ebx, 435h
mov dword ptr [esp+9Ch+var_64+4], ecx
test ebx, ebx
fld [esp+9Ch+var_64]
fsub ds:flt_40944C
fmul ds:dbl_409450
fadd ds:dbl_409458
fild [esp+9Ch+var_20]
fmul ds:dbl_409460
faddp st(1), st
jle short loc_404A52
mov [esp+9Ch+var_20], ebx
fild [esp+9Ch+var_20]
fmul ds:dbl_409468
faddp st(1), st
loc_404A52:
fst [esp+9Ch+var_8C]
fldz
cvttsd2si edx, [esp+9Ch+var_8C]
fucomip st, st(1)
mov [esp+9Ch+var_74], edx
ja loc_4051A3
fstp st
loc_404A6C:
mov ebx, eax
shl ebx, 14h
add ebx, ecx
cmp [esp+9Ch+var_74], 16h
mov dword ptr [esp+9Ch+var_64+4], ebx
mov [esp+9Ch+var_38], 1
ja short loc_404AAE
mov edx, [esp+9Ch+var_74]
fld ds:dbl_4094C0[edx*8]
fld [esp+9Ch+var_64]
fxch st(1)
fucomip st, st(1)
fstp st
jbe loc_404E10
sub [esp+9Ch+var_74], 1
mov [esp+9Ch+var_38], 0
loc_404AAE:
mov ecx, [esp+9Ch+var_58]
mov [esp+9Ch+var_44], 0
sub ecx, eax
sub ecx, 1
mov [esp+9Ch+var_50], ecx
js loc_405190
loc_404AC9:
mov edx, [esp+9Ch+var_74]
test edx, edx
js loc_4051C0
mov ecx, [esp+9Ch+var_74]
add [esp+9Ch+var_50], ecx
mov [esp+9Ch+var_40], 0
mov [esp+9Ch+var_3C], ecx
loc_404AE9:
cmp [esp+9Ch+arg_10], 9
ja loc_404D90
cmp [esp+9Ch+arg_10], 5
jle loc_404D9B
sub [esp+9Ch+arg_10], 4
xor eax, eax
loc_404B0F:
cmp [esp+9Ch+arg_10], 3
jz loc_405467
jg loc_404DB0
cmp [esp+9Ch+arg_10], 2
jz loc_40541C
loc_404B31:
mov [esp+9Ch+var_20], edi
xor edx, edx
fild [esp+9Ch+var_20]
fmul ds:dbl_409470
mov [esp+9Ch+var_34], 1
mov [esp+9Ch+var_30], 0FFFFFFFFh
mov [esp+9Ch+var_48], 0FFFFFFFFh
mov [esp+9Ch+arg_14], 0
fstp [esp+9Ch+var_8C]
cvttsd2si eax, [esp+9Ch+var_8C]
add eax, 3
mov [esp+9Ch+var_10], eax
loc_404B78:
mov [esp+9Ch+var_9C], eax
mov byte ptr [esp+9Ch+var_84], dl
call sub_406300
mov ecx, [esp+9Ch+arg_0]
movzx edx, byte ptr [esp+9Ch+var_84]
mov ecx, [ecx+0Ch]
mov ebx, eax
sub ecx, 1
cmp ecx, 0
mov [esp+9Ch+var_54], ecx
jz short loc_404BBF
mov eax, 2
cmovge eax, ecx
and esi, 8
mov [esp+9Ch+var_54], eax
jz short loc_404BBF
mov eax, 3
sub eax, [esp+9Ch+var_54]
mov [esp+9Ch+var_54], eax
loc_404BBF:
test dl, dl
jz loc_404E70
mov edx, [esp+9Ch+var_54]
or edx, [esp+9Ch+var_74]
jnz loc_404E70
mov ecx, [esp+9Ch+var_38]
mov [esp+9Ch+var_10], 0
fld [esp+9Ch+var_64]
test ecx, ecx
jz short loc_404BF6
fld1
fucomip st, st(1)
ja loc_405AA3
loc_404BF6:
fld st
mov eax, [esp+9Ch+var_48]
fadd st, st(1)
fadd ds:flt_409484
fstp [esp+9Ch+var_2C]
sub dword ptr [esp+9Ch+var_2C+4], 3400000h
test eax, eax
jz loc_404E33
mov edx, [esp+9Ch+var_48]
fst [esp+9Ch+var_8C]
mov [esp+9Ch+var_24], 0
movsd xmm0, [esp+9Ch+var_8C]
loc_404C2E:
mov eax, [esp+9Ch+var_34]
test eax, eax
jz loc_405748
fld [esp+9Ch+var_2C]
cvttsd2si eax, xmm0
movsd [esp+9Ch+var_8C], xmm0
fld ds:flt_40948C
lea esi, [ebx+1]
fdiv ds:dbl_4094B8[edx*8]
mov [esp+9Ch+var_20], eax
add eax, 30h
mov [esp+9Ch+var_10], 0
fsubrp st(1), st
fild [esp+9Ch+var_20]
fld [esp+9Ch+var_8C]
fsubrp st(1), st
fxch st(1)
mov [ebx], al
fucomi st, st(1)
ja loc_404D18
fld st(1)
fsubr ds:flt_409478
fxch st(1)
fucomi st, st(1)
fstp st(1)
ja loc_4047C9
mov eax, [esp+9Ch+var_10]
add eax, 1
cmp eax, edx
mov [esp+9Ch+var_10], eax
jge loc_404E59
fld ds:flt_40947C
jmp short loc_404CE8
loc_404CB7:
fld st(1)
fsubr ds:flt_409478
fxch st(1)
fucomi st, st(1)
fstp st(1)
ja loc_4047D1
mov eax, [esp+9Ch+var_10]
add eax, 1
cmp edx, eax
mov [esp+9Ch+var_10], eax
jle loc_404E5F
fxch st(1)
fxch st(2)
loc_404CE8:
fmul st(1), st
fmul st(2), st
fxch st(2)
fst [esp+9Ch+var_8C]
cvttsd2si eax, [esp+9Ch+var_8C]
mov [esp+9Ch+var_20], eax
add eax, 30h
fild [esp+9Ch+var_20]
fsubp st(1), st
fxch st(1)
mov [esi], al
add esi, 1
fucomi st, st(1)
jbe short loc_404CB7
fstp st
fstp st(1)
fstp st(1)
jmp short loc_404D1C
loc_404D18:
fstp st
fstp st(1)
loc_404D1C:
fldz
fxch st(1)
fucomip st, st(1)
fstp st
jp loc_405BD3
jnz loc_405BD3
mov eax, [esp+9Ch+var_24]
mov dword ptr [esp+9Ch+var_7C], 0
add eax, 1
mov [esp+9Ch+var_70], eax
jmp loc_404814
loc_404D48:
mov [esp+9Ch+var_98], eax
mov [esp+9Ch+var_9C], ebp
call sub_4071E0
mov eax, [esp+9Ch+var_10]
mov edx, [esp+9Ch+arg_4]
sub [esp+9Ch+var_58], eax
add edx, eax
mov [esp+9Ch+var_4C], edx
jmp loc_404906
loc_404D71:
bsr eax, [ebp+ecx*4+10h]
mov [ebp+10h], ecx
shl ecx, 5
xor eax, 1Fh
sub ecx, eax
mov [esp+9Ch+var_58], ecx
jmp loc_4048E4
align 10h
loc_404D90:
mov [esp+9Ch+arg_10], 0
loc_404D9B:
add eax, 3FEh
cmp eax, 7F7h
setbe al
jmp loc_404B0F
align 10h
loc_404DB0:
cmp [esp+9Ch+arg_10], 4
jz loc_40545D
cmp [esp+9Ch+arg_10], 5
jnz loc_404B31
mov [esp+9Ch+var_34], 1
loc_404DD4:
mov edx, [esp+9Ch+arg_14]
add edx, [esp+9Ch+var_74]
mov [esp+9Ch+var_30], edx
add edx, 1
test edx, edx
mov [esp+9Ch+var_48], edx
jle loc_40569E
cmp edx, 0Eh
mov [esp+9Ch+var_10], edx
setbe dl
and edx, eax
mov eax, [esp+9Ch+var_48]
jmp loc_404B78
align 10h
loc_404E10:
mov [esp+9Ch+var_38], 0
jmp loc_404AAE
loc_404E1D:
fld st
fadd st, st(1)
fadd ds:flt_409484
fstp [esp+9Ch+var_2C]
sub dword ptr [esp+9Ch+var_2C+4], 3400000h
loc_404E33:
fld st
fsub ds:flt_409488
fld [esp+9Ch+var_2C]
fxch st(1)
fucomi st, st(1)
ja loc_40572B
fxch st(1)
fchs
fucomip st, st(1)
fstp st
ja loc_405162
jmp short loc_404E69
loc_404E59:
fstp st
fstp st
jmp short loc_404E69
loc_404E5F:
fstp st
fstp st
fstp st
jmp short loc_404E69
loc_404E67:
fstp st
loc_404E69:
fstp [esp+9Ch+var_64]
lea esi, [esi+0]
loc_404E70:
mov eax, [esp+9Ch+var_4C]
test eax, eax
js loc_404F30
mov eax, [esp+9Ch+arg_0]
mov edx, [esp+9Ch+var_74]
cmp edx, [eax+14h]
jg loc_404F30
mov eax, [esp+9Ch+var_48]
fld ds:dbl_4094C0[edx*8]
test eax, eax
jg loc_405588
mov eax, [esp+9Ch+arg_14]
shr eax, 1Fh
test al, al
jz loc_405588
mov eax, [esp+9Ch+var_48]
test eax, eax
jnz loc_405166
fmul ds:flt_409488
fld [esp+9Ch+var_64]
fxch st(1)
fucomip st, st(1)
fstp st
jnb loc_405168
add edx, 2
xor edi, edi
mov [esp+9Ch+var_70], edx
mov dword ptr [esp+9Ch+var_64], 0
loc_404EE8:
mov byte ptr [ebx], 31h
lea esi, [ebx+1]
xor edx, edx
mov dword ptr [esp+9Ch+var_7C], 20h
loc_404EF8:
mov [esp+9Ch+var_9C], edi
mov [esp+9Ch+var_84], edx
call sub_406890
mov edx, dword ptr [esp+9Ch+var_64]
test edx, edx
mov edx, [esp+9Ch+var_84]
jz loc_404814
cmp edx, dword ptr [esp+9Ch+var_64]
jnz loc_405407
loc_404F1E:
mov eax, dword ptr [esp+9Ch+var_64]
mov [esp+9Ch+var_9C], eax
call sub_406890
jmp loc_404814
align 10h
loc_404F30:
mov ecx, [esp+9Ch+var_34]
test ecx, ecx
jz loc_4051E0
mov eax, [esp+9Ch+arg_0]
mov esi, [esp+9Ch+var_4C]
sub edi, [esp+9Ch+var_58]
mov ecx, [eax+4]
sub esi, edi
lea eax, [edi+1]
mov [esp+9Ch+var_10], eax
cmp esi, ecx
jge loc_4053B0
cmp [esp+9Ch+arg_10], 5
jz loc_4053B0
cmp [esp+9Ch+arg_10], 3
jz loc_4053B0
mov eax, [esp+9Ch+var_4C]
mov edx, [esp+9Ch+var_48]
sub eax, ecx
add eax, 1
test edx, edx
mov [esp+9Ch+var_10], eax
jle loc_4056D2
cmp [esp+9Ch+arg_10], 1
jle loc_4056D2
cmp [esp+9Ch+var_48], eax
jl loc_4053BE
mov ecx, [esp+9Ch+var_44]
mov esi, [esp+9Ch+var_40]
mov [esp+9Ch+var_4C], ecx
db 66h
nop
loc_404FC0:
mov [esp+9Ch+var_9C], 1
add [esp+9Ch+var_44], eax
add [esp+9Ch+var_50], eax
call sub_4069E0
mov dword ptr [esp+9Ch+var_64], eax
loc_404FD8:
mov eax, [esp+9Ch+var_50]
test eax, eax
jle short loc_40500C
mov eax, [esp+9Ch+var_4C]
test eax, eax
jle short loc_40500C
mov ecx, [esp+9Ch+var_4C]
cmp [esp+9Ch+var_50], ecx
mov eax, ecx
cmovle eax, [esp+9Ch+var_50]
sub [esp+9Ch+var_44], eax
sub [esp+9Ch+var_50], eax
sub ecx, eax
mov [esp+9Ch+var_10], eax
mov [esp+9Ch+var_4C], ecx
loc_40500C:
mov edi, [esp+9Ch+var_40]
test edi, edi
jle short loc_40505C
mov ecx, [esp+9Ch+var_34]
test ecx, ecx
jz loc_405687
test esi, esi
jle short loc_405050
mov eax, dword ptr [esp+9Ch+var_64]
mov [esp+9Ch+var_98], esi
mov [esp+9Ch+var_9C], eax
call sub_406B70
mov [esp+9Ch+var_98], ebp
mov [esp+9Ch+var_9C], eax
mov dword ptr [esp+9Ch+var_64], eax
call sub_406A10
mov [esp+9Ch+var_9C], ebp
mov edi, eax
call sub_406890
mov ebp, edi
loc_405050:
mov eax, [esp+9Ch+var_40]
sub eax, esi
jnz loc_4056E3
loc_40505C:
mov [esp+9Ch+var_9C], 1
call sub_4069E0
mov edx, [esp+9Ch+var_3C]
test edx, edx
mov edi, eax
jle short loc_405084
mov ecx, [esp+9Ch+var_3C]
mov [esp+9Ch+var_9C], eax
mov [esp+9Ch+var_98], ecx
call sub_406B70
mov edi, eax
loc_405084:
cmp [esp+9Ch+arg_10], 1
mov [esp+9Ch+var_40], 0
jle loc_40564B
loc_40509A:
mov eax, [esp+9Ch+var_3C]
mov esi, 1Fh
test eax, eax
jz short loc_4050B2
mov eax, [edi+10h]
bsr esi, [edi+eax*4+10h]
xor esi, 1Fh
loc_4050B2:
sub esi, [esp+9Ch+var_50]
mov ecx, [esp+9Ch+var_44]
sub esi, 4
and esi, 1Fh
add ecx, esi
mov eax, esi
test ecx, ecx
mov [esp+9Ch+var_10], esi
jle short loc_4050E4
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_98], ecx
call sub_406C90
mov ebp, eax
mov eax, [esp+9Ch+var_10]
loc_4050E4:
add eax, [esp+9Ch+var_50]
test eax, eax
jle short loc_4050FA
mov [esp+9Ch+var_9C], edi
mov [esp+9Ch+var_98], eax
call sub_406C90
mov edi, eax
loc_4050FA:
mov eax, [esp+9Ch+var_38]
test eax, eax
jnz loc_405474
loc_405106:
mov eax, [esp+9Ch+var_48]
test eax, eax
jg loc_405200
cmp [esp+9Ch+arg_10], 2
jle loc_405200
loc_405120:
mov eax, [esp+9Ch+var_48]
test eax, eax
jnz short loc_405172
mov [esp+9Ch+var_9C], edi
mov [esp+9Ch+var_94], 0
mov [esp+9Ch+var_98], 5
call sub_4068E0
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_98], eax
mov edi, eax
call sub_406DA0
test eax, eax
jle short loc_405172
mov ecx, [esp+9Ch+var_74]
add ecx, 2
mov [esp+9Ch+var_70], ecx
jmp loc_404EE8
loc_405162:
fstp st
jmp short loc_405168
loc_405166:
fstp st
loc_405168:
xor edi, edi
mov dword ptr [esp+9Ch+var_64], 0
loc_405172:
mov eax, [esp+9Ch+arg_14]
mov esi, ebx
xor edx, edx
mov dword ptr [esp+9Ch+var_7C], 10h
neg eax
mov [esp+9Ch+var_70], eax
jmp loc_404EF8
loc_405190:
neg ecx
mov [esp+9Ch+var_44], ecx
mov [esp+9Ch+var_50], 0
jmp loc_404AC9
loc_4051A3:
fild [esp+9Ch+var_74]
fucomip st, st(1)
fstp st
jp short loc_4051B3
jz loc_404A6C
loc_4051B3:
sub [esp+9Ch+var_74], 1
jmp loc_404A6C
align 10h
loc_4051C0:
mov edx, [esp+9Ch+var_74]
sub [esp+9Ch+var_44], edx
mov [esp+9Ch+var_3C], 0
neg edx
mov [esp+9Ch+var_40], edx
jmp loc_404AE9
align 10h
loc_4051E0:
mov edx, [esp+9Ch+var_44]
mov esi, [esp+9Ch+var_40]
mov dword ptr [esp+9Ch+var_64], 0
mov [esp+9Ch+var_4C], edx
jmp loc_404FD8
align 10h
loc_405200:
mov eax, [esp+9Ch+var_34]
test eax, eax
jz loc_4054D0
loc_40520C:
add esi, [esp+9Ch+var_4C]
test esi, esi
jle short loc_405228
mov eax, dword ptr [esp+9Ch+var_64]
mov [esp+9Ch+var_98], esi
mov [esp+9Ch+var_9C], eax
call sub_406C90
mov dword ptr [esp+9Ch+var_64], eax
loc_405228:
mov esi, [esp+9Ch+var_40]
mov eax, dword ptr [esp+9Ch+var_64]
test esi, esi
mov [esp+9Ch+var_50], eax
jnz loc_4059A9
loc_40523C:
mov edx, dword ptr [esp+9Ch+var_64]
mov [esp+9Ch+var_68], edi
mov edi, [esp+9Ch+var_50]
mov [esp+9Ch+var_70], ebx
mov dword ptr [esp+9Ch+var_64], ebx
mov [esp+9Ch+var_10], 1
mov ebx, edx
jmp loc_40533F
loc_405262:
mov [esp+9Ch+var_9C], edx
mov [esp+9Ch+var_84], eax
call sub_406890
mov eax, [esp+9Ch+var_84]
mov edx, [esp+9Ch+arg_10]
or edx, eax
jnz short loc_405295
mov ecx, [esp+9Ch+arg_8]
test byte ptr [ecx], 1
jnz short loc_405295
mov edx, [esp+9Ch+var_54]
test edx, edx
jz loc_405C2A
loc_405295:
test esi, esi
js loc_40581D
or esi, [esp+9Ch+arg_10]
jnz short loc_4052B6
mov edx, [esp+9Ch+arg_8]
test byte ptr [edx], 1
jz loc_40581D
loc_4052B6:
test eax, eax
jg loc_4059F3
loc_4052BE:
mov ecx, [esp+9Ch+var_70]
movzx edx, byte ptr [esp+9Ch+var_6C]
mov [ecx], dl
mov edx, [esp+9Ch+var_48]
add ecx, 1
cmp [esp+9Ch+var_10], edx
mov [esp+9Ch+var_70], ecx
jz loc_405A67
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_94], 0
mov [esp+9Ch+var_98], 0Ah
call sub_4068E0
cmp ebx, edi
mov [esp+9Ch+var_94], 0
mov [esp+9Ch+var_98], 0Ah
mov [esp+9Ch+var_9C], ebx
mov ebp, eax
jz loc_4053A3
call sub_4068E0
mov [esp+9Ch+var_9C], edi
mov [esp+9Ch+var_94], 0
mov [esp+9Ch+var_98], 0Ah
mov ebx, eax
call sub_4068E0
mov edi, eax
loc_405337:
add [esp+9Ch+var_10], 1
loc_40533F:
mov eax, [esp+9Ch+var_68]
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_98], eax
call sub_4063B0
mov [esp+9Ch+var_98], ebx
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_58], eax
add eax, 30h
mov [esp+9Ch+var_6C], eax
call sub_406DA0
mov [esp+9Ch+var_98], edi
mov esi, eax
mov eax, [esp+9Ch+var_68]
mov [esp+9Ch+var_9C], eax
call sub_406E10
mov edx, eax
mov eax, 1
mov ecx, [edx+0Ch]
test ecx, ecx
jnz loc_405262
mov [esp+9Ch+var_98], edx
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_84], edx
call sub_406DA0
mov edx, [esp+9Ch+var_84]
jmp loc_405262
loc_4053A3:
call sub_4068E0
mov ebx, eax
mov edi, eax
jmp short loc_405337
align 10h
loc_4053B0:
cmp [esp+9Ch+arg_10], 1
jle loc_4056D2
loc_4053BE:
mov eax, [esp+9Ch+var_48]
mov esi, [esp+9Ch+var_40]
sub eax, 1
sub esi, eax
cmp [esp+9Ch+var_40], eax
jge short loc_4053E1
mov ecx, eax
xor esi, esi
sub ecx, [esp+9Ch+var_40]
add [esp+9Ch+var_3C], ecx
mov [esp+9Ch+var_40], eax
loc_4053E1:
mov eax, [esp+9Ch+var_48]
test eax, eax
js loc_40598B
mov ecx, [esp+9Ch+var_48]
mov edx, [esp+9Ch+var_44]
mov [esp+9Ch+var_10], ecx
mov eax, ecx
mov [esp+9Ch+var_4C], edx
jmp loc_404FC0
loc_405407:
test edx, edx
jz loc_404F1E
mov [esp+9Ch+var_9C], edx
call sub_406890
jmp loc_404F1E
loc_40541C:
mov [esp+9Ch+var_34], 0
loc_405424:
mov ebx, [esp+9Ch+arg_14]
test ebx, ebx
jle loc_4056BD
cmp [esp+9Ch+arg_14], 0Eh
setbe dl
loc_40543E:
mov ecx, [esp+9Ch+arg_14]
and edx, eax
mov [esp+9Ch+var_10], ecx
mov eax, ecx
mov [esp+9Ch+var_30], ecx
mov [esp+9Ch+var_48], ecx
jmp loc_404B78
loc_40545D:
mov [esp+9Ch+var_34], 1
jmp short loc_405424
loc_405467:
mov [esp+9Ch+var_34], 0
jmp loc_404DD4
loc_405474:
mov [esp+9Ch+var_98], edi
mov [esp+9Ch+var_9C], ebp
call sub_406DA0
test eax, eax
jns loc_405106
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_94], 0
mov [esp+9Ch+var_98], 0Ah
sub [esp+9Ch+var_74], 1
call sub_4068E0
mov ebp, eax
mov eax, [esp+9Ch+var_34]
test eax, eax
jnz loc_405C69
cmp [esp+9Ch+var_30], 0
mov edx, [esp+9Ch+var_30]
jg short loc_4054CC
cmp [esp+9Ch+arg_10], 2
jg loc_405D3E
loc_4054CC:
mov [esp+9Ch+var_48], edx
loc_4054D0:
mov esi, ebx
mov dword ptr [esp+9Ch+var_7C], ebx
mov ebx, [esp+9Ch+var_48]
mov [esp+9Ch+var_10], 1
jmp short loc_405509
loc_4054E7:
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_94], 0
mov [esp+9Ch+var_98], 0Ah
call sub_4068E0
add [esp+9Ch+var_10], 1
mov ebp, eax
loc_405509:
mov [esp+9Ch+var_98], edi
mov [esp+9Ch+var_9C], ebp
call sub_4063B0
add eax, 30h
mov [esi], al
add esi, 1
cmp ebx, [esp+9Ch+var_10]
jg short loc_4054E7
mov ebx, dword ptr [esp+9Ch+var_7C]
xor edx, edx
mov [esp+9Ch+var_6C], eax
loc_405530:
mov eax, [esp+9Ch+var_54]
test eax, eax
jz loc_40591E
cmp [esp+9Ch+var_54], 2
jz loc_40595A
cmp dword ptr [ebp+10h], 1
jle loc_405B6E
loc_405551:
movzx ecx, byte ptr [esi-1]
jmp short loc_40555D
loc_405557:
movzx ecx, byte ptr [eax-1]
mov esi, eax
loc_40555D:
cmp cl, 39h
lea eax, [esi-1]
jnz loc_405A86
cmp eax, ebx
jnz short loc_405557
mov ecx, [esp+9Ch+var_74]
mov byte ptr [ebx], 31h
mov dword ptr [esp+9Ch+var_7C], 20h
add ecx, 2
mov [esp+9Ch+var_70], ecx
jmp loc_404EF8
loc_405588:
fld [esp+9Ch+var_64]
lea esi, [ebx+1]
fld st
fdiv st, st(2)
mov [esp+9Ch+var_10], 1
fstp [esp+9Ch+var_7C]
cvttsd2si eax, [esp+9Ch+var_7C]
mov [esp+9Ch+var_20], eax
lea ecx, [eax+30h]
fild [esp+9Ch+var_20]
fmul st, st(2)
mov [ebx], cl
fsubp st(1), st
fldz
fxch st(1)
fucomi st, st(1)
fstp st(1)
jnp loc_405CA7
loc_4055C7:
mov ecx, [esp+9Ch+var_10]
cmp [esp+9Ch+var_48], ecx
jz loc_4056F8
fld ds:flt_40947C
mov edi, [esp+9Ch+var_48]
jmp short loc_4055F3
loc_4055E4:
mov ecx, [esp+9Ch+var_10]
cmp edi, ecx
jz loc_4056F6
loc_4055F3:
add ecx, 1
fmul st(1), st
mov [esp+9Ch+var_10], ecx
fld st(1)
fdiv st, st(3)
fstp [esp+9Ch+var_7C]
cvttsd2si eax, [esp+9Ch+var_7C]
mov [esp+9Ch+var_20], eax
lea edx, [eax+30h]
fild [esp+9Ch+var_20]
fmul st, st(3)
mov [esi], dl
add esi, 1
fsubp st(2), st
fldz
fxch st(2)
fucomi st, st(2)
fstp st(2)
jp short loc_4055E4
jnz short loc_4055E4
fstp st
fstp st
fstp st
loc_405633:
mov edx, [esp+9Ch+var_74]
mov dword ptr [esp+9Ch+var_7C], 0
add edx, 1
mov [esp+9Ch+var_70], edx
jmp loc_404814
loc_40564B:
cmp [esp+9Ch+var_58], 1
jnz loc_40509A
mov edx, [esp+9Ch+arg_0]
mov eax, [edx+4]
add eax, 1
cmp [esp+9Ch+arg_4], eax
jle loc_40509A
add [esp+9Ch+var_44], 1
add [esp+9Ch+var_50], 1
mov [esp+9Ch+var_40], 1
jmp loc_40509A
loc_405687:
mov edx, [esp+9Ch+var_40]
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_98], edx
call sub_406B70
mov ebp, eax
jmp loc_40505C
loc_40569E:
cmp [esp+9Ch+var_48], 0Eh
mov [esp+9Ch+var_10], 1
setbe dl
and edx, eax
mov eax, 1
jmp loc_404B78
loc_4056BD:
mov edx, 1
mov [esp+9Ch+arg_14], 1
jmp loc_40543E
loc_4056D2:
mov edx, [esp+9Ch+var_44]
mov esi, [esp+9Ch+var_40]
mov [esp+9Ch+var_4C], edx
jmp loc_404FC0
loc_4056E3:
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_98], eax
call sub_406B70
mov ebp, eax
jmp loc_40505C
loc_4056F6:
fstp st
loc_4056F8:
mov edi, [esp+9Ch+var_54]
test edi, edi
jz loc_405A48
fstp st
fstp st
cmp [esp+9Ch+var_54], 1
jz loc_405C19
mov ecx, [esp+9Ch+var_74]
mov dword ptr [esp+9Ch+var_7C], 10h
add ecx, 1
mov [esp+9Ch+var_70], ecx
jmp loc_404814
loc_40572B:
fstp st
fstp st
fstp st
mov [esp+9Ch+var_70], 2
xor edi, edi
mov dword ptr [esp+9Ch+var_64], 0
jmp loc_404EE8
loc_405748:
fld [esp+9Ch+var_2C]
mov esi, ebx
fmul ds:dbl_4094B8[edx*8]
mov [esp+9Ch+var_10], 1
fld [esp+9Ch+var_64]
fld ds:flt_40947C
jmp short loc_40578A
align 10h
loc_405770:
fmul st(1), st
fxch st(1)
add ecx, 1
mov [esp+9Ch+var_10], ecx
fst [esp+9Ch+var_8C]
fxch st(1)
movsd xmm0, [esp+9Ch+var_8C]
loc_40578A:
cvttsd2si eax, xmm0
test eax, eax
jz short loc_4057AA
fstp st(1)
mov [esp+9Ch+var_20], eax
movsd [esp+9Ch+var_8C], xmm0
fild [esp+9Ch+var_20]
fld [esp+9Ch+var_8C]
fsubrp st(1), st
fxch st(1)
loc_4057AA:
add eax, 30h
mov [esi], al
mov ecx, [esp+9Ch+var_10]
add esi, 1
cmp ecx, edx
jnz short loc_405770
fstp st
fld ds:flt_40948C
fld st(2)
fadd st, st(1)
fxch st(2)
fucomi st, st(2)
fstp st(2)
ja loc_4047DB
fsubrp st(2), st
fxch st(1)
fucomip st, st(1)
jbe loc_404E67
fstp st(1)
fldz
fxch st(1)
fucomip st, st(1)
fstp st
jp short loc_4057F3
jz loc_405BEB
loc_4057F3:
mov dword ptr [esp+9Ch+var_7C], 10h
jmp short loc_405806
align 10h
loc_405800:
movzx eax, byte ptr [edx-1]
mov esi, edx
loc_405806:
cmp al, 30h
lea edx, [esi-1]
jz short loc_405800
mov eax, [esp+9Ch+var_24]
add eax, 1
mov [esp+9Ch+var_70], eax
jmp loc_404814
loc_40581D:
mov ecx, [esp+9Ch+var_54]
mov edx, ebx
mov [esp+9Ch+var_50], edi
mov esi, [esp+9Ch+var_70]
mov edi, [esp+9Ch+var_68]
mov ebx, dword ptr [esp+9Ch+var_64]
test ecx, ecx
jz loc_405B06
cmp dword ptr [ebp+10h], 1
jle loc_405AFC
loc_405845:
cmp [esp+9Ch+var_54], 2
jz loc_405B61
mov dword ptr [esp+9Ch+var_7C], edi
mov edi, edx
mov [esp+9Ch+var_5C], ebx
mov ebx, [esp+9Ch+var_50]
jmp short loc_4058C2
loc_405860:
movzx ecx, byte ptr [esp+9Ch+var_6C]
mov [esi], cl
add esi, 1
mov [esp+9Ch+var_9C], ebx
mov [esp+9Ch+var_94], 0
mov [esp+9Ch+var_98], 0Ah
call sub_4068E0
cmp edi, ebx
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_94], 0
mov [esp+9Ch+var_98], 0Ah
cmovz edi, eax
mov [esp+9Ch+var_84], eax
call sub_4068E0
mov ebp, eax
mov eax, dword ptr [esp+9Ch+var_7C]
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_98], eax
call sub_4063B0
mov edx, [esp+9Ch+var_84]
mov ebx, edx
add eax, 30h
mov [esp+9Ch+var_6C], eax
loc_4058C2:
mov eax, dword ptr [esp+9Ch+var_7C]
mov [esp+9Ch+var_98], ebx
mov [esp+9Ch+var_9C], eax
call sub_406DA0
test eax, eax
jg short loc_405860
cmp [esp+9Ch+var_6C], 39h
mov edx, edi
mov [esp+9Ch+var_50], ebx
mov edi, dword ptr [esp+9Ch+var_7C]
mov ebx, [esp+9Ch+var_5C]
jz loc_405B8E
add [esp+9Ch+var_6C], 1
mov dword ptr [esp+9Ch+var_7C], 20h
loc_4058FC:
movzx eax, byte ptr [esp+9Ch+var_6C]
mov [esi], al
mov ecx, [esp+9Ch+var_74]
add esi, 1
mov eax, [esp+9Ch+var_50]
add ecx, 1
mov [esp+9Ch+var_70], ecx
mov dword ptr [esp+9Ch+var_64], eax
jmp loc_404EF8
loc_40591E:
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_98], 1
mov [esp+9Ch+var_84], edx
call sub_406C90
mov [esp+9Ch+var_98], edi
mov [esp+9Ch+var_9C], eax
mov ebp, eax
call sub_406DA0
mov edx, [esp+9Ch+var_84]
cmp eax, 0
jg loc_405551
jnz short loc_40595A
test byte ptr [esp+9Ch+var_6C], 1
jnz loc_405551
loc_40595A:
cmp dword ptr [ebp+10h], 1
db 66h
nop
jle loc_405D01
loc_405966:
mov dword ptr [esp+9Ch+var_7C], 10h
jmp short loc_405972
loc_405970:
mov esi, eax
loc_405972:
cmp byte ptr [esi-1], 30h
lea eax, [esi-1]
jz short loc_405970
mov ecx, [esp+9Ch+var_74]
add ecx, 1
mov [esp+9Ch+var_70], ecx
jmp loc_404EF8
loc_40598B:
mov ecx, [esp+9Ch+var_44]
xor eax, eax
sub ecx, [esp+9Ch+var_48]
mov [esp+9Ch+var_10], 0
mov [esp+9Ch+var_4C], ecx
jmp loc_404FC0
loc_4059A9:
mov eax, [eax+4]
mov [esp+9Ch+var_9C], eax
call sub_4067D0
mov ecx, dword ptr [esp+9Ch+var_64]
lea edx, [eax+0Ch]
mov esi, eax
mov eax, [ecx+10h]
add ecx, 0Ch
mov [esp+9Ch+var_98], ecx
mov [esp+9Ch+var_9C], edx
lea eax, ds:8[eax*4]
mov [esp+9Ch+var_94], eax
call memcpy
mov [esp+9Ch+var_98], 1
mov [esp+9Ch+var_9C], esi
call sub_406C90
mov [esp+9Ch+var_50], eax
jmp loc_40523C
loc_4059F3:
cmp [esp+9Ch+var_54], 2
jz loc_4052BE
cmp [esp+9Ch+var_6C], 39h
mov edx, ebx
mov [esp+9Ch+var_50], edi
mov esi, [esp+9Ch+var_70]
mov edi, [esp+9Ch+var_68]
mov ebx, dword ptr [esp+9Ch+var_64]
jz loc_405B8E
movzx eax, byte ptr [esp+9Ch+var_6C]
mov ecx, [esp+9Ch+var_74]
mov dword ptr [esp+9Ch+var_7C], 20h
add eax, 1
mov [esi], al
mov eax, [esp+9Ch+var_50]
add ecx, 1
add esi, 1
mov [esp+9Ch+var_70], ecx
mov dword ptr [esp+9Ch+var_64], eax
jmp loc_404EF8
loc_405A48:
fadd st, st
fucomi st, st(1)
jbe loc_405BA6
fstp st
fstp st
mov ecx, [esp+9Ch+var_74]
movzx eax, byte ptr [esi-1]
mov [esp+9Ch+var_24], ecx
jmp loc_4047E3
loc_405A67:
mov [esp+9Ch+var_50], edi
mov eax, [esp+9Ch+var_50]
mov edx, ebx
mov edi, [esp+9Ch+var_68]
mov ebx, dword ptr [esp+9Ch+var_64]
mov esi, [esp+9Ch+var_70]
mov dword ptr [esp+9Ch+var_64], eax
jmp loc_405530
loc_405A86:
add ecx, 1
mov [eax], cl
mov ecx, [esp+9Ch+var_74]
mov dword ptr [esp+9Ch+var_7C], 20h
add ecx, 1
mov [esp+9Ch+var_70], ecx
jmp loc_404EF8
loc_405AA3:
mov edx, [esp+9Ch+var_48]
test edx, edx
jz loc_404E1D
mov eax, [esp+9Ch+var_30]
test eax, eax
jle loc_404E69
fld st
mov edx, [esp+9Ch+var_30]
fmul ds:flt_40947C
mov [esp+9Ch+var_24], 0FFFFFFFFh
fst [esp+9Ch+var_8C]
fmul ds:flt_409480
movsd xmm0, [esp+9Ch+var_8C]
movsd [esp+9Ch+var_64], xmm0
fadd ds:flt_409484
fstp [esp+9Ch+var_2C]
sub dword ptr [esp+9Ch+var_2C+4], 3400000h
jmp loc_404C2E
loc_405AFC:
cmp dword ptr [ebp+14h], 0
jnz loc_405845
loc_405B06:
test eax, eax
jle loc_405BC9
mov [esp+9Ch+var_9C], ebp
mov [esp+9Ch+var_98], 1
mov [esp+9Ch+var_84], edx
call sub_406C90
mov [esp+9Ch+var_98], edi
mov [esp+9Ch+var_9C], eax
mov ebp, eax
call sub_406DA0
mov edx, [esp+9Ch+var_84]
cmp eax, 0
jle loc_405CDA
loc_405B3D:
cmp [esp+9Ch+var_6C], 39h
jz short loc_405B8E
mov ecx, [esp+9Ch+var_58]
mov dword ptr [esp+9Ch+var_7C], 20h
add ecx, 31h
mov [esp+9Ch+var_6C], ecx
loc_405B57:
cmp dword ptr [ebp+10h], 1
jle loc_405CB6
loc_405B61:
mov dword ptr [esp+9Ch+var_7C], 10h
jmp loc_4058FC
loc_405B6E:
mov ecx, [ebp+14h]
test ecx, ecx
jnz loc_405551
mov dword ptr [esp+9Ch+var_7C], 0
jmp loc_405972
loc_405B86:
add eax, 1
jmp loc_4047FF
loc_405B8E:
mov eax, [esp+9Ch+var_50]
mov ecx, 39h
mov byte ptr [esi], 39h
add esi, 1
mov dword ptr [esp+9Ch+var_64], eax
jmp loc_40555D
loc_405BA6:
fxch st(1)
fucomip st, st(1)
fstp st
jp short loc_405BB0
jz short loc_405BF8
loc_405BB0:
mov edx, [esp+9Ch+var_74]
movzx eax, byte ptr [esi-1]
mov dword ptr [esp+9Ch+var_7C], 10h
mov [esp+9Ch+var_24], edx
jmp loc_405806
loc_405BC9:
mov dword ptr [esp+9Ch+var_7C], 0
jmp short loc_405B57
loc_405BD3:
mov edx, [esp+9Ch+var_24]
mov dword ptr [esp+9Ch+var_7C], 10h
add edx, 1
mov [esp+9Ch+var_70], edx
jmp loc_404814
loc_405BEB:
mov dword ptr [esp+9Ch+var_7C], 0
jmp loc_405806
loc_405BF8:
test al, 1
movzx eax, byte ptr [esi-1]
jnz loc_405CF4
mov ecx, [esp+9Ch+var_74]
mov dword ptr [esp+9Ch+var_7C], 10h
mov [esp+9Ch+var_24], ecx
jmp loc_405806
loc_405C19:
mov edx, [esp+9Ch+var_74]
movzx eax, byte ptr [esi-1]
mov [esp+9Ch+var_24], edx
jmp loc_4047E3
loc_405C2A:
cmp [esp+9Ch+var_6C], 39h
mov edx, ebx
mov [esp+9Ch+var_50], edi
mov ecx, esi
mov edi, [esp+9Ch+var_68]
mov ebx, dword ptr [esp+9Ch+var_64]
mov esi, [esp+9Ch+var_70]
jz loc_405B8E
test ecx, ecx
jle loc_405D18
mov ecx, [esp+9Ch+var_58]
mov dword ptr [esp+9Ch+var_7C], 20h
add ecx, 31h
mov [esp+9Ch+var_6C], ecx
jmp loc_4058FC
loc_405C69:
mov eax, dword ptr [esp+9Ch+var_64]
mov [esp+9Ch+var_94], 0
mov [esp+9Ch+var_98], 0Ah
mov [esp+9Ch+var_9C], eax
call sub_4068E0
cmp [esp+9Ch+var_30], 0
mov dword ptr [esp+9Ch+var_64], eax
jg short loc_405C9A
cmp [esp+9Ch+arg_10], 2
jg short loc_405CCD
loc_405C9A:
mov edx, [esp+9Ch+var_30]
mov [esp+9Ch+var_48], edx
jmp loc_40520C
loc_405CA7:
jnz loc_4055C7
fstp st
fstp st
jmp loc_405633
loc_405CB6:
cmp dword ptr [ebp+14h], 0
mov eax, 10h
cmovz eax, dword ptr [esp+9Ch+var_7C]
mov dword ptr [esp+9Ch+var_7C], eax
jmp loc_4058FC
loc_405CCD:
mov ecx, [esp+9Ch+var_30]
mov [esp+9Ch+var_48], ecx
jmp loc_405120
loc_405CDA:
jnz short loc_405CE7
test byte ptr [esp+9Ch+var_6C], 1
jnz loc_405B3D
loc_405CE7:
mov dword ptr [esp+9Ch+var_7C], 20h
jmp loc_405B57
loc_405CF4:
mov edx, [esp+9Ch+var_74]
mov [esp+9Ch+var_24], edx
jmp loc_4047E3
loc_405D01:
cmp dword ptr [ebp+14h], 0
mov dword ptr [esp+9Ch+var_7C], 0
jnz loc_405966
jmp loc_405972
loc_405D18:
cmp dword ptr [ebp+10h], 1
mov dword ptr [esp+9Ch+var_7C], 10h
jg loc_4058FC
cmp dword ptr [ebp+14h], 1
sbb eax, eax
not eax
and eax, 10h
mov dword ptr [esp+9Ch+var_7C], eax
jmp loc_4058FC
loc_405D3E:
mov [esp+9Ch+var_48], edx
jmp loc_405120
sub_404790 endp
