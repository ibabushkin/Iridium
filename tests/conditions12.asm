

;
; 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
; �	This file is generated by The Interactive Disassembler (IDA)	    �
; �	Copyright (c) 2010 by Hex-Rays SA, <support@hex-rays.com>	    �
; �			 Licensed to: Freeware version			    �
; 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
;
; Input	MD5   :	0C8C7EA61467654DE62322C324706D10

; File Name   :	Z:\home\thewormkill\Iridium\tests\conditions12
; Format      :	ELF (Executable)
; Interpreter '/lib/ld-linux.so.2'
; Needed Library 'libc.so.6'
;
; Source File :	'init.c'
; Source File :	'crtstuff.c'
; Source File :	'conditions12.c'
; Source File :	'elf-init.c'

.686p
.mmx
.model flat
.intel_syntax noprefix


; Segment type:	Pure code
; Segment permissions: Read/Execute
_init segment dword public 'CODE' use32
assume cs:_init
;org 804831Ch
assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing



public _init_proc
_init_proc proc	near
push	ebx		; _init
sub	esp, 8
call	__x86_get_pc_thunk_bx
add	ebx, 14E7h
mov	eax, [ebx-0Ch]
test	eax, eax
jz	short loc_804833A
call	___gmon_start__

loc_804833A:
call	frame_dummy
call	__do_global_ctors_aux
add	esp, 8
pop	ebx
retn
_init_proc endp

_init ends


; Segment type:	Pure code
; Segment permissions: Read/Execute
_plt segment para public 'CODE' use32
assume cs:_plt
;org 8048350h
assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing
dd 4 dup(?)
; [00000006 BYTES: COLLAPSED FUNCTION _printf. PRESS KEYPAD "+"	TO EXPAND]
dw ?
dd 2 dup(?)
; [00000006 BYTES: COLLAPSED FUNCTION ___gmon_start__. PRESS KEYPAD "+"	TO EXPAND]
dw ?
dd 2 dup(?)
; [00000006 BYTES: COLLAPSED FUNCTION ___libc_start_main. PRESS	KEYPAD "+" TO EXPAND]
dw ?
dd 2 dup(?)
_plt ends


; Segment type:	Pure code
; Segment permissions: Read/Execute
_text segment para public 'CODE' use32
assume cs:_text
;org 8048390h
assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing



public _start
_start proc near
xor	ebp, ebp
pop	esi
mov	ecx, esp
and	esp, 0FFFFFFF0h
push	eax
push	esp
push	edx
push	offset __libc_csu_fini
push	offset __libc_csu_init
push	ecx
push	esi
push	offset main
call	___libc_start_main
hlt
db	66h
nop
db	66h
nop
db	66h
nop
db	66h
nop
db	66h
nop
db	66h
nop
db	66h
nop
_start endp




public __x86_get_pc_thunk_bx
__x86_get_pc_thunk_bx proc near
mov	ebx, [esp+0]
retn
__x86_get_pc_thunk_bx endp

align 10h


; Attributes: bp-based frame

deregister_tm_clones proc near

var_18=	dword ptr -18h

push	ebp
mov	ebp, esp
push	ebx
call	__x86_get_pc_thunk_bx
add	ebx, 1433h
sub	esp, 14h
lea	eax, [ebx+23h]
lea	edx, [ebx+20h]
sub	eax, edx
cmp	eax, 6
ja	short loc_80483FB

loc_80483F5:
add	esp, 14h
pop	ebx
pop	ebp
retn

loc_80483FB:
mov	eax, [ebx-10h]
test	eax, eax
jz	short loc_80483F5
mov	[esp+18h+var_18], edx
call	eax
jmp	short loc_80483F5
deregister_tm_clones endp

align 10h


; Attributes: bp-based frame

register_tm_clones proc	near

var_18=	dword ptr -18h
var_14=	dword ptr -14h

push	ebp
mov	ebp, esp
push	ebx
call	__x86_get_pc_thunk_bx
add	ebx, 13F3h
sub	esp, 14h
lea	eax, [ebx+20h]
lea	edx, [ebx+20h]
sub	eax, edx
sar	eax, 2
mov	ecx, eax
shr	ecx, 1Fh
add	eax, ecx
sar	eax, 1
jnz	short loc_8048444

loc_804843E:
add	esp, 14h
pop	ebx
pop	ebp
retn

loc_8048444:
mov	ecx, [ebx-4]
test	ecx, ecx
jz	short loc_804843E
mov	[esp+18h+var_14], eax
mov	[esp+18h+var_18], edx
call	ecx
jmp	short loc_804843E
register_tm_clones endp

align 10h


; Attributes: bp-based frame

__do_global_dtors_aux proc near
push	ebp
mov	ebp, esp
push	esi
push	ebx
call	__x86_get_pc_thunk_bx
add	ebx, 13A2h
cmp	byte ptr [ebx+20h], 0
jnz	short loc_80484BE
mov	eax, [ebx+24h]
lea	esi, [ebx-0E0h]
lea	edx, [ebx-0E4h]
sub	esi, edx
sar	esi, 2
sub	esi, 1
cmp	eax, esi
jnb	short loc_80484B2
nop

loc_8048498:
add	eax, 1
mov	[ebx+24h], eax
call	dword ptr [ebx+eax*4-0E4h]
mov	eax, [ebx+24h]
cmp	eax, esi
jb	short loc_8048498

loc_80484B2:
call	deregister_tm_clones
mov	byte ptr [ebx+20h], 1

loc_80484BE:
pop	ebx
pop	esi
pop	ebp
retn
__do_global_dtors_aux endp

align 10h


; Attributes: bp-based frame

frame_dummy proc near

var_18=	dword ptr -18h

push	ebp
mov	ebp, esp
push	ebx
call	__x86_get_pc_thunk_bx
add	ebx, 1333h
sub	esp, 14h
mov	eax, [ebx-0DCh]
test	eax, eax
jz	short loc_8048501
mov	eax, [ebx-8]
test	eax, eax
jz	short loc_8048501
lea	edx, [ebx-0DCh]
mov	[esp+18h+var_18], edx
call	eax

loc_8048501:
add	esp, 14h
pop	ebx
pop	ebp
jmp	register_tm_clones
frame_dummy endp

align 4


; Attributes: bp-based frame

public main
main proc near

var_20=	dword ptr -20h
var_C= dword ptr -0Ch
var_8= dword ptr -8
var_4= dword ptr -4

push	ebp
mov	ebp, esp
and	esp, 0FFFFFFF0h
sub	esp, 20h	; char *
mov	[esp+20h+var_4], 1
mov	[esp+20h+var_8], 2
mov	[esp+20h+var_C], 3
cmp	[esp+20h+var_4], 1
jz	short loc_8048542
cmp	[esp+20h+var_8], 2
jnz	short loc_804854E
cmp	[esp+20h+var_C], 3
jnz	short loc_804854E

loc_8048542:		; "True"
mov	[esp+20h+var_20], offset aTrue
call	_printf

loc_804854E:
mov	eax, 0
leave
retn
main endp

align 10h



public __libc_csu_init
__libc_csu_init	proc near

var_24=	dword ptr -24h
var_20=	dword ptr -20h
var_1C=	dword ptr -1Ch
arg_0= dword ptr  0Ch
arg_4= dword ptr  10h
arg_8= dword ptr  14h

push	ebp
push	edi
xor	edi, edi
push	esi
push	ebx
call	__x86_get_pc_thunk_bx
add	ebx, 12A1h
sub	esp, 1Ch
mov	ebp, [esp+24h+arg_0]
lea	esi, [ebx-0ECh]
call	_init_proc
lea	eax, [ebx-0ECh]
sub	esi, eax
sar	esi, 2
test	esi, esi
jz	short loc_80485B9
lea	esi, [esi+0]

loc_8048598:
mov	eax, [esp+24h+arg_8]
mov	[esp+24h+var_24], ebp
mov	[esp+24h+var_1C], eax
mov	eax, [esp+24h+arg_4]
mov	[esp+24h+var_20], eax
call	dword ptr [ebx+edi*4-0ECh]
add	edi, 1
cmp	edi, esi
jnz	short loc_8048598

loc_80485B9:
add	esp, 1Ch
pop	ebx
pop	esi
pop	edi
pop	ebp
retn
__libc_csu_init	endp

jmp	short __libc_csu_fini
align 10h



public __libc_csu_fini
__libc_csu_fini	proc near
rep retn
__libc_csu_fini	endp

align 10h


; Attributes: bp-based frame

__do_global_ctors_aux proc near
push	ebp
mov	ebp, esp
push	esi
push	ebx
call	__x86_get_pc_thunk_bx
add	ebx, 1222h
mov	eax, [ebx-0ECh]
lea	esi, [ebx-0ECh]
cmp	eax, 0FFFFFFFFh
jz	short loc_8048614
lea	esi, [esi+0]

loc_8048608:
sub	esi, 4
call	eax
mov	eax, [esi]
cmp	eax, 0FFFFFFFFh
jnz	short loc_8048608

loc_8048614:
pop	ebx
pop	esi
pop	ebp
retn
__do_global_ctors_aux endp

_text ends


; Segment type:	Pure code
; Segment permissions: Read/Execute
_fini segment dword public 'CODE' use32
assume cs:_fini
;org 8048618h
assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing



public _term_proc
_term_proc proc	near
push	ebx		; _fini
sub	esp, 8
call	__x86_get_pc_thunk_bx
add	ebx, 11EBh
call	__do_global_dtors_aux
add	esp, 8
pop	ebx
retn
_term_proc endp

_fini ends


; Segment type:	Pure data
; Segment permissions: Read
_rodata	segment	dword public 'CONST' use32
assume cs:_rodata
;org 8048634h
public _fp_hw
_fp_hw dd 3
public _IO_stdin_used
_IO_stdin_used dd 20001h
aTrue db 'True',0
_rodata	ends


; Segment type:	Pure data
; Segment permissions: Read
_eh_frame_hdr segment dword public 'CONST' use32
assume cs:_eh_frame_hdr
;org 8048644h
db    1
db  1Bh
db    3
db  3Bh	; ;
db  28h	; (
db    0
db    0
db    0
db    4
db    0
db    0
db    0
db  0Ch
db 0FDh	; �
db 0FFh
db 0FFh
db  44h	; D
db    0
db    0
db    0
db 0C8h	; �
db 0FEh	; �
db 0FFh
db 0FFh
db  68h	; h
db    0
db    0
db    0
db  1Ch
db 0FFh
db 0FFh
db 0FFh
db  88h	; �
db    0
db    0
db    0
db  8Ch	; �
db 0FFh
db 0FFh
db 0FFh
db 0C4h	; �
db    0
db    0
db    0
_eh_frame_hdr ends


; Segment type:	Pure data
; Segment permissions: Read
_eh_frame segment dword	public 'CONST' use32
assume cs:_eh_frame
;org 8048670h
db  14h
db    0
db    0
db    0
db    0
db    0
db    0
db    0
db    1
db  7Ah	; z
db  52h	; R
db    0
db    1
db  7Ch	; |
db    8
db    1
db  1Bh
db  0Ch
db    4
db    4
db  88h	; �
db    1
db    0
db    0
db  20h
db    0
db    0
db    0
db  1Ch
db    0
db    0
db    0
db 0C0h	; �
db 0FCh	; �
db 0FFh
db 0FFh
db  40h	; @
db    0
db    0
db    0
db    0
db  0Eh
db    8
db  46h	; F
db  0Eh
db  0Ch
db  4Ah	; J
db  0Fh
db  0Bh
db  74h	; t
db    4
db  78h	; x
db    0
db  3Fh	; ?
db  1Ah
db  3Bh	; ;
db  2Ah	; *
db  32h	; 2
db  24h	; $
db  22h	; "
db  1Ch
db    0
db    0
db    0
db  40h	; @
db    0
db    0
db    0
db  58h	; X
db 0FEh	; �
db 0FFh
db 0FFh
db  49h	; I
db    0
db    0
db    0
db    0
db  41h	; A
db  0Eh
db    8
db  85h	; �
db    2
db  42h	; B
db  0Dh
db    5
db    2
db  45h	; E
db 0C5h	; �
db  0Ch
db    4
db    4
db    0
db  38h	; 8
db    0
db    0
db    0
db  60h	; `
db    0
db    0
db    0
db  8Ch	; �
db 0FEh	; �
db 0FFh
db 0FFh
db  61h	; a
db    0
db    0
db    0
db    0
db  41h	; A
db  0Eh
db    8
db  85h	; �
db    2
db  41h	; A
db  0Eh
db  0Ch
db  87h	; �
db    3
db  43h	; C
db  0Eh
db  10h
db  86h	; �
db    4
db  41h	; A
db  0Eh
db  14h
db  83h	; �
db    5
db  4Eh	; N
db  0Eh
db  30h	; 0
db    2
db  48h	; H
db  0Eh
db  14h
db  41h	; A
db 0C3h	; �
db  0Eh
db  10h
db  41h	; A
db 0C6h	; �
db  0Eh
db  0Ch
db  41h	; A
db 0C7h	; �
db  0Eh
db    8
db  41h	; A
db 0C5h	; �
db  0Eh
db    4
db  10h
db    0
db    0
db    0
db  9Ch	; �
db    0
db    0
db    0
db 0C0h	; �
db 0FEh	; �
db 0FFh
db 0FFh
db    2
db    0
db    0
db    0
db    0
db    0
db    0
db    0
__FRAME_END__ db    0
db    0
db    0
db    0
_eh_frame ends


; Segment type:	Pure data
; Segment permissions: Read/Write
_ctors segment dword public 'DATA' use32
assume cs:_ctors
;org 8049720h
__CTOR_LIST__ db 0FFh	; Alternative name is '__init_array_end'
db 0FFh
db 0FFh
db 0FFh
__CTOR_END__ db	   0
db    0
db    0
db    0
_ctors ends


; Segment type:	Pure data
; Segment permissions: Read/Write
_dtors segment dword public 'DATA' use32
assume cs:_dtors
;org 8049728h
__DTOR_LIST__ db 0FFh
db 0FFh
db 0FFh
db 0FFh
public __DTOR_END__
__DTOR_END__ db	   0
db    0
db    0
db    0
_dtors ends


; Segment type:	Pure data
; Segment permissions: Read/Write
_jcr segment dword public 'DATA' use32
assume cs:_jcr
;org 8049730h
__JCR_LIST__ db	   0
db    0
db    0
db    0
_jcr ends


; Segment type:	Pure data
; Segment permissions: Read/Write
_got segment dword public 'DATA' use32
assume cs:_got
;org 80497FCh
dd offset _ITM_deregisterTMCloneTable
dd offset __gmon_start__
dd offset _Jv_RegisterClasses
dd offset _ITM_registerTMCloneTable
_got ends


; Segment type:	Pure data
; Segment permissions: Read/Write
_got_plt segment dword public 'DATA' use32
assume cs:_got_plt
;org 804980Ch
_GLOBAL_OFFSET_TABLE_ db    ? ;
db    ?	;
db    ?	;
db    ?	;
db    ?	;
db    ?	;
db    ?	;
db    ?	;
db    ?	;
db    ?	;
db    ?	;
db    ?	;
off_8049818 dd offset printf
off_804981C dd offset __gmon_start__
off_8049820 dd offset __libc_start_main
_got_plt ends


; Segment type:	Pure data
; Segment permissions: Read/Write
_data segment dword public 'DATA' use32
assume cs:_data
;org 8049824h
public data_start ; weak
data_start db	 0	; Alternative name is '__data_start'
db    0
db    0
db    0
public __dso_handle
__dso_handle db	   0
db    0
db    0
db    0
_data ends


; Segment type:	Uninitialized
; Segment permissions: Read/Write
_bss segment dword public 'BSS' use32
assume cs:_bss
;org 804982Ch
assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing
completed_6302 db ?	; Alternative name is '__TMC_END__'
align 10h
dtor_idx_6304 dd ?
_bss ends


; Segment type:	Externs
; extern
extrn printf@@GLIBC_2_0:near
extrn __libc_start_main@@GLIBC_2_0:near
; int printf(const char	*,...)
extrn printf:near
extrn __libc_start_main:near
extrn _ITM_deregisterTMCloneTable ; weak
extrn __gmon_start__ ; weak
extrn _Jv_RegisterClasses ; weak
extrn _ITM_registerTMCloneTable	; weak


end _start
