sub_4026E0 proc near
arg_0= dword ptr  0Ch
push ecx
push eax
cmp eax, 1000h
lea ecx, [esp+arg_0]
jb short loc_402702
loc_4026ED:
sub ecx, 1000h
or dword ptr [ecx], 0
sub eax, 1000h
cmp eax, 1000h
ja short loc_4026ED
loc_402702:
sub ecx, eax
or dword ptr [ecx], 0
pop eax
pop ecx
retn
sub_4026E0 endp
