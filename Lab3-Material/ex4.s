@ ARM Assembly - exercise 4

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------	
fact:
	sub sp,sp,#8	@stack handling
	str lr,[sp,#0]	@to store return address
	str r6,[sp,#4]	@to keep local variable

	@base case
	cmp r0,#1
		beq factBase @if arg==1, then go to factBase
	
	mov r6,r0		@copy arg to local variable
	sub r0,r0,#1	@arg=arg-1
	
	bl fact			@recursion

	mul r0,r6,r0	@return=fact(arg)*fact(arg-1)
	
	

factBase:
	ldr lr,[sp,#0]	@load return address
	ldr r6,[sp,#4]	@load local variable
	add sp,sp,#8	@free memory
	mov pc,lr		





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
@ ARM Assembly - exercise 4

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------	
fact:
	sub sp,sp,#8	@stack handling
	str lr,[sp,#0]	@to store return address
	str r6,[sp,#4]	@to keep local variable

	@base case
	cmp r0,#1
		beq factBase @if arg==1, then go to factBase
	
	mov r6,r0		@copy arg to local variable
	sub r0,r0,#1	@arg=arg-1
	
	bl fact			@recursion

	mul r0,r6,r0	@return=fact(arg)*fact(arg-1)
	
	

factBase:
	ldr lr,[sp,#0]	@load return address
	ldr r6,[sp,#4]	@load local variable
	add sp,sp,#8	@free memory
	mov pc,lr		





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
