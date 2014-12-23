sub_4066A0 proc near
var_18= dword ptr -18h
push esi
mov esi, eax
push ebx
sub esp, 14
mov edx, ds:dword_40AD20
cmp edx, 2
jz short loc_4066F7
test edx, edx
jnz short loc_40671E
mov dl, 1
lock xchg edx, ds:dword_40AD20
test edx, edx
jnz short loc_406713
mov ebx, ds:InitializeCriticalSection
mov [esp+18h+var_18], offset unk_40AD40
call eb
sub esp, 4
mov [esp+18h+var_18], offset unk_40AD58
call eb
sub esp, 4
mov [esp+18h+var_18], offset dword_406790
call sub_401750
mov ds:dword_40AD20, 2
loc_4066F7:
lea eax, [esi+esi*2]
lea eax, ds:40AD40h[eax*8]
mov [esp+18h+var_18], eax
call ds:EnterCriticalSection
sub esp, 4
add esp, 14h
pop ebx
pop esi
retn 
loc_406713:
cmp edx, 2
jz short loc_406752
mov edx, ds:dword_40AD20
loc_40671E:
cmp edx, 1
jnz short loc_406747
mov ebx, ds:Sleep
lea esi, [esi+0]
loc_406730:
mov [esp+18h+var_18], 1
call eb
mov edx, ds:dword_40AD20
sub esp, 4
cmp edx, 1
jz short loc_406730
loc_406747:
cmp edx, 2
jz short loc_4066F7
add esp, 14h
pop ebx
pop esi
retn
loc_406752:
mov ds:dword_40AD20, 2
jmp short loc_4066F7
sub_4066A0 endp
