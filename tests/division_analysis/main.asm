main proc near
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
var_8= dword ptr -8
var_4= dword ptr -4
push ebp
mov ebp, esp
and esp, 0FFFFFFF0h
sub esp, 20
mov [esp+20h+var_4], 58h
mov ecx, [esp+20h+var_4]
mov edx, 0B21642C9h
mov eax, ecx
imul edx
lea eax, [edx+ecx]
sar eax, 4
mov edx, eax
mov eax, ecx
sar eax, 1Fh
sub edx, eax
mov eax, edx
mov [esp+20h+var_8], eax
mov eax, [esp+20h+var_8]
mov [esp+20h+var_1C], eax
mov [esp+20h+var_20], offset unk_804863C
call _printf
leave
retn
main endp