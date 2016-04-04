	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

;Assignment 3 c --

	EXPORT	start
start

I01PIN  EQU 0xE0028010 ;(Input Output Pin Value Register) contains the current condition of the GPIO 1 pins.

IO0DIR	EQU	0xE0028008 ;Input Output Direction Register contains the direction assignments for each I/O port bit. The checkboxes are checked for output and unchecked for input.
IO0SET	EQU	0xE0028004 ;(Input Output Set Register) bits are checked to force a high level for a that port bit during output.
IO0CLR	EQU	0xE002800C ;(Input Output Clear Register) bits are checked to force a low level for a that port bit during output

	ldr	r1,=IO0DIR
	ldr	r7,=0x0003B700	;select pin segs
	str	r7,[r1]			;make them outputs
	ldr	r1,=IO0SET
	ldr	r2,=IO0CLR		; r2 points to the CLEAR register
	str r7, [r2]		; turn them all off w/clr
	ldr	r0,=I01PIN 		;Location of pin pressed
	
nextled
	ldr	r3, =lut		
	
	ldr	r6, [r0]		;check curr pin status
	ldr	r8, = 0x00F00000;  mask for switch bits
	and	r6, r6, r8	
	eor	r6, r6, r8
	
	lsr	r6, r6, #20	 

	mov	r5, #4
checkPin
	lsrs	r6, r6, #1		;; then shift the next bit in from r6
	bcs 	litSeg			;;
	add 	r3, r3, #4		;; otherwise shift the pointer to lut by 4 bytes
	subs r5, #1
	beq		nextled
	b 		checkPin
	
litSeg	
	str		r7, [r2]		; turn them all off w/clr
	ldr 	r4, [r3]
	str 	r4, [r1]		; set the bit -> turn on segs

	b nextled

stop	B	stop

lut	dcd	0x00023700 ; 0
	dcd	0x00000600 ; 1
	dcd	0x00031300 ; 2
	dcd	0x00030700 ; 3

	END
		
		






