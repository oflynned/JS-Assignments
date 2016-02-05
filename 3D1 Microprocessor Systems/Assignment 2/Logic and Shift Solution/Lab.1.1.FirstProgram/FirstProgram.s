	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	;load initial values
	LDR r0,=500
	LDR r1,=0
	LDR r2,=9
	LDR r3,=0
	LDR r4,=1

	;create a mask, get count, shift
	AND r3,r0,r4
	ADD r1,r3,r1
	MOV r0,#1

	;repeat 8 more times as branching and looping not allowed

	AND r3,r0,r4
	ADD r1,r3,r1
	MOV r0,#1
	
	AND r3,r0,r4
	ADD r1,r3,r1
	MOV r0,#1
	
	AND r3,r0,r4
	ADD r1,r3,r1
	MOV r0,#1
	
	AND r3,r0,r4
	ADD r1,r3,r1
	MOV r0,#1
	
	AND r3,r0,r4
	ADD r1,r3,r1
	MOV r0,#1
	
	AND r3,r0,r4
	ADD r1,r3,r1
	MOV r0,#1

	;get final count
	SUB r2,r2,r1
	
	;500_10 = 111110100_2 where there are 6 1s (stored in r4) and 3 0s (stored in r2)
	
stop	B	stop

	END	