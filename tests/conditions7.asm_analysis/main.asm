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
mov eax, [esp+20h+var_4]
cmp eax, [esp+20h+var_8]
jz short loc_8048545
loc_804852F:
mov [esp+20h+var_20], offset aLoleD
call _printf
mov eax, [esp+20h+var_4]
cmp eax, [esp+20h+var_8]
jz short loc_804852F
loc_8048545:
mov eax, 0
leave
retn
main endp
