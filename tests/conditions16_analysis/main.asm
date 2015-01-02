public main
main proc near
var_20= dword ptr -20h
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
loc_8048515:
add [esp+20h+var_4], 1
add [esp+20h+var_8], 1
mov eax, [esp+20h+var_4]
cmp eax, [esp+20h+var_8]
jnz short loc_8048535
mov [esp+20h+var_20], offset unk_804862C
call _printf
loc_8048535:
cmp [esp+20h+var_4], 9
jnz short loc_8048515
cmp [esp+20h+var_8], 7
jz short loc_8048515
leave
retn
main endp
