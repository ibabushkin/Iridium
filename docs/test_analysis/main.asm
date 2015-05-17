main proc near
var_2C= dword ptr -2Ch
var_18= dword ptr -18h
var_14= dword ptr -14h
var_10= dword ptr -10h
var_C= dword ptr -0Ch
var_4= dword ptr -4
arg_0= dword ptr  4
lea ecx, [esp+arg_0]
and esp, 0FFFFFFF0h
push dword ptr [ecx-4]
push ebp
mov ebp, esp
push ecx
sub esp, 34h
sub esp, 0Ch
push offset aEingabeInBuffe
call _puts
add esp, 10h
sub esp, 8
lea eax, [ebp+var_2C]
push eax
push offset a20s
call ___isoc99_scanf
add esp, 10h
sub esp, 0Ch
push offset aAnzahlSchleife
call _puts
add esp, 10h
sub esp, 8
lea eax, [ebp+var_14]
push eax
push offset aD
call ___isoc99_scanf
add esp, 10h
mov [ebp+var_C], 0
jmp short loc_8048630
loc_80485C7:
sub esp, 0Ch
push offset aAnzahlInnererS
call _puts
add esp, 10h
sub esp, 8
lea eax, [ebp+var_18]
push eax
push offset aD
call ___isoc99_scanf
add esp, 10h
mov [ebp+var_10], 0
jmp short loc_8048624
loc_80485F4:
mov eax, [ebp+var_10]
and eax, 1
test eax, eax
jnz short loc_8048610
sub esp, 0Ch
push offset aDGerade_
call _puts
add esp, 10h
jmp short loc_8048620
loc_8048610:
sub esp, 0Ch
push offset aDUngerade_
call _puts
add esp, 10h
loc_8048620:
add [ebp+var_10], 1
loc_8048624:
mov eax, [ebp+var_18]
cmp [ebp+var_10], eax
jl short loc_80485F4
add [ebp+var_C], 1
loc_8048630:
mov eax, [ebp+var_14]
cmp [ebp+var_C], eax
jl short loc_80485C7
mov eax, 0
mov ecx, [ebp+var_4]
leave
lea esp, [ecx-4]
retn
main endp
