sub_4068E0 proc near
var_38= dword ptr -38h
var_34= dword ptr -34h
var_30= dword ptr -30h
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_1C= dword ptr -1Ch
arg_0= dword ptr  8
arg_4= dword ptr  0Ch
arg_8= dword ptr  10h
push ebp
xor ecx, ecx
push edi
push esi
push ebx
sub esp, 2Ch
mov eax, [esp+38h+arg_0]
mov ebx, [esp+38h+arg_0]
mov eax, [eax+10h]
add ebx, 14h
mov [esp+38h+var_1C], eax
mov eax, [esp+38h+arg_8]
mov edi, eax
mov ebp, eax
mov eax, [esp+38h+arg_4]
sar ebp, 1Fh
mov esi, edi
mov edi, ebp
mov ebp, ecx
mov ecx, ebx
mov edx, eax
sar edx, 1Fh
mov [esp+38h+var_28], eax
mov [esp+38h+var_24], edx
nop
loc_406920:
mov eax, [ecx+ebp*4]
mov ebx, [esp+38h+var_24]
imul ebx, eax
mul [esp+38h+var_28]
add edx, ebx
add eax, esi
adc edx, edi
xor edi, edi
mov [ecx+ebp*4], eax
add ebp, 1
mov esi, edx
cmp [esp+38h+var_1C], ebp
jg short loc_406920
mov ebp, edi
mov edi, edx
mov ecx, ebp
or ecx, edx
jz short loc_40696F
mov eax, [esp+38h+arg_0]
mov ecx, [esp+38h+var_1C]
cmp ecx, [eax+8]
jge short loc_406980
loc_40695B:
mov ecx, [esp+38h+var_1C]
mov eax, [esp+38h+arg_0]
mov [eax+ecx*4+14h], edi
mov edi, ecx
add edi, 1
mov [eax+10h], edi
loc_40696F:
mov eax, [esp+38h+arg_0]
add esp, 2Ch
pop ebx
pop esi
pop edi
pop ebp
retn 
align 10h
loc_406980:
mov eax, [eax+4]
mov [esp+38h+var_20], eax
add eax, 1
mov [esp+38h+var_38], eax
call sub_4067D0
test eax, eax
mov ebx, eax
jz short loc_4069D2
mov ecx, [esp+38h+arg_0]
lea eax, [eax+0Ch]
mov edx, [ecx+10h]
mov [esp+38h+var_38], eax
lea ecx, ds:8[edx*4]
mov edx, [esp+38h+arg_0]
mov [esp+38h+var_30], ecx
add edx, 0Ch
mov [esp+38h+var_34], edx
call memcpy
mov eax, [esp+38h+arg_0]
mov [esp+38h+var_38], eax
call sub_406890
mov [esp+38h+arg_0], ebx
jmp short loc_40695B
loc_4069D2:
mov [esp+38h+arg_0], 0
jmp short loc_40696F
sub_4068E0 endp
