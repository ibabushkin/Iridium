main proc near
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_8], 14h
mov eax, [esp+20h+var_8]
shl eax, 2
mov [esp+20h+var_20], eax
call _malloc
mov [esp+20h+var_C], eax
mov [esp+20h+var_4], 0
jmp short loc_80485C6
loc_80485AA:
mov eax, [esp+20h+var_4]
lea edx, ds:0[eax*4]
mov eax, [esp+20h+var_C]
add edx, eax
mov eax, [esp+20h+var_4]
mov [edx], eax
add [esp+20h+var_4], 1
loc_80485C6:
cmp [esp+20h+var_4], 13h
jle short loc_80485AA
mov eax, [esp+20h+var_4]
mov [esp+20h+var_1C], eax
mov [esp+20h+var_20], offset unk_80486DC
call _printf
mov eax, [esp+20h+var_C]
mov [esp+20h+var_20], eax
call _free
mov eax, 0
leave
retn
main endp
