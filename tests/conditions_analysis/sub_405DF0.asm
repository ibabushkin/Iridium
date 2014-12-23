sub_405DF0 proc near
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_11= dword ptr -11h
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
arg_0= dword ptr  4
arg_4= word ptr  8
sub esp, 2Ch
mov eax, [esp+2Ch+arg_0]
mov [esp+2Ch+var_C], ebx
lea ebx, [esp+2Ch+var_11]
mov [esp+2Ch+var_8], esi
movzx esi, [esp+2Ch+arg_4]
mov [esp+2Ch+var_4], edi
test eax, eax
cmovnz ebx, eax
mov eax, ds:__mb_cur_max
mov edi, [eax]
call off_408040
mov [esp+2Ch+var_28], esi
mov [esp+2Ch+var_2C], ebx
mov [esp+2Ch+var_20], edi
mov [esp+2Ch+var_24], eax
call sub_405D50
mov ebx, [esp+2Ch+var_C]
mov esi, [esp+2Ch+var_8]
mov edi, [esp+2Ch+var_4]
add esp, 2Ch
retn
sub_405DF0 endp
