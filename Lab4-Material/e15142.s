@ ARM Assembly - Lab4 task


	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
get_values:
	sub sp, [sp, #8]

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #12
	str lr, [sp, #0]

	@ load aguments and print
	ldr r0, =format1
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf
	
	@ calling the scanf function
	ldr r0, =format_scanf 		@the scanf format
	mov r1, sp					@the arg2 load
	bl scanf
	mov r4, r0

	@ calling the scanf function
	ldr r0, =format_scanf 		@the scanf format
	mov r1, sp					@the arg2 load
	bl scanf
	mov r5, r0

	@ calling the get_values function
	mov r0, r4
	mov r1, r5
	bl get_values

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format_scanf: .asciz "%d"
format1: .asciz "Enter the number of Strings : %d"

