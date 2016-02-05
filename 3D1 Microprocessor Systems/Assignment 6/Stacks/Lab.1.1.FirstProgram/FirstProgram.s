	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start 
	LDR r1, =brackets 	;address = 0xA1000000
	LDR r12, =stk_top	;current pointer
	LDR r11, =stk_top	;always point to end of stack
	LDR r3, = 0			;parentheses balanced bool, 1= false, 0 = true

	B WHcond
wh1	CMP r2, #'('	
	BEQ push
	B pop
	
pop	CMP	r12, r11		;check if stack empty
	BHS	fail
	LDR r0, [r12], #4  	;load the value and decrease the pointer
	B WHcond				;back to loop

push	STR r0, [r12, #-4]!	 ;
	B WHcond

WHcond	LDRB r2, [r1]	;load first char
	CMP r2, #0		;check if null terminated
	ADD r1, r1, #1 	 ;add 1 to check next memory space next time
	BNE	wh1		  	;go to loop

	CMP	r12, r11		;check if stack empty
	BEQ	stop	   		;if empty end program

fail	MOV r3, #1	;1 = program fail

stop B stop

stk_sz	EQU 0x400	 ;set the size of the stack

		AREA	TestData, DATA, READWRITE
brackets DCB		"(((()",0		;null terminated string
stk_mem	 SPACE		stk_sz
stk_top
	END
