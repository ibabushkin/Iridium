sub_406300 proc near
var_18= dword ptr -18h
arg_0= dword ptr  8
push ebx
xor ebx, ebx
sub esp, 18h
mov ecx, [esp+18h+arg_0]
cmp ecx, 13h
jle short loc_406320
mov eax, 4
loc_406314:
add eax, eax
add ebx, 1
lea edx, [eax+0Fh]
cmp edx, ecx
jl short loc_406314
loc_406320:
mov [esp+18h+var_18], ebx
call sub_4067D0
mov [eax], ebx
add esp, 18h
add eax, 4
pop ebx
retn
sub_406300 endp
