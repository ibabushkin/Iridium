_init_proc proc near
push ebx
sub esp, 8
call __x86_get_pc_thunk_bx
add ebx, 161Bh
mov eax, [ebx-0Ch]
test eax, eax
jz short loc_804837E
call ___gmon_start__
loc_804837E:
call frame_dummy
call __do_global_ctors_aux
add esp, 8
pop ebx
retn
_init_proc endp
