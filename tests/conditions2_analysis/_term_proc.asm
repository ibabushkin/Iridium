public _term_proc
_term_proc proc near
push ebx
sub esp, 8
call __x86_get_pc_thunk_bx
add ebx, 11F3h
call __do_global_dtors_aux
add esp, 8
pop ebx
retn
_term_proc endp
