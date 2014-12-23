sub_4019A0 proc near
var_18= dword ptr -18h
var_14= dword ptr -14h
var_10= dword ptr -10h
arg_0= dword ptr  8
arg_4= dword ptr  0Ch
push ebx
sub esp, 18h
mov eax, ds:_iob
mov [esp+18h+var_14], offset aMingwW64Runti
lea ebx, [esp+18h+arg_4]
add eax, 40h
mov [esp+18h+var_18], eax
call sub_402750
mov eax, [esp+18h+arg_0]
mov [esp+18h+var_10], ebx
mov [esp+18h+var_14], eax
mov eax, ds:_iob
add eax, 40h
mov [esp+18h+var_18], eax
call sub_402790
call abort
jmp short sub_4019F0
sub_4019A0 endp
