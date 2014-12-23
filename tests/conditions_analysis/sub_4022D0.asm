sub_4022D0 proc near
var_18= dword ptr -18h
push ebx
sub esp, 18h
mov ebx, ds:dword_407750
cmp ebx, 0FFFFFFFFh
jz short loc_402303
loc_4022DF:
test ebx, ebx
jz short loc_4022F2
loc_4022E3:
call ds:dword_407750[ebx*4]
sub ebx, 1
lea esi, [esi+0]
jnz short loc_4022E3
loc_4022F2:
mov [esp+18h+var_18], offset dword_4022A0
call sub_401750
add esp, 18h
pop ebx
retn
loc_402303:
xor ebx, ebx
jmp short loc_402309
loc_402307:
mov ebx, eax
loc_402309:
lea eax, [ebx+1]
mov edx, ds:dword_407750[eax*4]
test edx, edx
jnz short loc_402307
jmp short loc_4022DF
sub_4022D0 endp
