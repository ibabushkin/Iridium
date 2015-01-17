main proc near
var_20= dword ptr -20h
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_4], 1
mov [esp+20h+var_8], 2
mov eax, [esp+20h+var_4]
cmp eax, [esp+20h+var_8]
jnz short loc_804853D
mov [esp+20h+var_20], offset unk_804864C
call _printf
jmp short locret_8048561
loc_804853D:
mov eax, [esp+20h+var_4]
cmp eax, [esp+20h+var_8]
jle short loc_8048555
mov [esp+20h+var_20], offset aLol
call _printf
jmp short locret_8048561
loc_8048555:
mov [esp+20h+var_20], offset aLol3
call _printf
locret_8048561:
leave
retn
main endp
