sub_4024A0 proc near
var_1C= dword ptr -1Ch
push ebp
push edi
push esi
push ebx
sub esp, 1C
mov [esp+1Ch+var_1C], offset unk_40A3A4
call ds:EnterCriticalSection
mov ebx, ds:dword_40A3BC
mov ebp, ds:TlsGetValue
mov edi, ds:GetLastError
sub esp, 4
test ebx, ebx
jz short loc_4024F5
lea esi, [esi+0]
loc_4024D0:
mov eax, [ebx]
mov [esp+1Ch+var_1C], eax
call eb
sub esp, 4
mov esi, eax
call ed
test eax, eax
jnz short loc_4024EE
test esi, esi
jz short loc_4024EE
mov eax, [ebx+4]
mov [esp+1Ch+var_1C], esi
call eax
loc_4024EE:
mov ebx, [ebx+8]
test ebx, ebx
jnz short loc_4024D0
loc_4024F5:
mov [esp+1Ch+var_1C], offset unk_40A3A4
call ds:LeaveCriticalSection
sub esp, 4
add esp, 1Ch
pop ebx
pop esi
pop edi
pop ebp
retn
sub_4024A0 endp
