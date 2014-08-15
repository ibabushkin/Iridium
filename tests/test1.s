	.file	"test1.c"
	.intel_syntax noprefix
	.section	.rodata
.LC0:
	.string	"%d:%d"
.LC1:
	.string	"elseif"
.LC2:
	.string	"else"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	and	esp, -16
	sub	esp, 32
	mov	DWORD PTR [esp+28], 0
	jmp	.L2
.L8:
	mov	DWORD PTR [esp+24], 0
	jmp	.L3
.L7:
	cmp	DWORD PTR [esp+28], 7
	jne	.L4
	cmp	DWORD PTR [esp+24], 3
	jne	.L4
	mov	eax, DWORD PTR [esp+24]
	mov	DWORD PTR [esp+8], eax
	mov	eax, DWORD PTR [esp+28]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:.LC0
	call	printf
	jmp	.L5
.L4:
	cmp	DWORD PTR [esp+28], 5
	jne	.L6
	cmp	DWORD PTR [esp+24], 8
	jne	.L6
	mov	DWORD PTR [esp], OFFSET FLAT:.LC1
	call	puts
	jmp	.L5
.L6:
	mov	DWORD PTR [esp], OFFSET FLAT:.LC2
	call	puts
.L5:
	add	DWORD PTR [esp+24], 1
.L3:
	cmp	DWORD PTR [esp+24], 9
	jle	.L7
	add	DWORD PTR [esp+28], 1
.L2:
	cmp	DWORD PTR [esp+28], 9
	jle	.L8
	mov	eax, 0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
