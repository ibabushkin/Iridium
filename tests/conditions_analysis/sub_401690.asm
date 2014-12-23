sub_401690 proc near
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_10= dword ptr -10h
var_C= dword ptr -0Ch
arg_0= dword ptr  8
push ebx
sub esp, 28h
mov eax, ds:dword_40AD90
mov [esp+28h+var_28], eax
call sub_401670
cmp eax, 0FFFFFFFFh
mov [esp+28h+var_10], eax
jz loc_401730
mov [esp+28h+var_28], 8
call _lock
mov eax, ds:dword_40AD90
mov [esp+28h+var_28], eax
call sub_401670
mov [esp+28h+var_10], eax
mov eax, ds:dword_40AD8C
mov [esp+28h+var_28], eax
call sub_401670
mov [esp+28h+var_C], eax
lea eax, [esp+28h+var_C]
mov [esp+28h+var_20], eax
lea eax, [esp+28h+var_10]
mov [esp+28h+var_24], eax
mov eax, [esp+28h+arg_0]
mov [esp+28h+var_28], eax
call __dllonexit
mov ebx, eax
mov eax, [esp+28h+var_10]
mov [esp+28h+var_28], eax
call sub_401680
mov ds:dword_40AD90, eax
mov eax, [esp+28h+var_C]
mov [esp+28h+var_28], eax
call sub_401680
mov [esp+28h+var_28], 8
mov ds:dword_40AD8C, eax
call _unlock
add esp, 28h
mov eax, ebx
pop ebx
retn 
align 10h
loc_401730:
mov eax, [esp+28h+arg_0]
mov [esp+28h+var_28], eax
call ds:_onexit
add esp, 28h
mov ebx, eax
mov eax, ebx
pop ebx
retn
sub_401690 endp
