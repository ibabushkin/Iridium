sub_406390 proc near
arg_0= dword ptr  4
mov eax, [esp+arg_0]
mov edx, 1
mov ecx, [eax-4]
shl edx, cl
mov [eax], ecx
mov [eax+4], edx
sub eax, 4
mov [esp+arg_0], eax
jmp sub_406890
sub_406390 endp
