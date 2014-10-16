main proc near
var_20= dword ptr -20h
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_4], 0
jmp short loc_8048549
loc_804851F:
mov edx, [esp+20h+var_4]
mov eax, edx
add eax, eax
add eax, edx
mov [esp+20h+var_8], eax
mov eax, [esp+20h+var_8]
and eax, 1
test eax, eax
jnz short loc_8048544
mov [esp+20h+var_20], offset aLul
call _printf
loc_8048544:
add [esp+20h+var_4], 1
loc_8048549:
cmp [esp+20h+var_4], 13h
jle short loc_804851F
leave
retn
main endp
