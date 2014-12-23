sub_402340 proc near
var_4C= dword ptr -4Ch
var_30= dword ptr -30h
var_2C= dword ptr -2Ch
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_10= dword ptr -10h
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
sub esp, 4Ch
mov eax, dword_408044
mov [esp+4Ch+var_10], ebx
mov [esp+4Ch+var_C], esi
mov [esp+4Ch+var_8], edi
cmp eax, 0BB40E64Eh
mov [esp+4Ch+var_4], ebp
mov [esp+4Ch+var_2C], 0
mov [esp+4Ch+var_28], 0
jz short loc_402390
not eax
mov dword_408048, eax
loc_402376:
mov ebx, [esp+4Ch+var_10]
mov esi, [esp+4Ch+var_C]
mov edi, [esp+4Ch+var_8]
mov ebp, [esp+4Ch+var_4]
add esp, 4Ch
retn 
align 10h
loc_402390:
lea eax, [esp+4Ch+var_2C]
mov [esp+4Ch+var_4C], eax
call ds:GetSystemTimeAsFileTime
sub esp, 4
mov edi, [esp+4Ch+var_2C]
mov ebp, [esp+4Ch+var_28]
call ds:GetCurrentProcessId
xor edi, ebp
mov esi, eax
call ds:GetCurrentThreadId
mov ebx, eax
call ds:GetTickCount
mov [esp+4Ch+var_30], eax
lea eax, [esp+4Ch+var_24]
mov [esp+4Ch+var_4C], eax
call ds:QueryPerformanceCounter
sub esp, 4
xor edi, [esp+4Ch+var_24]
xor edi, [esp+4Ch+var_20]
xor edi, esi
xor edi, ebx
xor edi, [esp+4Ch+var_30]
cmp edi, 0BB40E64Eh
jz short loc_402400
mov eax, edi
not eax
loc_4023F0:
mov dword_408044, edi
mov dword_408048, eax
jmp loc_402376
loc_402400:
mov eax, 44BF19B0h
mov edi, 0BB40E64Fh
jmp short loc_4023F0
sub_402340 endp
