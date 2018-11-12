@ ARM Assembly: Lab 4 - exercise 1 method-2
.text 	@ instruction memory
@ ---------------------	
@ implement using loops to calculate (2 ^ arg)

@---------------------

get_Values:
	sub sp, sp, #8
	str r4, [sp, #0]
	str r5, [sp, #4]
	
	mov r6, r0	@ r6 = r0 = r4
	mov r7, r1	@ r7 = r1 = r5
	
	lsl r6, r0, r1
	lsr r7, r0, r1

	mov r0, r6
	mov r1, r7
	
	ldr r4, [sp, #0]
	ldr r5, [sp, #4]
	add sp, sp, #8
	mov pc, lr

@---------------------

	.global main
main:
	@ stack handling
	@ push (store) lr to r9 or stack
	sub sp, sp, #4
	str lr, [sp, #0]
	
	@ printf for x
	ldr r0, =number_1
	bl printf
	
	sub sp, sp, #4		@stack room for input x
	ldr r0, =format_1
	mov r1, sp
	bl scanf
	ldr r4, [sp, #0]	@ save x in r4
	
	@ printf for x
	ldr r0, =number_2
	bl printf
	
	sub sp, sp, #4		@stack room for input y
	ldr r0, =format_2
	mov r1, sp
	bl scanf
	ldr r5, [sp, #0]	@ save y in r5
	
	mov r0, r4
	mov r1, r5
	bl get_Values
	
	add sp, sp, #8		@ printf
	mov r6, r0
	ldr r0, =printf_1
	mov r1, r6
	bl printf
	
	ldr r0, =printf_2	@ printf
	mov r1, r7
	bl printf
	
	
	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
number_1: .asciz"Enter x : "
format_1: .asciz"%d"
number_2: .asciz"Enter y : "
format_2: .asciz"%d"
printf_1: .asciz"x * (2​^y) : %d\n"
printf_2: .asciz"x / (2​^y) : %d\n"
test_1: .asciz"x = %d\n"
test_2: .asciz"x = %d\n"
