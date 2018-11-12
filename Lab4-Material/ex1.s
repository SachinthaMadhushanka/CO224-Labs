@ ARM Assembly: Lab 4 - exercise 1
.text 	@ instruction memory
@ ---------------------	
@ implement using loops to calculate (2 ^ arg)
 two_pow:
	SUB sp, sp, #12
	STR r3, [sp,#8]
	STR r4, [sp,#4] 
	STR r5, [sp,#0]
	MOV r6,#1 	@ Temp multiply value
	MOV r3,#2
	MOV r7,#1	@ Counter
 Loop:
	CMP r7, r0
	
	BGT Exit
	MUL r6, r3, r6
	ADD r7, r7, #1
	B Loop
	
Exit:
	MOV r0, r6
	LDR r3, [sp, #8]
	LDR r4, [sp, #4]
	LDR r5, [sp, #0]
	ADD sp, sp, #12
	MOV pc, lr
 @-----------------------division
div_func:
	SUB sp, sp, #12
	STR r10, [sp,#0]
	STR r4, [sp,#4] 
	STR r5, [sp,#8]
	
	MOV r4, r0
	MOV r5, r1
	MOV r10,#0	@ Counter
 div_loop:
	CMP r4, r5
	BLT exit
	SUB r4, r4, r5
	ADD r10, r10, #1
	
	B div_loop
 exit:
	MOV r0, r10
	LDR r10, [sp,#0]
	LDR r4, [sp, #4]
	LDR r5, [sp, #8]
	ADD sp, sp, #12
	MOV pc, lr
 @ ---------------------main
 	
	.global main
main:
	@ stack handling
	@ push (store) lr to r9
	mov r9,lr

@-------------------input x
    	ldr r0, =first
    	bl printf
 	sub sp,sp,#4 		@allocate stack for input
	ldr r0, =formatd	@scanf("%d")
	mov r1,sp		@scanf(&sp)
    	bl scanf
 	ldr r4,[sp,#0]		@load and save x
	str r4,[sp,#4]
	
@--------------------input y
	ldr r0, =second
    	bl printf
 	sub sp,sp,#4 		@allocate stack for input
	ldr r0, =formatd	@scanf("%d")
	mov r1,sp
    	bl scanf
 	ldr r4,[sp,#0]		@load and save y
	str r4,[sp,#8]

 @------------------------ calling the two_pow function
	ldr r5,[sp,#8]		@load y
	mov r0, r5 		@the arg1 load (y)
	bl two_pow
	mov r6,r0

@------------------------ x*2^y
	ldr r4,[sp,#4] 		@load x
	mul r8,r4,r6
 	ldr r0, =answerOne
	mov r1,r8 		
	bl printf

 @------------------------- x / 2^y 
	mov r0, r4
	mov r1, r6
	bl div_func
	mov r8,r0
 	ldr r0, =answerTwo
	mov r1,r8 		
	bl printf
 @-------------------------------------------------------
 
	@ stack handling (pop lr from the stack) and return
	mov lr,r9
	@add sp, sp, #4
	mov pc, lr
 	.data	@ data memory
first: .asciz "Enter number (x): "
second: .asciz "Enter number (y): "
formatd: .asciz "%d"
answerOne: .asciz "(x * 2^y) = %d\n"
answerTwo: .asciz "(x / 2^y) = %d\n"
