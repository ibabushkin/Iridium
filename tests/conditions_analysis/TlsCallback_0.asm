TlsCallback_0 proc near
var_18= dword ptr -18h
var_14= dword ptr -14h
var_10= dword ptr -10h
arg_0= dword ptr  8
arg_4= dword ptr  0Ch
arg_8= dword ptr  10h
push ebx
sub esp, 18h
cmp dword_408014, 2
mov eax, [esp+18h+arg_4]
jz short loc_4015EB
mov dword_408014, 2
loc_4015EB:
cmp eax, 2
jz short loc_401601
cmp eax, 1
jz short loc_401630
loc_4015F5:
add esp, 18h
mov eax, 1
pop ebx
retn 0Ch
loc_401601:
mov ebx, offset unk_40C030
cmp ebx, offset unk_40C030
jz short loc_4015F5
db 66h
nop
loc_401610:
mov eax, [ebx]
test eax, eax
jz short loc_401618
call eax
loc_401618:
add ebx, 4
cmp ebx, offset unk_40C030
jnz short loc_401610
add esp, 18h
mov eax, 1
pop ebx
retn 0Ch
align 10h
loc_401630:
mov eax, [esp+18h+arg_8]
mov [esp+18h+var_14], 1
mov [esp+18h+var_10], eax
mov eax, [esp+18h+arg_0]
mov [esp+18h+var_18], eax
call sub_402640
jmp short loc_4015F5
TlsCallback_0 endp
