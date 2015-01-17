main proc near
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_4], 0
mov [esp+20h+var_8], 0
jmp short loc_8048540
loc_8048527:
mov eax, [esp+20h+var_4]
mov [esp+20h+var_1C], eax
mov [esp+20h+var_20], offset unk_804863C
call _printf
add [esp+20h+var_4], 1
loc_8048540:
cmp [esp+20h+var_4], 1
jle short loc_8048527
cmp [esp+20h+var_8], 1
jle short loc_8048527
mov eax, 0
leave
retn
main endp
