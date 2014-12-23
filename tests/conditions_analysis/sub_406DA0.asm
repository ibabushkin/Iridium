sub_406DA0 proc near
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4
arg_0= dword ptr  4
arg_4= dword ptr  8
sub esp, 0Ch
mov [esp+0Ch+var_8], esi
mov ecx, [esp+0Ch+arg_0]
mov esi, [esp+0Ch+arg_4]
mov [esp+0Ch+var_C], ebx
mov [esp+0Ch+var_4], edi
mov eax, [ecx+10h]
mov edx, [esi+10h]
sub eax, edx
jnz short loc_406DE2
lea edi, ds:10h[edx*4]
lea ebx, [ecx+14h]
lea edx, [ecx+edi+4]
lea ecx, [esi+edi+4]
loc_406DD2:
sub ecx, 4
sub edx, 4
mov esi, [ecx]
cmp [edx], esi
jnz short loc_406DF1
cmp ebx, edx
jb short loc_406DD2
loc_406DE2:
mov ebx, [esp+0Ch+var_C]
mov esi, [esp+0Ch+var_8]
mov edi, [esp+0Ch+var_4]
add esp, 0Ch
retn
loc_406DF1:
sbb eax, eax
mov ebx, [esp+0Ch+var_C]
or eax, 1
mov esi, [esp+0Ch+var_8]
mov edi, [esp+0Ch+var_4]
add esp, 0Ch
retn
sub_406DA0 endp
