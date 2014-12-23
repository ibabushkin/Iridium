sub_401180 proc near
var_8C= dword ptr -8Ch
var_88= dword ptr -88h
var_84= dword ptr -84h
var_80= dword ptr -80h
var_7C= dword ptr -7Ch
var_78= dword ptr -78h
var_6E= dword ptr -6Eh
var_5C= dword ptr -5Ch
var_30= byte ptr -30h
var_2C= word ptr -2Ch
var_C= dword ptr -0Ch
push ebp
xor eax, eax
mov ebp, esp
mov ecx, 11h
push edi
push esi
lea edx, [ebp+var_5C]
push ebx
mov edi, edx
sub esp, 7Ch
rep stosd
mov al, 30h
call sub_4026E0
sub esp, eax
lea eax, [esp+88h+var_6E+1]
and eax, 0FFFFFFF0h
mov dword ptr [eax], 0CCCCCCCCh
mov dword ptr [eax+4], 0CCCCCCCCh
mov dword ptr [eax+8], 0CCCCCCCCh
mov dword ptr [eax+0Ch], 0CCCCCCCCh
mov dword ptr [eax+10h], 0CCCCCCCCh
mov dword ptr [eax+14h], 0CCCCCCCCh
mov dword ptr [eax+18h], 0CCCCCCCCh
mov dword ptr [eax+1Ch], 0CCCCCCCCh
and esp, 0FFFFFFF0h
mov eax, ds:dword_40A03C
test eax, eax
jnz loc_401480
loc_4011EE:
mov eax, large fs:18h
mov esi, ds:Sleep
mov ebx, [eax+4]
jmp short loc_401214
align 10h
loc_401200:
cmp eax, ebx
jz loc_401430
mov [esp+88h+var_88], 3E8h
call esi
sub esp, 4
loc_401214:
mov [esp+8Ch+var_84], 0
mov [esp+8Ch+var_88], ebx
mov [esp+8Ch+var_8C], offset dword_40AD94
call sub_402730
sub esp, 0Ch
test eax, eax
jnz short loc_401200
mov eax, ds:dword_40AD98
xor ebx, ebx
cmp eax, 1
jz loc_401443
loc_401243:
mov eax, ds:dword_40AD98
test eax, eax
jz loc_401491
mov ds:dword_40A000, 1
loc_40125A:
mov eax, ds:dword_40AD98
cmp eax, 1
jz loc_40145D
loc_401268:
test ebx, ebx
jnz short loc_401273
lock xchg ebx, ds:dword_40AD94
loc_401273:
mov eax, ds:off_409034
test eax, eax
jz short loc_401298
mov [esp+8Ch+var_84], 0
mov [esp+8Ch+var_88], 2
mov [esp+8Ch+var_8C], 0
call ea
sub esp, 0C
loc_401298:
call sub_401C40
mov [esp+8Ch+var_8C], offset loc_401770
call ds:SetUnhandledExceptionFilter
sub esp, 4
mov ds:dword_40A044, eax
call sub_4021D0
mov [esp+8Ch+var_88], offset a_set_invalid_
mov [esp+8Ch+var_8C], eax
call ds:GetProcAddress
sub esp, 8
test eax, eax
jz short loc_4012D8
mov [esp+8Ch+var_8C], offset dword_401000
call ea
loc_4012D8:
call sub_402290
mov eax, ds:_acmdln
xor ecx, ecx
mov ds:dword_40AD88, 400000h
mov eax, [eax]
test eax, eax
jnz short loc_40130A
jmp short loc_401334
loc_4012F6:
test dl, dl
jz short loc_40132F
test ecx, ecx
lea esi, [esi+0]
jz short loc_401324
mov ecx, 1
loc_401307:
add eax, 1
loc_40130A:
movzx edx, byte ptr [eax]
cmp dl, 20h
jle short loc_4012F6
mov ebx, ecx
xor ebx, 1
cmp dl, 22h
cmovz ecx, ebx
jmp short loc_401307
align 10h
loc_401320:
test dl, dl
jz short loc_40132F
loc_401324:
add eax, 1
movzx edx, byte ptr [eax]
cmp dl, 20h
jle short loc_401320
loc_40132F:
mov ds:dword_40AD84, eax
loc_401334:
mov eax, ds:dword_40A03C
test eax, eax
jz short loc_401352
movzx edx, [ebp+var_2C]
mov eax, 0Ah
test [ebp+var_30], 1
cmovnz eax, edx
mov dword_408000, eax
loc_401352:
mov edx, ds:dword_40A004
xor ebx, ebx
lea eax, ds:4[edx*4]
mov [ebp+var_6E+2], edx
mov [esp+80h+var_80], eax
call malloc
mov edi, ds:dword_40A008
mov [ebp-70h], eax
mov eax, [ebp+var_6E+2]
test eax, eax
jle short loc_4013BA
lea esi, [esi+0]
loc_401380:
mov eax, [edi+ebx*4]
mov [esp+80h+var_80], eax
call strlen
lea esi, [eax+1]
mov [esp+80h+var_80], esi
call malloc
mov edx, [ebp-70h]
mov [edx+ebx*4], eax
mov edx, [edi+ebx*4]
add ebx, 1
mov [esp+80h+var_78], esi
mov [esp+80h+var_80], eax
mov [esp+80h+var_7C], edx
call memcpy
cmp ebx, [ebp+var_6E+2]
jnz short loc_401380
shl ebx, 2
loc_4013BA:
mov eax, [ebp-70h]
mov dword ptr [eax+ebx], 0
mov ds:dword_40A008, eax
call sub_402320
mov eax, ds:__initenv
mov edx, ds:dword_40A00C
mov [eax], edx
mov eax, ds:dword_40A00C
mov [esp+80h+var_78], eax
mov eax, ds:dword_40A008
mov [esp+80h+var_7C], eax
mov eax, ds:dword_40A004
mov [esp+80h+var_80], eax
call main
mov esi, ds:dword_40A014
test esi, esi
mov ds:dword_40A010, eax
jz loc_4014B4
mov ebx, ds:dword_40A000
test ebx, ebx
jnz short loc_401421
call _cexit
mov eax, ds:dword_40A010
loc_401421:
lea esp, [ebp-0Ch]
pop ebx
pop esi
pop edi
pop ebp
retn 
align 10h
loc_401430:
mov eax, ds:dword_40AD98
mov ebx, 1
cmp eax, 1
jnz loc_401243
loc_401443:
mov [esp+88h+var_88], 1Fh
call _amsg_exit
mov eax, ds:dword_40AD98
cmp eax, 1
jnz loc_401268
loc_40145D:
mov [esp+88h+var_84], offset unk_40C008
mov [esp+88h+var_88], offset unk_40C000
call _initterm
mov ds:dword_40AD98, 2
jmp loc_401268
loc_401480:
mov [esp+88h+var_88], edx
call ds:GetStartupInfoA
sub esp, 4
jmp loc_4011EE
loc_401491:
mov ds:dword_40AD98, 1
mov [esp+8Ch+var_88], offset unk_40C018
mov [esp+8Ch+var_8C], offset unk_40C00C
call _initterm
jmp loc_40125A
loc_4014B4:
mov [esp+80h+var_80], eax
call exit
sub_401180 endp
