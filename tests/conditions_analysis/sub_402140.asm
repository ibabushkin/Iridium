sub_402140 proc near
var_8= dword ptr -8
var_4= dword ptr -4
arg_0= dword ptr  10h
push edi
push esi
push ebx
sub esp, 8
mov [esp+8+var_8], 400000h
mov ebx, [esp+8+arg_0]
call sub_401EF0
test eax, eax
jz short loc_4021C0
mov eax, ds:40003Ch
xor edi, edi
mov esi, [eax+400080h]
test esi, esi
jz short loc_4021B1
mov [esp+8+var_4], esi
mov [esp+8+var_8], 400000h
call sub_401F20
test eax, eax
jz short loc_4021B1
mov edx, esi
add edx, 400000h
jnz short loc_402196
jmp short loc_4021B1
align 10h
loc_402190:
sub ebx, 1
add edx, 14h
loc_402196:
mov ecx, [edx+4]
test ecx, ecx
jnz short loc_4021A4
mov eax, [edx+0Ch]
test eax, eax
jz short loc_4021C0
loc_4021A4:
test ebx, ebx
jg short loc_402190
mov edi, [edx+0Ch]
add edi, 400000h
loc_4021B1:
add esp, 8
mov eax, edi
pop ebx
pop esi
pop edi
retn
align 10h
loc_4021C0:
add esp, 8
xor edi, edi
mov eax, edi
pop ebx
pop esi
pop edi
retn
sub_402140 endp
