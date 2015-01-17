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
mov [esp+20h+var_20], offset unk_804861C
call _printf
cmp [esp+20h+var_4], 3
jg short locret_804853D
mov eax, [esp+20h+var_8]
and eax, 1
test eax, eax
jz short loc_8048515
locret_804853D:
leave
retn
main endp
