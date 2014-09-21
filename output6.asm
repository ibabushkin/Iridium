main proc near
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_8], 1
mov [esp+20h+var_4], 2
loc_8048525:
cmp [esp+20h+var_8], 1
jnz short loc_8048531
sub [esp+20h+var_4], 1
loc_8048531:
cmp [esp+20h+var_4], 1
jnz short loc_8048554
mov eax, [esp+20h+var_4]
mov edx, [esp+20h+var_8]
sub edx, eax
mov eax, edx
mov [esp+20h+var_1C], eax
mov [esp+20h+var_20], offset unk_804863C
call _printf
loc_8048554:
mov eax, [esp+20h+var_8]
cmp eax, [esp+20h+var_4]
jnz short loc_8048525
leave
retn
main endp