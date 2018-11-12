@ ARM Assembly: Lab 4 - exercise 2
.text 	@ instruction memory
@ ---------------------	


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
	
	add sp, sp,#8
	cmp r4, r5
	bne not_Equal
	ldr r0, =printf_1
	bl printf
	b Exit
not_Equal:
	ldr r0, =printf_2
	bl printf
	
Exit:
	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
number_1: .asciz"Enter x : "
format_1: .asciz"%d"
number_2: .asciz"Enter y : "
format_2: .asciz"%d"
printf_1: .asciz"x and y are equal.\n"
printf_2: .asciz"x and y are'nt equal.\n"

