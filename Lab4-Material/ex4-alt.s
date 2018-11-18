@ ARM Assembly: Lab 4 - exercise 4
@ 
    .text 	@ instruction memory

@-----------------------------main
	.global main
main:
	@ push (store) lr to r9
	mov r9,lr

@-------------------input number
    ldr r0, =first
    bl printf

	sub sp,sp,#4 		@allocate stack for input
	ldr r0, =formatd	@scanf("%d")
	mov r1,sp
    bl scanf

	ldr r4,[sp,#0]		@load and save num
	str r4,[sp,#4]
@--------------------	
    ldr r4,[sp,#4]      @load number
    add sp,sp,#4        @free stack
    cmp r4,#0           @check for invalid numbers
    ble invalid

    mov r5,#0           @counter starting from 0
    b loop
loop:                   @while counter<=number
    cmp r5,r4
    beq exit

    ldr r0, =second     @enter input string
    mov r1,r5
    bl printf

    add r5,r5,#1

@----------------------scan string
	sub sp,sp,#200 		@allocate stack for input
	ldr r0, =formats	@scanf("%s")
	mov r1,sp
    bl scanf
    mov r1,sp

@---------------------------get string length
    mov r6,#0   @iterator = 0
    mov r7, #0  @iterator = 0
strLength:    
    add r2,r6,r1        @r2 = str[i]
    ldrb r3,[r2,#0]     @load str[i] to r3
    cmp r3,#0           @compare for null char
        @ beq str_Rev
        beq str_Rev
    add r6,r6,#1        @i++
    b strLength

str_Rev:
    mov r1,r6
    mov r0,r6
    ldr r0, =formatd
    bl printf

    mov r1,sp
    mov r0, sp
    sub r6,r6,#1
    mov r8, #0
    cmp r6, #0
    beq store_to_array

store_to_array:
     add r2, r6, r1
     ldrb r3,[r2,#0]
     strb r3, [r8, #0]
     cmp r3,#0
         beq exit_rev     
    
     add r6, r6, #1

     b store_to_array

exit_rev:
    add sp,sp,#200      @free stack
    b loop



invalid:                
    ldr r0, =invalid_msg
    bl printf
    b exit

exit:
@--------------------
	@ stack handling (pop lr from the r9) and return
	mov lr,r9
	mov pc, lr

	.data	@ data memory
first: .asciz "Enter the number of strings: "
formatd: .asciz "%d"
invalid_msg: .asciz "Invalid Number\n"
second: .asciz "\nEnter the input string %d:\n"
formats: .asciz "%s"
printStr: .asciz "%s\n"
