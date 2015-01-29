main proc near
var_90= dword ptr -90h
var_80= dword ptr -80h
var_30= dword ptr -30h
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 90
mov [esp+90h+var_4], 0
mov [esp+90h+var_8], 0
jmp short loc_804856E
loc_8048530:
cmp [esp+90h+var_4], 9
jg short loc_804854C
mov eax, [esp+90h+var_4]
mov edx, [esp+90h+var_4]
mov [esp+eax*4+90h+var_30], edx
loc_804854C:
mov eax, [esp+90h+var_8]
mov edx, [esp+90h+var_8]
mov [esp+eax*4+90h+var_80], edx
add [esp+90h+var_4], 1
add [esp+90h+var_8], 1
loc_804856E:
cmp [esp+90h+var_8], 13h
jle short loc_8048530
mov [esp+90h+var_90], offset aLolData___
call _printf
leave
retn
main endp
