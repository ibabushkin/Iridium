sub_402790 proc near
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
arg_0= dword ptr  4
arg_4= dword ptr  8
arg_8= dword ptr  0Ch
sub esp, 2Ch
mov eax, [esp+2Ch+arg_8]
mov [esp+2Ch+var_24], 0
mov [esp+2Ch+var_2C], 6000h
mov [esp+2Ch+var_1C], eax
mov eax, [esp+2Ch+arg_4]
mov [esp+2Ch+var_20], eax
mov eax, [esp+2Ch+arg_0]
mov [esp+2Ch+var_28], eax
call sub_403E40
add esp, 2Ch
retn
sub_402790 endp
