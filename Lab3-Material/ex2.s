@ ARM Assembly - exercise 6
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
@Implement gcd subroutine to find gcd of arg1 and arg2

gcd:
	SUB sp, sp, #8
	STR r4, [sp, #4]
	STR r5, [sp, #0]
	
	CMP r4, r5
	BGT Swap
Swap:
	MOV r8, r4
	MOV r4, r5
	MOV r5, r8
	
	@ normal flow
	@ r4 is the lower value

@ in the gcd loop
GCD_Loop:
	CMP r4, #0
	
	BEQ Exit

	MOV r8, r4
	MOV r9, r5
	MOV r10, #0
Div_Loop:	
	CMP r9, r8
	BLT Exit_Div_Loop
	SUB r9, r9, r8
	ADD r10, r10, #1
	
	B Div_Loop

@ division success!	
Exit_Div_Loop:
	
	
	
	MOV r5, r8
	MOV r4, r9
	B GCD_Loop
	
Exit:
	MOV r0, r5
	LDR r4, [sp, #4]
	LDR r5, [sp, #0]
	ADD sp, sp, #8
	MOV pc, lr
	

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64 	@the value a
	mov r5, #24 	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "gcd(%d,%d) = %d\n"

