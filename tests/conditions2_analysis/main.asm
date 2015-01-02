public main
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
jnz short loc_804853A
mov [esp+20h+var_20], offset unk_804863C
call _printf
jmp short loc_8048546
loc_804853A:
mov [esp+20h+var_20], offset aLol2
call _printf
loc_8048546:
cmp [esp+20h+var_8], 1
jz short loc_8048559
mov [esp+20h+var_20], offset aLol
call _printf
loc_8048559:
mov eax, 0
leave
retn
main endp
