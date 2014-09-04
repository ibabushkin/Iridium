main proc near
var_20=dword ptr -20h
var_8=dword ptr -8
var_4=dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20h
call sub_402320
mov [esp+20h+var_4], 0
mov [esp+20h+var_8], 2
jmp short loc_40156F
loc_401520:
mov eax, [esp+20h+var_4]
cmp eax, [esp+20h+var_8]
jl short loc_401531
cmp [esp+20h+var_8], 2
jnz short loc_401544
loc_401531:
mov [esp+20h+var_20], offset aTrue1
call printf
add [esp+20h+var_4], 1
jmp short loc_401565
loc_401544:
cmp [esp+20h+var_4], 7
jnz short loc_401559
mov [esp+20h+var_20], offset aTrue2
call printf
jmp short loc_401565
loc_401559:
mov [esp+20h+var_20], offset aFalse
call printf
loc_401565:
add [esp+20h+var_4], 1
add [esp+20h+var_8], 1
loc_40156F:
mov eax, [esp+20h+var_4]
cmp eax, [esp+20h+var_8]
jl short loc_401520
mov eax, 0
leave
retn
main endp
