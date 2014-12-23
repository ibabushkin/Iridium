sub_401C40 proc near
var_6C= dword ptr -6Ch
var_68= dword ptr -68h
var_64= dword ptr -64h
var_60= dword ptr -60h
var_4D= dword ptr -4Dh
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_28= dword ptr -28h
var_C= dword ptr -0Ch
mov eax, ds:dword_40A04C
test eax, eax
jz short loc_401C50
retn
align 10h
loc_401C50:
push ebp
mov ebp, esp
push edi
push esi
push ebx
sub esp, 5Ch
mov ds:dword_40A04C, 1
call sub_402030
lea eax, [eax+eax*2]
lea eax, ds:1Eh[eax*4]
and eax, 0FFFFFFF0h
call sub_4026E0
mov ds:dword_40A054, 0
sub esp, eax
lea eax, [esp+6Ch+var_4D]
and eax, 0FFFFFFF0h
mov ds:dword_40A050, eax
mov eax, offset dword_409624
sub eax, offset dword_409624
cmp eax, 7
jle loc_401D41
cmp eax, 0Bh
jle loc_401E00
mov eax, ds:dword_409624
test eax, eax
jnz loc_401D49
mov eax, ds:dword_409628
test eax, eax
jnz loc_401D49
mov edi, ds:dword_40962C
mov ebx, offset unk_409630
test edi, edi
jz loc_401E05
mov ebx, offset dword_409624
loc_401CE0:
mov eax, [ebx+8]
cmp eax, 1
jnz loc_401ED7
add ebx, 0Ch
cmp ebx, offset dword_409624
jnb short loc_401D41
loc_401CF7:
mov edx, [ebx]
movzx esi, byte ptr [ebx+8]
mov edi, [ebx+4]
mov ecx, [edx+400000h]
cmp esi, 10h
lea eax, [edi+400000h]
mov [ebp-50h], ecx
jz loc_401E1F
cmp esi, 20h
jz loc_401E95
cmp esi, 8
jz loc_401E68
mov [esp+6Ch+var_68], esi
mov [esp+6Ch+var_6C], offset aUnknownPseudo
mov [ebp+var_3C], 0
call sub_4019A0
loc_401D41:
lea esp, [ebp-0Ch]
pop ebx
pop esi
pop edi
pop ebp
retn 
loc_401D49:
mov ebx, offset dword_409624
loc_401D4E:
cmp ebx, offset dword_409624
jnb short loc_401D41
loc_401D56:
mov edx, [ebx+4]
mov ecx, 4
lea eax, [edx+400000h]
mov edx, [edx+400000h]
add edx, [ebx]
add ebx, 8
mov [ebp+var_38], edx
lea edx, [ebp+var_38]
call sub_4019F0
cmp ebx, offset dword_409624
jb short loc_401D56
loc_401D82:
mov eax, ds:dword_40A054
xor ebx, ebx
xor esi, esi
lea edi, [ebp+var_34]
test eax, eax
jg short loc_401DA2
jmp short loc_401D41
loc_401D94:
add esi, 1
add ebx, 0Ch
cmp esi, ds:dword_40A054
jge short loc_401D41
loc_401DA2:
mov eax, ds:dword_40A050
add eax, ebx
mov edx, [eax]
test edx, edx
jz short loc_401D94
mov [esp+6Ch+var_64], 1Ch
mov [esp+6Ch+var_68], edi
mov eax, [eax+4]
mov [esp+6Ch+var_6C], eax
call ds:VirtualQuery
sub esp, 0C
test eax, eax
jz loc_401EB4
lea eax, [ebp+var_38]
mov [esp+6Ch+var_60], eax
mov eax, ds:dword_40A050
mov eax, [eax+ebx]
mov [esp+6Ch+var_64], eax
mov eax, [ebp+var_28]
mov [esp+6Ch+var_68], eax
mov eax, [ebp+var_34]
mov [esp+6Ch+var_6C], eax
call ds:VirtualProtect
sub esp, 10h
jmp short loc_401D94
align 10h
loc_401E00:
mov ebx, offset dword_409624
loc_401E05:
mov esi, [ebx]
test esi, esi
jnz loc_401D4E
mov ecx, [ebx+4]
test ecx, ecx
jz loc_401CE0
jmp loc_401D4E
loc_401E1F:
movzx edi, word ptr [edi+400000h]
movzx esi, di
mov ecx, esi
or ecx, 0FFFF0000h
test di, di
cmovs esi, ecx
mov ecx, [ebp-50h]
sub esi, edx
sub esi, 400000h
lea edx, [ebp+var_3C]
add ecx, esi
mov [ebp+var_3C], ecx
mov ecx, 2
call sub_4019F0
loc_401E54:
add ebx, 0Ch
cmp ebx, offset dword_409624
jb loc_401CF7
jmp loc_401D82
loc_401E68:
movzx esi, byte ptr [eax]
mov edi, esi
or edi, 0FFFFFF00h
cmp byte ptr [eax], 0
cmovs esi, edi
sub esi, 400000h
sub esi, edx
add ecx, esi
mov [ebp+var_3C], ecx
lea edx, [ebp+var_3C]
mov ecx, 1
call sub_4019F0
jmp short loc_401E54
loc_401E95:
mov ecx, [ebp-50h]
add edx, 400000h
sub ecx, edx
add ecx, [eax]
lea edx, [ebp+var_3C]
mov [ebp+var_3C], ecx
mov ecx, 4
call sub_4019F0
jmp short loc_401E54
loc_401EB4:
add ebx, ds:dword_40A050
mov eax, [ebx+4]
mov [esp+6Ch+var_64], eax
mov eax, [ebx+8]
mov eax, [eax+8]
mov [esp+6Ch+var_6C], offset aVirtualqueryF
mov [esp+6Ch+var_68], eax
call sub_4019A0
loc_401ED7:
mov [esp+6Ch+var_68], eax
mov [esp+6Ch+var_6C], offset aUnknownPseud_
call sub_4019A0
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub_401C40 endp
