@ ARM Assembly - exercise 3

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
Fibonacci:

	SUB sp, sp, #4
	STR r4, [sp, #0]
	MOV r4, r0
	
	@ Temp sum
	MOV r5, #0	
	
	@ Fib sum
	MOV r6, #1
	
	@ Counter
	MOV r7, #2
	
Fib_Loop:	
	CMP r7, r4
	
	BGT Exit
	MOV r8, r6
	ADD r6, r6, r5
	MOV r5, r8
	ADD r7, r7, #1
	B Fib_Loop 
	
	
Exit:
	
	@ Fibonacci success!
	
	MOV r0, r6
	LDR r4, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr






@ ---------------------
	
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8	@the value n

	@ calling the Fibonacci function
	mov r0, r4 	@the arg1 load
	bl Fibonacci
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "F_%d is %d\n"

