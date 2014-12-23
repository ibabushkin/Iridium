sub_402320 proc near
mov ecx, ds:dword_40A05C
test ecx, ecx
jz short loc_402330
rep retn
align 10h
loc_402330:
mov ds:dword_40A05C, 1
jmp short sub_4022D0
sub_402320 endp
