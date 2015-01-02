public main
main proc near
var_20= dword ptr -20h
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_4], 0
loc_804851D:
add [esp+20h+var_4], 1
cmp [esp+20h+var_4], 2
jnz short loc_8048535
mov [esp+20h+var_20], offset unk_804864C
call _printf
loc_8048535:
mov eax, [esp+20h+var_4]
cdq
shr edx, 1Fh
add eax, edx
and eax, 1
sub eax, edx
cmp eax, 1
jnz short loc_8048555
mov [esp+20h+var_20], offset aLol
call _printf
loc_8048555:
mov [esp+20h+var_20], offset aLlll
call _printf
cmp [esp+20h+var_4], 1
jle short loc_804851D
leave
retn
main endp
