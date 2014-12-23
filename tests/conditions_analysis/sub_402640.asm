sub_402640 proc near
var_1C= dword ptr -1Ch
arg_4= dword ptr  8
sub esp, 1Ch
mov eax, [esp+1Ch+arg_4]
cmp eax, 1
jz short loc_402690
jb short loc_402660
cmp eax, 3
jz short loc_4026B0
loc_402653:
mov eax, 1
add esp, 1Ch
retn 
align 10h
loc_402660:
mov eax, ds:dword_40A3A0
test eax, eax
jnz short loc_4026D2
loc_402669:
mov eax, ds:dword_40A3A0
cmp eax, 1
jnz short loc_402653
mov ds:dword_40A3A0, 0
mov [esp+1Ch+var_1C], offset unk_40A3A4
call ds:DeleteCriticalSection
sub esp, 4
jmp short loc_402653
align 10h
loc_402690:
mov eax, ds:dword_40A3A0
test eax, eax
jz short loc_4026C0
loc_402699:
mov ds:dword_40A3A0, 1
mov eax, 1
add esp, 1Ch
retn 
align 10h
loc_4026B0:
mov eax, ds:dword_40A3A0
test eax, eax
jz short loc_402653
call sub_4024A0
jmp short loc_402653
loc_4026C0:
mov [esp+1Ch+var_1C], offset unk_40A3A4
call ds:InitializeCriticalSection
sub esp, 4
jmp short loc_402699
loc_4026D2:
call sub_4024A0
jmp short loc_402669
sub_402640 endp
