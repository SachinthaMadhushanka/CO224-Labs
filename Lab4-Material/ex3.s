@ ARM Assembly: Lab 4 - exercise 3
.text 	@ instruction memory
@ ---------------------	


	.global main
main:
	@ stack handling
	@ push (store) lr to r9 or stack
	sub sp, sp, #4
	str lr, [sp, #0]
	
	@ printf for x
	ldr r0, =number
	bl printf
	
	sub sp, sp, #4		@stack room for input x
	ldr r0, =format
	mov r1, sp
	bl scanf
	ldr r4, [sp, #0]	@ save x in r4
	
	mov r5, #1
	
loop:	
	cmp r5, r4
	bgt Exit
	
	ldr r0,=format
	mov r1, r5
	bl printf
	add r5, r5,#1
	b loop
	
Exit:
	ldr r0, =final
	bl printf
	
	add sp, sp, #4
	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
number: .asciz"Enter x : "
format: .asciz"%d"
final: .asciz"\n"

