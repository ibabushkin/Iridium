public TlsCallback_1
TlsCallback_1 proc near
var_1C= dword ptr -1Ch
var_18= dword ptr -18h
var_14= dword ptr -14h
arg_0= dword ptr  4
arg_4= dword ptr  8
arg_8= dword ptr  0Ch
sub esp, 1Ch
mov eax, [esp+1Ch+arg_4]
test eax, eax
jz short loc_4015A0
cmp eax, 3
jz short loc_4015A0
mov eax, 1
add esp, 1Ch
retn 0Ch
align 10h
loc_4015A0:
mov edx, [esp+1Ch+arg_8]
mov [esp+1Ch+var_18], eax
mov eax, [esp+1Ch+arg_0]
mov [esp+1Ch+var_14], edx
mov [esp+1Ch+var_1C], eax
call sub_402640
mov eax, 1
add esp, 1Ch
retn 0Ch
TlsCallback_1 endp
