sub_4067D0 proc near
var_1C= dword ptr -1Ch
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
arg_0= dword ptr  4
sub esp, 1C
xor eax, eax
mov [esp+1Ch+var_8], esi
mov esi, [esp+1Ch+arg_0]
mov [esp+1Ch+var_C], ebx
mov [esp+1Ch+var_4], edi
call sub_4066A0
cmp esi, 9
jg short loc_406805
mov ebx, ds:dword_40A3E0[esi*4]
test ebx, ebx
jz short loc_406856
mov eax, [ebx]
mov ds:dword_40A3E0[esi*4], eax
jmp short loc_40682F
loc_406805:
mov edi, 1
mov ecx, esi
shl edi, cl
lea eax, ds:1Bh[edi*4]
shr eax, 3
loc_406818:
shl eax, 3
mov [esp+1Ch+var_1C], eax
call malloc
test eax, eax
mov ebx, eax
jz short loc_406844
loc_406829:
mov [ebx+4], esi
mov [ebx+8], edi
loc_40682F:
xor eax, eax
call sub_406760
mov dword ptr [ebx+10h], 0
mov dword ptr [ebx+0Ch], 0
loc_406844:
mov eax, ebx
mov esi, [esp+1Ch+var_8]
mov ebx, [esp+1Ch+var_C]
mov edi, [esp+1Ch+var_4]
add esp, 1Ch
retn
loc_406856:
mov ebx, off_40803C
mov edi, 1
mov ecx, esi
shl edi, cl
lea eax, ds:1Bh[edi*4]
shr eax, 3
mov edx, ebx
sub edx, offset unk_40A420
sar edx, 3
add edx, eax
cmp edx, 120h
ja short loc_406818
lea eax, [ebx+eax*8]
mov off_40803C, eax
jmp short loc_406829
sub_4067D0 endp
