sub_406760 proc near
var_1C= dword ptr -1Ch
cmp ds:dword_40AD20, 2
jz short loc_406770
rep retn
align 10h
loc_406770:
lea eax, [eax+eax*2]
sub esp, 1C
lea eax, ds:40AD40h[eax*8]
mov [esp+1Ch+var_1C], eax
call ds:LeaveCriticalSection
sub esp, 4
add esp, 1Ch
retn
sub_406760 endp
