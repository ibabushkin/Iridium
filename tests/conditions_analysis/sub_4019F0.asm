sub_4019F0 proc near
var_50= dword ptr -50h
var_4C= dword ptr -4Ch
var_48= dword ptr -48h
var_44= dword ptr -44h
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_20= dword ptr -20h
var_18= dword ptr -18h
push ebp
push edi
push esi
mov esi, eax
push ebx
sub esp, 4C
mov [esp+50h+var_34], ecx
mov ecx, ds:dword_40A054
mov [esp+50h+var_38], edx
test ecx, ecx
jle loc_401BF0
mov edx, ds:dword_40A050
xor ebx, ebx
loc_401A17:
mov eax, [edx+4]
cmp esi, eax
jb short loc_401A2C
mov edi, [edx+8]
add eax, [edi+8]
cmp esi, eax
jb loc_401B00
loc_401A2C:
add ebx, 1
add edx, 0Ch
cmp ebx, ecx
jnz short loc_401A17
loc_401A36:
mov [esp+50h+var_50], esi
call sub_401FF0
test eax, eax
mov ebp, eax
jz loc_401C17
lea ecx, [ebx+ebx*2]
mov ebx, ds:dword_40A050
lea edi, ds:0[ecx*4]
add ebx, edi
mov [ebx+8], eax
mov dword ptr [ebx], 0
call sub_4020C0
lea edx, [esp+50h+var_2C]
add eax, [ebp+0Ch]
mov [ebx+4], eax
mov eax, ds:dword_40A050
mov [esp+50h+var_4C], edx
mov ebx, ds:VirtualQuery
mov [esp+50h+var_48], 1Ch
mov eax, [eax+edi+4]
mov [esp+50h+var_3C], edx
mov [esp+50h+var_50], eax
call eb
sub esp, 0C
test eax, eax
mov edx, [esp+50h+var_3C]
jz loc_401BF7
mov eax, [esp+50h+var_18]
cmp eax, 4
jnz loc_401B90
loc_401AB2:
add ds:dword_40A054, 1
loc_401AB9:
mov [esp+50h+var_48], 1Ch
mov [esp+50h+var_4C], edx
mov [esp+50h+var_50], esi
call eb
sub esp, 0C
test eax, eax
jz loc_401C27
mov eax, [esp+50h+var_18]
cmp eax, 4
jnz short loc_401B10
loc_401ADE:
mov eax, [esp+50h+var_34]
mov [esp+50h+var_50], esi
mov [esp+50h+var_48], eax
mov eax, [esp+50h+var_38]
mov [esp+50h+var_4C], eax
call memcpy
loc_401AF6:
add esp, 4Ch
pop ebx
pop esi
pop edi
pop ebp
retn 
align 10h
loc_401B00:
lea edx, [esp+50h+var_2C]
mov ebx, ds:VirtualQuery
jmp short loc_401AB9
align 10h
loc_401B10:
cmp eax, 40h
jz short loc_401ADE
mov eax, [esp+50h+var_20]
lea ebp, [esp+50h+var_30]
mov ebx, ds:VirtualProtect
mov [esp+50h+var_44], ebp
mov [esp+50h+var_48], 40h
mov [esp+50h+var_4C], eax
mov eax, [esp+50h+var_2C]
mov [esp+50h+var_50], eax
call eb
sub esp, 10
mov eax, [esp+50h+var_34]
mov [esp+50h+var_50], esi
mov [esp+50h+var_48], eax
mov eax, [esp+50h+var_38]
mov [esp+50h+var_4C], eax
call memcpy
mov eax, [esp+50h+var_18]
cmp eax, 40h
jz short loc_401AF6
cmp eax, 4
jz short loc_401AF6
mov eax, [esp+50h+var_30]
mov [esp+50h+var_44], ebp
mov [esp+50h+var_48], eax
mov eax, [esp+50h+var_20]
mov [esp+50h+var_4C], eax
mov eax, [esp+50h+var_2C]
mov [esp+50h+var_50], eax
call eb
sub esp, 10h
add esp, 4Ch
pop ebx
pop esi
pop edi
pop ebp
retn 
align 10h
loc_401B90:
cmp eax, 40h
jz loc_401AB2
mov eax, [esp+50h+var_20]
mov ecx, ds:dword_40A050
mov [esp+50h+var_3C], edx
mov [esp+50h+var_48], 40h
mov [esp+50h+var_4C], eax
mov eax, [esp+50h+var_2C]
add ecx, edi
mov [esp+50h+var_44], ecx
mov [esp+50h+var_50], eax
call ds:VirtualProtect
sub esp, 10h
test eax, eax
mov edx, [esp+50h+var_3C]
jnz loc_401AB2
call ds:GetLastError
mov [esp+50h+var_50], offset aVirtualprotec
mov [esp+50h+var_4C], eax
call sub_4019A0
nop
lea esi, [esi+0]
loc_401BF0:
xor ebx, ebx
jmp loc_401A36
loc_401BF7:
mov eax, ds:dword_40A050
mov eax, [eax+edi+4]
mov [esp+50h+var_48], eax
mov eax, [ebp+8]
mov [esp+50h+var_50], offset aVirtualqueryF
mov [esp+50h+var_4C], eax
call sub_4019A0
loc_401C17:
mov [esp+50h+var_4C], esi
mov [esp+50h+var_50], offset aAddressPHasNo
call sub_4019A0
loc_401C27:
mov [esp+50h+var_48], esi
mov [esp+50h+var_4C], 1Ch
mov [esp+50h+var_50], offset aVirtualqueryF
call sub_4019A0
nop
sub_4019F0 endp
