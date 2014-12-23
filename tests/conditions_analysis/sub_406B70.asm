sub_406B70 proc near
var_1C= dword ptr -1Ch
var_18= dword ptr -18h
var_14= dword ptr -14h
arg_0= dword ptr  14h
arg_4= dword ptr  18h
push ebp
push edi
push esi
push ebx
sub esp, 1Ch
mov ebx, [esp+1Ch+arg_4]
mov edi, [esp+1Ch+arg_0]
mov eax, ebx
and eax, 3
jnz short loc_406C00
loc_406B86:
sar ebx, 2
test ebx, ebx
jz short loc_406BD1
mov esi, ds:dword_40AD70
test esi, esi
jnz short loc_406BAC
jmp loc_406C4D
align 10h
loc_406BA0:
sar ebx, 1
jz short loc_406BD1
loc_406BA4:
mov edx, [esi]
test edx, edx
jz short loc_406BE0
mov esi, edx
loc_406BAC:
test bl, 1
jz short loc_406BA0
mov [esp+1Ch+var_18], esi
mov [esp+1Ch+var_1C], edi
call sub_406A10
test eax, eax
mov ebp, eax
jz short loc_406C25
mov [esp+1Ch+var_1C], edi
mov edi, ebp
call sub_406890
sar ebx, 1
jnz short loc_406BA4
loc_406BD1:
add esp, 1Ch
mov eax, edi
pop ebx
pop esi
pop edi
pop ebp
retn
align 10h
loc_406BE0:
mov eax, 1
call sub_4066A0
mov ebp, [esi]
test ebp, ebp
jz short loc_406C31
loc_406BF0:
mov eax, 1
mov esi, ebp
call sub_406760
jmp short loc_406BAC
align 10h
loc_406C00:
mov eax, ds:dword_4095E4[eax*4]
mov [esp+1Ch+var_1C], edi
mov [esp+1Ch+var_14], 0
mov [esp+1Ch+var_18], eax
call sub_4068E0
test eax, eax
mov edi, eax
jnz loc_406B86
loc_406C25:
add esp, 1Ch
xor edi, edi
pop ebx
mov eax, edi
pop esi
pop edi
pop ebp
retn
loc_406C31:
mov [esp+1Ch+var_18], esi
mov [esp+1Ch+var_1C], esi
call sub_406A10
test eax, eax
mov ebp, eax
mov [esi], eax
jz short loc_406C25
mov dword ptr [eax], 0
jmp short loc_406BF0
loc_406C4D:
mov eax, 1
call sub_4066A0
mov esi, ds:dword_40AD70
test esi, esi
jz short loc_406C70
loc_406C61:
mov eax, 1
call sub_406760
jmp loc_406BAC
loc_406C70:
mov [esp+1Ch+var_1C], 271h
call sub_4069E0
test eax, eax
mov esi, eax
mov ds:dword_40AD70, eax
jz short loc_406C25
mov dword ptr [eax], 0
jmp short loc_406C61
sub_406B70 endp
