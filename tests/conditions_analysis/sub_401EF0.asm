sub_401EF0 proc near
arg_0= dword ptr  4
mov edx, [esp+arg_0]
xor eax, eax
cmp word ptr [edx], 5A4Dh
jz short loc_401F00
locret_401EFD:
rep retn
align 10h
loc_401F00:
add edx, [edx+3Ch]
cmp dword ptr [edx], 4550h
jnz short locret_401EFD
xor eax, eax
cmp word ptr [edx+18h], 10Bh
setz al
retn
sub_401EF0 endp
