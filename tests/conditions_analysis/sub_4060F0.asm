sub_4060F0 proc near
var_3C= dword ptr -3Ch
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_E= dword ptr -0Eh
var_8= dword ptr -8
var_4= dword ptr -4
arg_0= dword ptr  4
arg_4= dword ptr  8
arg_8= dword ptr  0Ch
arg_C= dword ptr  10h
sub esp, 3Ch
mov eax, [esp+3Ch+arg_0]
mov [esp+3Ch+var_8], esi
lea esi, [esp+3Ch+var_E]
mov [esp+3Ch+var_E+2], ebx
mov ebx, [esp+3Ch+arg_C]
mov [esp+3Ch+var_4], edi
test eax, eax
cmovnz esi, eax
mov eax, ds:__mb_cur_max
mov word ptr [esp+3Ch+var_E], 0
mov edi, [eax]
call off_408040
test ebx, ebx
mov edx, offset unk_40A3C4
cmovz ebx, edx
mov [esp+3Ch+var_30], ebx
mov [esp+3Ch+var_28], edi
mov [esp+3Ch+var_3C], esi
mov [esp+3Ch+var_2C], eax
mov eax, [esp+3Ch+arg_8]
mov [esp+3Ch+var_34], eax
mov eax, [esp+3Ch+arg_4]
mov [esp+3Ch+var_38], eax
call sub_405F50
mov ebx, [esp+3Ch+var_E+2]
mov esi, [esp+3Ch+var_8]
mov edi, [esp+3Ch+var_4]
add esp, 3Ch
retn
sub_4060F0 endp
