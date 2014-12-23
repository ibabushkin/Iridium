sub_407500 proc near
var_28= dword ptr -28h
var_24= dword ptr -24h
var_20= dword ptr -20h
var_10= dword ptr -10h
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
arg_0= dword ptr  4
arg_4= dword ptr  8
arg_8= dword ptr  0Ch
arg_C= dword ptr  10h
sub esp, 2Ch
mov [esp+2Ch+var_C], esi
mov esi, [esp+2Ch+arg_C]
mov eax, [esp+2Ch+arg_0]
mov [esp+2Ch+var_10], ebx
mov ecx, [esp+2Ch+arg_8]
mov ebx, [esp+2Ch+arg_4]
test esi, esi
mov [esp+2Ch+var_8], edi
mov [esp+2Ch+var_4], ebp
mov edi, ecx
mov ebp, eax
mov [esp+2Ch+var_24], eax
mov edx, ebx
jnz short loc_407550
cmp ecx, ebx
jbe short loc_407572
div ecx
loc_407537:
mov eax, edx
xor edx, edx
loc_40753B:
mov ebx, [esp+2Ch+var_10]
mov esi, [esp+2Ch+var_C]
mov edi, [esp+2Ch+var_8]
mov ebp, [esp+2Ch+var_4]
add esp, 2Ch
retn
align 10h
loc_407550:
cmp esi, ebx
ja short loc_407590
bsr eax, esi
xor eax, 1Fh
mov [esp+2Ch+var_28], eax
jnz short loc_407594
cmp ecx, ebp
ja loc_407628
loc_407568:
mov edx, ebx
sub ebp, ecx
sbb edx, esi
mov eax, ebp
jmp short loc_40753B
loc_407572:
test ecx, ecx
jnz short loc_407581
mov eax, 1
xor edx, edx
div ecx
mov ecx, eax
loc_407581:
mov eax, ebx
xor edx, edx
div ecx
mov eax, ebp
div ecx
jmp short loc_407537
align 10h
loc_407590:
mov edx, ebx
jmp short loc_40753B
loc_407594:
movzx ecx, byte ptr [esp+2Ch+var_28]
mov eax, esi
mov esi, 20h
sub esi, [esp+2Ch+var_28]
mov ebp, edi
mov edx, ebx
shl eax, cl
mov ecx, esi
shr ebp, cl
movzx ecx, byte ptr [esp+2Ch+var_28]
or ebp, eax
mov eax, [esp+2Ch+var_24]
shl edi, cl
mov ecx, esi
shr edx, cl
movzx ecx, byte ptr [esp+2Ch+var_28]
mov [esp+2Ch+var_20], edi
shl ebx, cl
mov ecx, esi
shr eax, cl
movzx ecx, byte ptr [esp+2Ch+var_28]
or eax, ebx
mov ebx, [esp+2Ch+var_24]
div ebp
shl ebx, cl
mov [esp+2Ch+var_24], ebx
mov ebx, edx
mul edi
cmp ebx, edx
mov edi, eax
mov ecx, edx
jb short loc_40761C
cmp [esp+2Ch+var_24], eax
jb short loc_407618
loc_4075F3:
mov eax, [esp+2Ch+var_24]
sub eax, edi
sbb ebx, ecx
movzx ecx, byte ptr [esp+2Ch+var_28]
mov edx, ebx
shr eax, cl
mov ecx, esi
shl edx, cl
movzx ecx, byte ptr [esp+2Ch+var_28]
or eax, edx
mov edx, ebx
shr edx, cl
jmp loc_40753B
loc_407618:
cmp ebx, edx
jnz short loc_4075F3
loc_40761C:
mov ecx, edx
mov edi, eax
sub edi, [esp+2Ch+var_20]
sbb ecx, ebp
jmp short loc_4075F3
loc_407628:
cmp esi, ebx
jb loc_407568
mov eax, ebp
jmp loc_40753B
sub_407500 endp
