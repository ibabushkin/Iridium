main proc near
var_20= dword ptr -20h
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_4], 0
mov [esp+20h+var_8], 1
cmp [esp+20h+var_4], 0
jnz short locret_804853F
cmp [esp+20h+var_8], 1
jnz short locret_804853F
mov [esp+20h+var_20], offset unk_804862C
call _printf
locret_804853F:
leave
retn
main endp
