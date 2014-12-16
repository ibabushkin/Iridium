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
jz short loc_804855D
loc_804852F:
mov eax, [esp+20h+var_4]
cmp eax, [esp+20h+var_8]
jz short loc_8048547
mov [esp+20h+var_20], offset aLole
call _printf
jmp short loc_8048553
loc_8048547:
mov [esp+20h+var_20], offset aLoledAgain
call _printf
loc_8048553:
mov eax, [esp+20h+var_4]
cmp eax, [esp+20h+var_8]
jz short loc_804852F
loc_804855D:
mov eax, 0
leave
retn
main endp
