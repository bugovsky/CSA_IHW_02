	.file	"sequence.c"
	.intel_syntax noprefix
	.text
	.globl	input
	.type	input, @function
input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -8[rbp], 0
.L3:
	mov	rax, QWORD PTR stdin[rip]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -4[rbp], eax
	mov	eax, DWORD PTR -8[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -4[rbp]
	mov	BYTE PTR [rax], dl
	add	DWORD PTR -8[rbp], 1
	cmp	DWORD PTR -4[rbp], -1
	je	.L2
	cmp	DWORD PTR -8[rbp], 99999
	jle	.L3
.L2:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	nop
	leave
	ret
	.size	input, .-input
	.section	.rodata
	.align 8
.LC0:
	.string	"There is no sequence with size = %d\n"
	.text
	.globl	GetSequence
	.type	GetSequence, @function
GetSequence:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR -40[rbp], rdi
	mov	QWORD PTR -48[rbp], rsi
	mov	DWORD PTR -52[rbp], edx
	mov	DWORD PTR -56[rbp], ecx
	mov	DWORD PTR -20[rbp], -1
	mov	DWORD PTR -16[rbp], -1
	mov	DWORD PTR -12[rbp], 0
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 1
	mov	DWORD PTR -8[rbp], eax
	jmp	.L5
.L11:
	cmp	DWORD PTR -20[rbp], -1
	jne	.L6
	mov	eax, DWORD PTR -8[rbp]
	mov	DWORD PTR -20[rbp], eax
	mov	eax, DWORD PTR -8[rbp]
	mov	DWORD PTR -16[rbp], eax
.L6:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, DWORD PTR -16[rbp]
	add	eax, 1
	cmp	DWORD PTR -56[rbp], eax
	je	.L16
	mov	eax, DWORD PTR -8[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rcx, -1[rax]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jle	.L9
	mov	eax, DWORD PTR -8[rbp]
	sub	eax, 1
	mov	DWORD PTR -16[rbp], eax
	jmp	.L10
.L9:
	mov	DWORD PTR -20[rbp], -1
	mov	DWORD PTR -16[rbp], -1
.L10:
	sub	DWORD PTR -8[rbp], 1
.L5:
	cmp	DWORD PTR -8[rbp], 0
	jg	.L11
	jmp	.L8
.L16:
	nop
.L8:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, DWORD PTR -16[rbp]
	add	eax, 1
	cmp	DWORD PTR -56[rbp], eax
	jle	.L12
	mov	eax, DWORD PTR -56[rbp]
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	BYTE PTR [rax], 0
	jmp	.L17
.L12:
	mov	eax, DWORD PTR -16[rbp]
	mov	DWORD PTR -4[rbp], eax
	jmp	.L14
.L15:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -12[rbp]
	movsx	rcx, edx
	mov	rdx, QWORD PTR -48[rbp]
	add	rdx, rcx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	add	DWORD PTR -12[rbp], 1
	add	DWORD PTR -4[rbp], 1
.L14:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jle	.L15
	mov	eax, DWORD PTR -12[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
.L17:
	nop
	leave
	ret
	.size	GetSequence, .-GetSequence
	.globl	output
	.type	output, @function
output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L19
.L20:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
	add	DWORD PTR -4[rbp], 1
.L19:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L20
	mov	edi, 10
	call	putchar@PLT
	nop
	leave
	ret
	.size	output, .-output
	.section	.rodata
.LC1:
	.string	"%d"
.LC2:
	.string	"Incorrect size"
.LC3:
	.string	"Sequence:"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, -32[rbp]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	edi, 100000
	call	malloc@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	input
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	DWORD PTR -28[rbp], eax
	mov	eax, DWORD PTR -32[rbp]
	add	eax, 1
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	eax, DWORD PTR -32[rbp]
	test	eax, eax
	jle	.L22
	mov	eax, DWORD PTR -32[rbp]
	cmp	DWORD PTR -28[rbp], eax
	jge	.L23
.L22:
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	jmp	.L24
.L23:
	mov	ecx, DWORD PTR -32[rbp]
	mov	edx, DWORD PTR -28[rbp]
	mov	rsi, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	GetSequence
	mov	rax, QWORD PTR -16[rbp]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L24
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	output
.L24:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L26
	call	__stack_chk_fail@PLT
.L26:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
