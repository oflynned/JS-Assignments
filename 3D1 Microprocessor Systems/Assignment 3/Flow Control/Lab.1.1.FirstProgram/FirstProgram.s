	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start							  
	LDR r0, =0x6000069F				; input number
	LDR r1, =31				; while condition
	LDR r2, =1	  			; masking bit
	MOV r3, #0				; inverted output

while1 CMP R1, #0	; while (y != 0) {
	BEQ endwh1
	MOV r2,#1			   ;reset mask
	AND r2,r0			   ;mask input
	MOV r0,r0,LSR#1
	MOV r2,r2,LSL r1	   ;shift by 31,30,29..etc.
	ADD r3,r2,r3		   ;add into corresponding answer bit
	SUBS	r1, r1, #1	;  y = y - 1
	B	while1		; }
endwh1

	
stop	B	stop

	END	