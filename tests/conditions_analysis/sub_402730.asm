sub_402730 proc near
arg_0= dword ptr  4
arg_4= dword ptr  8
arg_8= dword ptr  0Ch
mov eax, [esp+arg_8]
mov edx, [esp+arg_4]
mov ecx, [esp+arg_0]
lock cmpxchg [ecx], edx
retn 0Ch
sub_402730 endp
