	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
		;static variable x=1
		LDR r0, =1
		
		;ax^3 + bx^2 + cx	

		;6x^4
		MUL r1, r0, r0
		MUL r1, r0, r1
		MUL r1, r0, r1
		LDR r2, =6
		MUL r1, r2, r1
		
		;-4x^2
		MUL r3, r0, r0
		LDR r4, =-4
		MUL r3, r4, r3
		
		;6x
		LDR r5, =6
		MUL r5, r0, r5 
		
		;concatenate
		ADD r0, r1, r3
		ADD r0, r0, r5
	
stop	B	stop

	END	