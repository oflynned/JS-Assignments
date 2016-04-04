	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

; sample program makes the 4 LEDs P1.16, P1.17, P1.18, P1.19 go on and off in sequence
; (c) Mike Brady, 2011.

	EXPORT	start
start

IO0DIR	EQU	0xE0028008 ;Input Output Direction Register contains the direction assignments for each I/O port bit. The checkboxes are checked for output and unchecked for input.
IO0SET	EQU	0xE0028004 ;(Input Output Set Register) bits are checked to force a high level for a that port bit during output.
IO0CLR	EQU	0xE002800C ;(Input Output Clear Register) bits are checked to force a low level for a that port bit during output

IO1DIR	EQU	0xE0028018 ;Input Output Direction Register contains the direction assignments for each I/O port bit. The checkboxes are checked for output and unchecked for input.
IO1SET	EQU	0xE0028014 ;(Input Output Set Register) bits are checked to force a high level for a that port bit during output.
IO1CLR	EQU	0xE002801C ;(Input Output Clear Register) bits are checked to force a low level for a that port bit during output
I01PIN  EQU 0xE0028010 ;(Input Output Pin Value Register) contains the current condition of the GPIO 1 pins.

SEGABIT		equ	8
SEGBBIT		equ	9
SEGCBIT		equ	10
SEGDBIT		equ	11
SEGEBIT		equ	12
SEGFBIT		equ	13
SEGGBIT		equ	14
SEGDPBIT		equ	15

	ldr	r1,=IO0DIR ;select pins that are driving segments & dp
	ldr	r2,=(1<<SEGABIT)+(1<<SEGBBIT)+(1<<SEGCBIT)+(1<<SEGDBIT)+(1<<SEGEBIT)+(1<<SEGFBIT)+(1<<SEGGBIT)+(1<<SEGDPBIT)
	str	r2,[r1] ;make them outputs
	;r1 points to SET
	;r2 points to CLEAR
	ldr r10, =0x00F00000 ;1000
	ldr r11, = 0x00100000
	
	ldr r1, = IO0SET
	ldr r2, = IO0CLR
	;r1 points to the set register
	;r2 points to the Clear register

	ldr	r5,=lut ;point to look up table
wloop	mov	r0,#16	;start with 0

floop	ldr	r3,[r5,r0,lsl #2]	;pick up 7 seg code for number
		str	r3,[r1]	;turn segments on
		ldr	r4,=10000000	;delay half a sec
dloop	subs	r4,r4,#1
	bne	dloop
		ldr	r9, =I01PIN ;Location of pin pressed

same2 
	ldr r7, [r9]
	ldr	r4,=1000000
loop2	
	subs	r4,r4,#1 ;Cycles through until r4=0
	bne	loop2
	and r7, r7, r10
	cmp r11, r7                            
	beq same2
	
 ;decrement value
	str	r3,[r2]
	sub	r0,#1	;reduce by 1
	cmp	r0,#-1 	;check end value... 	
	bne	floop
	b	wloop

stop	B	stop

lut	dcd	(1<<SEGABIT)+(1<<SEGBBIT)+(1<<SEGCBIT)+(1<<SEGDBIT)+(1<<SEGEBIT)+(1<<SEGFBIT) ; 0
	dcd	(1<<SEGBBIT)+(1<<SEGCBIT)+(1<<SEGDPBIT)	; 1
	dcd	(1<<SEGABIT)+(1<<SEGBBIT)+(1<<SEGDBIT)+(1<<SEGEBIT)+(1<<SEGGBIT) 	;2
	dcd	(1<<SEGABIT)+(1<<SEGBBIT)+(1<<SEGCBIT)+(1<<SEGDBIT)+(1<<SEGGBIT)	;3
	dcd (1<<SEGBBIT)+(1<<SEGCBIT)+(1<<SEGFBIT)+(1<<SEGGBIT) ;4
	dcd (1<<SEGABIT)+(1<<SEGCBIT)+(1<<SEGDBIT)+(1<<SEGFBIT)+(1<<SEGGBIT) ;5
	dcd (1<<SEGABIT)+(1<<SEGCBIT)+(1<<SEGDBIT)+(1<<SEGEBIT)+(1<<SEGFBIT)+(1<<SEGGBIT) ;6
	dcd (1<<SEGABIT)+(1<<SEGBBIT)+(1<<SEGCBIT) ;7
	dcd (1<<SEGABIT)+(1<<SEGBBIT)+(1<<SEGCBIT)+(1<<SEGDBIT)+(1<<SEGEBIT)+(1<<SEGFBIT)+(1<<SEGGBIT) ;8
	dcd (1<<SEGABIT)+(1<<SEGBBIT)+(1<<SEGCBIT)+(1<<SEGDBIT)+(1<<SEGFBIT)+(1<<SEGGBIT) ;9
	dcd (1<<SEGABIT)+(1<<SEGBBIT)+(1<<SEGCBIT)+(1<<SEGEBIT)+(1<<SEGFBIT)+(1<<SEGGBIT) ;a
	dcd (1<<SEGCBIT)+(1<<SEGDBIT)+(1<<SEGEBIT)+(1<<SEGFBIT)+(1<<SEGGBIT) ;b
	dcd (1<<SEGABIT)+(1<<SEGDBIT)+(1<<SEGEBIT)+(1<<SEGFBIT) ;c
	dcd (1<<SEGBBIT)+(1<<SEGCBIT)+(1<<SEGDBIT)+(1<<SEGEBIT)+(1<<SEGGBIT) ;d
	dcd (1<<SEGABIT)+(1<<SEGDBIT)+(1<<SEGEBIT)+(1<<SEGFBIT)+(1<<SEGGBIT) ;e
	dcd (1<<SEGABIT)+(1<<SEGEBIT)+(1<<SEGFBIT)+(1<<SEGGBIT) ;f

	END


