sub_407640 proc near
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
mov edx, [esp+2Ch+arg_C]
mov [esp+2Ch+var_8], edi
mov ecx, [esp+2Ch+arg_8]
mov edi, [esp+2Ch+arg_0]
mov [esp+2Ch+var_10], ebx
mov ebx, [esp+2Ch+arg_4]
test edx, edx
mov [esp+2Ch+var_C], esi
mov esi, ecx
mov [esp+2Ch+var_4], ebp
mov ebp, edi
jnz short loc_407690
cmp ecx, ebx
ja short loc_4076C8
test ecx, ecx
jnz short loc_40767E
mov eax, 1
xor edx, edx
div ecx
mov ecx, eax
loc_40767E:
mov eax, ebx
xor edx, edx
div ecx
mov ebx, eax
mov eax, edi
div ecx
mov edx, ebx
jmp short loc_4076B4
align 10h
loc_407690:
cmp edx, ebx
ja short loc_4076B0
bsr edi, edx
xor edi, 1Fh
jnz short loc_4076D2
cmp ecx, ebp
jbe loc_407733
cmp edx, ebx
jb loc_407733
lea esi, [esi+0]
loc_4076B0:
xor edx, edx
xor eax, eax
loc_4076B4:
mov ebx, [esp+2Ch+var_10]
mov esi, [esp+2Ch+var_C]
mov edi, [esp+2Ch+var_8]
mov ebp, [esp+2Ch+var_4]
add esp, 2Ch
retn
loc_4076C8:
mov eax, edi
mov edx, ebx
div ecx
xor edx, edx
jmp short loc_4076B4
loc_4076D2:
mov ecx, edi
mov eax, 20h
sub eax, edi
shl edx, cl
mov ecx, eax
mov [esp+2Ch+var_20], edx
mov edx, esi
shr edx, cl
mov ecx, [esp+2Ch+var_20]
or edx, ecx
mov ecx, edi
shl esi, cl
mov ecx, eax
mov [esp+2Ch+var_20], esi
mov esi, ebx
shr esi, cl
mov ecx, edi
mov [esp+2Ch+var_24], edx
mov edx, ebx
mov ebx, ebp
shl edx, cl
mov ecx, eax
shr ebx, cl
or ebx, edx
mov edx, esi
mov eax, ebx
div [esp+2Ch+var_24]
mov esi, edx
mov ebx, eax
mul [esp+2Ch+var_20]
cmp esi, edx
jb short loc_407740
mov ecx, edi
shl ebp, cl
cmp ebp, eax
jnb short loc_40772D
cmp esi, edx
jz short loc_407740
loc_40772D:
mov eax, ebx
xor edx, edx
jmp short loc_4076B4
loc_407733:
xor edx, edx
mov eax, 1
jmp loc_4076B4
align 10h
loc_407740:
lea eax, [ebx-1]
xor edx, edx
jmp loc_4076B4
sub_407640 endp
