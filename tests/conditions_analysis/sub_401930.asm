sub_401930 proc near
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= qword ptr -2Ch
var_24= qword ptr -24h
var_1C= qword ptr -1Ch
arg_0= dword ptr  4
sub esp, 3Ch
mov edx, offset aUnknownErro
mov eax, [esp+3Ch+arg_0]
mov ecx, [eax]
sub ecx, 1
cmp ecx, 5
ja short loc_40194D
mov edx, ds:off_409154[ecx*4]
loc_40194D:
fld qword ptr [eax+18h]
fstp [esp+3Ch+var_1C]
fld qword ptr [eax+10h]
fstp [esp+3Ch+var_24]
fld qword ptr [eax+8]
fstp [esp+3Ch+var_2C]
mov eax, [eax+4]
mov [esp+3Ch+var_34], edx
mov [esp+3Ch+var_38], offset a_matherrSInSG
mov [esp+3Ch+var_30], eax
mov eax, ds:_iob
add eax, 40h
mov [esp+3Ch+var_3C], eax
call sub_402750
xor eax, eax
add esp, 3Ch
retn
sub_401930 endp
