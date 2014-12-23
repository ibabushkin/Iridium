sub_4028D0 proc near
var_28= dword ptr -28h
var_24= dword ptr -24h
var_C= dword ptr -0Ch
push ebx
sub esp, 28h
mov ecx, [edx+4]
test ch, 40h
jnz short loc_4028E4
mov ebx, [edx+20h]
cmp [edx+24h], ebx
jle short loc_4028F4
loc_4028E4:
and ch, 20h
jnz short loc_402900
mov ebx, [edx]
mov ecx, [edx+20h]
mov [ebx+ecx], al
mov ebx, [edx+20h]
loc_4028F4:
add ebx, 1
mov [edx+20h], ebx
add esp, 28h
pop ebx
retn 
align 10h
loc_402900:
mov ecx, [edx]
mov [esp+28h+var_28], eax
mov [esp+28h+var_C], edx
mov [esp+28h+var_24], ecx
call fputc
mov edx, [esp+28h+var_C]
mov ebx, [edx+20h]
add ebx, 1
mov [edx+20h], ebx
add esp, 28h
pop ebx
retn
sub_4028D0 endp
