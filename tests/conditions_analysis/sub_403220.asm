sub_403220 proc near
var_1C= dword ptr -1Ch
arg_0= dword ptr  8
push ebp
mov ebp, eax
push edi
mov edi, ecx
push esi
mov esi, edx
push ebx
sub esp, 1Ch
test edi, edi
mov ebx, [esp+28h+arg_0]
mov ecx, [ebx+8]
jle loc_403496
cmp edi, ecx
jge loc_403360
sub ecx, edi
mov [ebx+8], ecx
loc_403249:
test ecx, ecx
js loc_403360
loc_403251:
mov eax, [ebx+0Ch]
cmp eax, ecx
jge loc_403360
sub ecx, eax
test ecx, ecx
mov [ebx+8], ecx
jle loc_40336C
test eax, eax
jle loc_403511
loc_403271:
sub ecx, 1
test edi, edi
mov [ebx+8], ecx
jg loc_403374
nop
loc_403280:
test ecx, ecx
jle short loc_4032A2
test ebp, ebp
jz loc_403451
loc_40328C:
sub ecx, 1
test ecx, ecx
mov [ebx+8], ecx
jz short loc_4032A2
mov eax, [ebx+4]
loc_403299:
test ah, 6
jz loc_4033E3
loc_4032A2:
test ebp, ebp
jnz loc_4033F8
loc_4032AA:
mov eax, [ebx+4]
test ah, 1
jnz loc_4034B0
test al, 40h
jnz loc_403500
loc_4032BE:
mov edx, [ebx+8]
test edx, edx
jle short loc_4032D8
mov eax, [ebx+4]
and eax, 600h
cmp eax, 200h
jz loc_4034C1
loc_4032D8:
test edi, edi
jle loc_4034E8
loc_4032E0:
lea eax, [ebx+1Ch]
mov ebp, 55555556h
mov [esp+28h+var_1C], eax
loc_4032EC:
movzx edx, byte ptr [esi]
mov eax, 30h
test dl, dl
jz short loc_4032FE
movsx eax, dl
add esi, 1
loc_4032FE:
mov edx, ebx
call sub_4028D0
sub edi, 1
jnz loc_403410
loc_40330E:
mov eax, [ebx+0Ch]
test eax, eax
jle loc_403465
loc_403319:
mov eax, ebx
call sub_403140
test edi, edi
mov eax, [ebx+0Ch]
jz short loc_40334C
jmp loc_403477
align 10h
loc_403330:
movzx edx, byte ptr [esi]
mov eax, 30h
test dl, dl
jz short loc_403342
movsx eax, dl
add esi, 1
loc_403342:
mov edx, ebx
call sub_4028D0
loc_403349:
mov eax, [ebx+0Ch]
loc_40334C:
lea edx, [eax-1]
test eax, eax
mov [ebx+0Ch], edx
jg short loc_403330
add esp, 1Ch
pop ebx
pop esi
pop edi
pop ebp
retn
align 10h
loc_403360:
mov dword ptr [ebx+8], 0FFFFFFFFh
mov ecx, 0FFFFFFFFh
loc_40336C:
test edi, edi
jle loc_403280
loc_403374:
test byte ptr [ebx+5], 10h
jz loc_403280
cmp word ptr [ebx+1Ch], 0
jz loc_403280
lea eax, [edi+2]
mov edx, 55555556h
mov [esp+28h+var_1C], eax
imul edx
mov eax, [esp+28h+var_1C]
sar eax, 1Fh
sub edx, eax
cmp edx, 1
jle loc_403280
test ecx, ecx
jle loc_4032A2
mov eax, ecx
sub eax, edx
add eax, 1
jmp short loc_4033C8
align 10h
loc_4033C0:
test ecx, ecx
jz loc_403525
loc_4033C8:
sub ecx, 1
cmp ecx, eax
jnz short loc_4033C0
mov [ebx+8], ecx
jmp loc_403280
loc_4033D7:
mov edx, ebx
mov eax, 20h
call sub_4028D0
loc_4033E3:
mov eax, [ebx+8]
lea edx, [eax-1]
test eax, eax
mov [ebx+8], edx
jg short loc_4033D7
test ebp, ebp
jz loc_4032AA
loc_4033F8:
mov edx, ebx
mov eax, 2Dh
call sub_4028D0
jmp loc_4032BE
align 10h
loc_403410:
test byte ptr [ebx+5], 10h
jz loc_4032EC
cmp word ptr [ebx+1Ch], 0
nop
jz loc_4032EC
mov eax, edi
imul ebp
mov eax, edi
sar eax, 1Fh
sub edx, eax
lea eax, [edx+edx*2]
cmp edi, eax
jnz loc_4032EC
mov eax, [esp+28h+var_1C]
mov ecx, ebx
mov edx, 1
call sub_402930
jmp loc_4032EC
loc_403451:
mov eax, [ebx+4]
test eax, 1C0h
jz loc_403299
nop
jmp loc_40328C
loc_403465:
test byte ptr [ebx+5], 8
jnz loc_403319
test edi, edi
jz loc_40334C
loc_403477:
add eax, edi
mov [ebx+0Ch], eax
lea esi, [esi+0]
loc_403480:
mov edx, ebx
mov eax, 30h
call sub_4028D0
add edi, 1
js short loc_403480
jmp loc_403349
loc_403496:
test ecx, ecx
jle loc_403249
sub ecx, 1
mov [ebx+8], ecx
jmp loc_403251
align 10h
loc_4034B0:
mov edx, ebx
mov eax, 2Bh
call sub_4028D0
jmp loc_4032BE
loc_4034C1:
sub edx, 1
mov [ebx+8], edx
loc_4034C7:
mov edx, ebx
mov eax, 30h
call sub_4028D0
mov eax, [ebx+8]
lea edx, [eax-1]
test eax, eax
mov [ebx+8], edx
jg short loc_4034C7
test edi, edi
jg loc_4032E0
loc_4034E8:
mov edx, ebx
mov eax, 30h
call sub_4028D0
jmp loc_40330E
align 10h
loc_403500:
mov edx, ebx
mov eax, 20h
call sub_4028D0
jmp loc_4032BE
loc_403511:
test byte ptr [ebx+5], 8
jz loc_40336C
nop
lea esi, [esi+0]
jmp loc_403271
loc_403525:
mov dword ptr [ebx+8], 0
jmp loc_4032A2
sub_403220 endp
