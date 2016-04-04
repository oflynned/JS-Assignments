	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start 
		LDR r1, =hexstr 	;address = 0xA1000000
		LDR r4, =0			;bool for negative number
		LDR r6, =0			;count of hex bits
		LDR r8, =0			;final answer
		
			;check for + or -
			LDRB r0, [r1]		;load first byte
			CMP	r0, #'-'		;check for + or -
			BHI	count
			ADD r1, r1, #1	;add 1 so this value ignored for calc
			BNE count
			MOV r4, #1		;bool set for negative number
count		
			LDRB r0, [r1, r6]
			CMP r0, #0		;check if NULL TERMINATED yet
			BEQ Cdone		;is the thing terminated
			ADD	r6, r6, #1	;increase count by 1
			BNE count		;hex bits counted
			
Cdone		SUB r7, r6, #1		;array indices start at 0 instead of 1
			LDR r6, =0		;number of places to shift hex value
			LDR r2, =4		;number of bits to shift hex value one place away
		
						;gets the value
VALloop		LDRB r0, [r1, r7]		;load hex values from right to left
			AND r3, r0, #15	   	;gets value of LSB which give first digit value
			CMP r0, #'A'		;check if required +9   
			BCC STRval
			ADD r3, r3, #9		;A-F need +9 to equal hex value	

STRval			MUL r5, r6, r2		;calc how many bits to be shifted
			LSL r3, r5			;shifts the hex value the required places left
			ADD r8, r8, r3		;adds the value to the register
			ADD r6, r6, #1		;increases shift amount to next slot

			SUB r7, r7, #1		;go to next point in the loop
			CMP r7, #-1			;check outside memory index
			BNE VALloop
			
			CMP r4, #1			;check if negative number
			BNE store			;skip if positive number
			LDR r0, =0xFFFFFFFF	;EOR with this because all bits set
			EOR r8, r8, r0		;flip all the bits
			ADD r8, r8, #1		;finish making a signed binary number		

store		LDR r7, =0xa1000027	;address to store value
			STR r8, [r7]		;store the value
stop B stop

		AREA	TestData, DATA, READWRITE
hexstr DCB		"-ABC1",0		;null terminated string

	END

