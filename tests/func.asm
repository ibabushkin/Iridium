_sort_string:
; begin func(_sort_string)
	push	ebp
	mov ebp, esp
; bytes(40)
	sub	esp, 40
; begin code
	mov	DWORD PTR [ebp-8], 0
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp], eax
	call	_strlen
	mov	DWORD PTR [ebp-12], eax
	mov	eax, DWORD PTR [ebp-12]
	inc	eax
	mov	DWORD PTR [esp], eax
	call	_malloc
	mov	DWORD PTR [ebp-20], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [ebp-16], eax
	mov	BYTE PTR [ebp-21], 97
; end code
; begin loop
L3:
; begin condition
	cmp	BYTE PTR [ebp-21], 122
	jg	L4
; end condition
; begin code
	mov	DWORD PTR [ebp-4], 0
; end code
; begin loop
L6:
; begin condition
	mov	eax, DWORD PTR [ebp-4]
	cmp	eax, DWORD PTR [ebp-12]
	jge	L7
; end condition
; begin if
; begin condition
	mov	eax, DWORD PTR [ebp-16]
	movzx	eax, BYTE PTR [eax]
	cmp	al, BYTE PTR [ebp-21]
	jne	L9
; end condition
; begin code
	mov	eax, DWORD PTR [ebp-20]
	mov	edx, DWORD PTR [ebp-8]
	add	edx, eax
	mov	eax, DWORD PTR [ebp-16]
	movzx	eax, BYTE PTR [eax]
	mov	BYTE PTR [edx], al
	lea	eax, [ebp-8]
	inc	DWORD PTR [eax]
; end code
; end if
L9:
; begin code
	lea	eax, [ebp-16]
	inc	DWORD PTR [eax]
	lea	eax, [ebp-4]
	inc	DWORD PTR [eax]
; end code
	jmp	L6
; end loop
L7:
; begin code
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [ebp-16], eax
	lea	eax, [ebp-21]
	inc	BYTE PTR [eax]
; end code
	jmp	L3
; end loop
L4:
; begin code
	mov	eax, DWORD PTR [ebp-20]
	add	eax, DWORD PTR [ebp-8]
	mov	BYTE PTR [eax], 0
	mov	eax, DWORD PTR [ebp-20]
	mov	DWORD PTR [esp+4], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp], eax
	call	_strcpy
	mov	eax, DWORD PTR [ebp-20]
	mov	DWORD PTR [esp], eax
	call	_free
; end code
	leave
	ret
; end func
