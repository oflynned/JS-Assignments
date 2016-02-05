	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR r1,=teststr		;variable
	LDR r3,=0
	ldr r4, =0			;charCount
		  
	B testwh1
wh1	CMP	r0, #0x20	;if statement
	ADDNE	r4, r4, #1	;if(c != ' ') charCount++;
	BNE 	endif
	ADD 	r3,r3,#1	;counter increment
	mov 	r4, #0	  	;if(c == ' ') charCount=0;
endif
testwh1	LDRB r0,[r1],#1
	CMP r0,#0		;wh!=0
	BNE wh1
	cmp r4, #0
	addne r3, r3, #1
stop B stop
	AREA TestData, Data, READWRITE
teststr DCB "test string",0
	END 
