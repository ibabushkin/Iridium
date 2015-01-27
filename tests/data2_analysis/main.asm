main proc near
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_8], 7
lea eax, [esp+20h+var_8]
mov [esp+20h+var_4], eax
mov eax, [esp+20h+var_4]
mov [esp+20h+var_1C], eax
mov [esp+20h+var_20], offset unk_804861C
call _printf
mov eax, 0
leave
retn
main endp
