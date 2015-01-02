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
mov [esp+20h+var_8], 0
jmp short loc_804853D
loc_8048527:
mov [esp+20h+var_20], offset unk_804865C
call _printf
add [esp+20h+var_4], 1
add [esp+20h+var_8], 1
loc_804853D:
cmp [esp+20h+var_4], 2
jle short loc_8048527
cmp [esp+20h+var_8], 2
jle short loc_8048527
cmp [esp+20h+var_4], 7
jnz short loc_8048559
cmp [esp+20h+var_8], 3
jz short loc_8048567
loc_8048559:
cmp [esp+20h+var_4], 1
jz short loc_8048567
cmp [esp+20h+var_8], 4
jnz short locret_8048573
loc_8048567:
mov [esp+20h+var_20], offset unk_804865C
call _printf
locret_8048573:
leave
retn
main endp
