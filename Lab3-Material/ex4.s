@ ARM Assembly - exercise 4

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------	
fact:
	SUB sp, sp, #4
	STR r4, [sp, #0]
	MOV r4, r0 	@ input n
	
	MOV r6, #1 	@ Temp fact	
	
	
	@ calling the get_Fact function
	SUB r4, r4, #1
	mov r1, r4 	@the arg1 load
	bl get_Fact
	mov r5,r0

get_Fact:
	CMP r1, #1
	MOV 
	BEQ get_Fact_Exit
	MUL 
	
	
get_Fact_Exit:
	
	
	
	@ Main exit
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

	mov r4, #8 	@the value n

	@ calling the fact function
	mov r0, r4 	@the arg1 load
	bl fact
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
format: .asciz "Factorial of %d is %d\n"

