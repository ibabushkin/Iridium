_start proc near
xor ebp, ebp
pop esi
mov ecx, esp
and esp, 0FFFFFFF0h
push eax
push esp
push edx
push offset __libc_csu_fini
push offset __libc_csu_init
push ecx
push esi
push offset main
call ___libc_start_main
hlt
db 66h
nop
db 66h
nop
db 66h
nop
db 66h
nop
db 66h
nop
db 66h
nop
db 66h
nop
_start endp
