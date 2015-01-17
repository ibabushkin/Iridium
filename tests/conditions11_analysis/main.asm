main proc near
var_20= dword ptr -20h
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_4], 0
mov [esp+20h+var_8], 1
mov [esp+20h+var_C], 2
cmp [esp+20h+var_4], 0
jz short loc_8048542
cmp [esp+20h+var_8], 1
jz short loc_8048542
cmp [esp+20h+var_C], 2
jnz short loc_804854E
loc_8048542:
mov [esp+20h+var_20], offset aTrue
call _printf
loc_804854E:
mov eax, 0
leave
retn
main endp
