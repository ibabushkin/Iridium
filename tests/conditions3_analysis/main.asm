main proc near
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_4], 0
jmp short loc_8048538
loc_804851F:
mov eax, [esp+20h+var_4]
mov [esp+20h+var_1C], eax
mov [esp+20h+var_20], offset aIteration
call _printf
add [esp+20h+var_4], 1
loc_8048538:
cmp [esp+20h+var_4], 13h
jle short loc_804851F
leave
retn
main endp
