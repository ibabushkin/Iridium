_init_proc proc near
push ebx
sub esp, 8
call __x86_get_pc_thunk_bx
add ebx, 14A3h
mov eax, [ebx-0Ch]
test eax, eax
jz short loc_8048316
call ___gmon_start__
loc_8048316:
call frame_dummy
call __do_global_ctors_aux
add esp, 8
pop ebx
retn
_init_proc endp
