sub_407380 proc near
var_1C= dword ptr -1Ch
var_18= dword ptr -18h
var_10= dword ptr -10h
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
sub esp, 1C
mov [esp+1Ch+var_8], ebx
mov [esp+1Ch+var_4], esi
call sub_4021D0
test eax, eax
mov ebx, eax
jz short loc_4073C2
mov esi, ds:GetProcAddress
mov [esp+1Ch+var_18], offset a___lc_codepag
mov [esp+1Ch+var_1C], eax
call es
sub esp, 8
test eax, eax
mov off_408040, eax
jz short loc_4073E0
mov ebx, [esp+1Ch+var_8]
mov esi, [esp+1Ch+var_4]
add esp, 1Ch
jmp eax
loc_4073C2:
mov ebx, [esp+1Ch+var_8]
mov esi, [esp+1Ch+var_4]
mov off_408040, offset sub_407340
add esp, 1Ch
jmp sub_407340
align 10h
loc_4073E0:
mov [esp+1Ch+var_18], offset a__lc_codepage
mov [esp+1Ch+var_1C], ebx
call esi
sub esp, 8
test eax, eax
mov ds:dword_40AD80, eax
jz short loc_4073C2
mov eax, [eax]
mov off_408040, offset loc_407330
mov ebx, [esp+24h+var_10]
mov esi, [esp+24h+var_C]
add esp, 1Ch
retn
sub_407380 end
