@ ARM Assembly - lab 2
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ Load REQUIRED VALUES HERE
	@ load i to r0
	@ load j to r1
	@load sum to r5

	MOV r0, #0
	MOV r1, #5
	MOV r5, #0
	
	@ Write YOUR CODE HERE
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------

Loop1: 	CMP r0, #10
		
		BGE Exit
		MOV r1, #5

		
Loop2: 	CMP r1, #15
	
		BGE End_Loop2
	
			@ Inner Loop
			ADD  r6, r0, r1
			CMP r6, #10
			BGE Else
				ADD r5, r5, r0, LSL #1
			
			B End_Inner
			
Else:
		AND r7, r0, r1
		ADD r5, r5, r7
		B End_Inner
		
End_Loop2:
		ADD r0, r0, #1
		B Loop1
	
	
End_Inner:
		ADD r1, r1, #1
		B Loop2
	
Exit:


	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

