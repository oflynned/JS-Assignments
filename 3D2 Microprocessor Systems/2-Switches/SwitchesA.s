	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

; sample program makes the 4 LEDs P1.16, P1.17, P1.18, P1.19 go on and off in sequence
; (c) Mike Brady, 2011.

;Assignment 2 a

	EXPORT	start
start

IO1DIR	EQU	0xE0028018 ;Input Output Direction Register contains the direction assignments for each I/O port bit. The checkboxes are checked for output and unchecked for input.
IO1SET	EQU	0xE0028014 ;(Input Output Set Register) bits are checked to force a high level for a that port bit during output.
IO1CLR	EQU	0xE002801C ;(Input Output Clear Register) bits are checked to force a low level for a that port bit during output
I01PIN  EQU 0xE0028010 ;(Input Output Pin Value Register) contains the current condition of the GPIO 1 pins.

	ldr	r1,=IO1DIR
	ldr	r2,=0x000f0000	;select P1.19--P1.16
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO1SET
	str	r2,[r1]		;set them to turn the LEDs off
	ldr	r2,=IO1CLR
; r1 points to the SET register
; r2 points to the CLEAR register



	ldr	r5,=0x00100000	; end when the mask reaches this value
wloop	ldr	r3,=0x00010000	; start with P1.16.
floop	

	ldr		r0, =I01PIN ;Location of pin pressed
nextled
	ldr		r6, [r0]
	ldr		r7, = 0x00F00000;  mask for switch bits
	and		r6, r6, r7	
	eor		r6, r6, r7
	mov		r6, r6, LSR #4	 ;Leaves on the bit we want at 0, everything else at 1
	str 	r6,[r2]			; clear the bit -> turn on the led

;delay for about a half second
	ldr	r4,=1000000
dloop	subs	r4,r4,#1 ;Cycles through until r4=0
	bne	dloop

	str r6, [r1] ;Turn the LED pff again by setting the bit
	
	b nextled
	b	wloop
stop	B	stop

	END


