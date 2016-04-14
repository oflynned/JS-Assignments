; Definitions  -- references to 'UM' are to the User Manual.

; Timer Stuff -- UM, Table 173

T0	equ	0xE0004000		; Timer 0 Base Address
T1	equ	0xE0008000					

IR	equ	0			; Add this to a timer's base address to get actual register address
TCR	equ	4
MCR	equ	0x14
MR0	equ	0x18

TimerCommandReset	equ	2
TimerCommandRun	equ	1
TimerModeResetAndInterrupt	equ	3
TimerResetTimer0Interrupt	equ	1
TimerResetAllInterrupts	equ	0xFF

; VIC Stuff -- UM, Table 41
VIC	equ	0xFFFFF000		; VIC Base Address
IntEnable	equ	0x10	;  Interrupt Enable Register. This register controls which of the 32 interrupt requests and software interrupts are enabled to contribute to FIQ or IRQ.
VectAddr	equ	0x30    ; Vector Address Register. When an IRQ interrupt occurs, the IRQ service routine can read this register and jump to the value read.
VectAddr0	equ	0x100	; Vector address 0 register. Vector Address Registers 0-15 hold the addresses of the Interrupt Service routines (ISRs) for the 16 vectored IRQ slots.
VectCtrl0	equ	0x200	; Vector control 0 register. Vector Control Registers 0-15 each control one of the 16 vectored IRQ slots. Slot 0 has the highest priority and slot 15 the lowest.

Timer0ChannelNumber	equ	4				; UM, Table 63
Timer0Mask	equ	1<<Timer0ChannelNumber	; UM, Table 63
IRQslot_en	equ	5						; UM, Table 58

IO1DIR	EQU	0xE0028018
IO1SET	EQU	0xE0028014
IO1CLR	EQU	0xE002801C
IO1PIN	EQU	0xE0028010





	AREA	InitialisationAndMain, CODE, READONLY
	IMPORT	main

; (c) Mike Brady, 2014–2015.

	EXPORT	start
start

; initialisation code

 	ldr	r8,=IO1DIR
	ldr	r9,=0x000f0000	;select P1.19--P1.16
	str	r9,[r8]			;make them outputs
	ldr	r8,=IO1SET
	str	r9,[r8]			;set them to turn the LEDs off
	ldr	r9,=IO1CLR


; Initialise the VIC
	ldr	r0,=VIC			; looking at you, VIC!

	ldr	r1,=interrupt_handler			 ;Irq handler
	str	r1,[r0,#VectAddr0] 	; associate our interrupt handler with Vectored Interrupt 0

	mov	r1,#Timer0ChannelNumber+(1<<IRQslot_en)
	str	r1,[r0,#VectCtrl0] 	; make Timer 0 interrupts the source of Vectored Interrupt 0

	mov	r1,#Timer0Mask
	str	r1,[r0,#IntEnable]	; enable Timer 0 interrupts to be recognised by the VIC

	mov	r1,#0
	str	r1,[r0,#VectAddr]   	; remove any pending interrupt (may not be needed)

; Initialise Timer 0
	ldr	r0,=T0			; looking at you, Timer 0!

	mov	r1,#TimerCommandReset
	str	r1,[r0,#TCR]

	mov	r1,#TimerResetAllInterrupts
	str	r1,[r0,#IR]

	ldr	r1,=(14745600/200)-1	 ; 5 ms = 1/200 second = (14745600/200)-1
	str	r1,[r0,#MR0]

	mov	r1,#TimerModeResetAndInterrupt
	str	r1,[r0,#MCR]

	mov	r1,#TimerCommandRun
	str	r1,[r0,#TCR]

;from here, initialisation is finished, so it should be the main body of the main program

aloop	b	aloop  		; branch always
;main program execution will never drop below the statement above.

	AREA	InterruptStuff, CODE, READONLY
interrupt_handler	sub	lr,lr,#4
	stmfd	sp!,{r0-r5, r7, r12,lr}	; the lr will be restored to the pc	--> saving the workspace to the stack

;this is the body of the interrupt handler

	ldr r7, =counter
	ldr r12, [r7]
	add r12, r12, #1	 ;increment counter
	str r12, [r7] 		;Store new counter value
	
	cmp r12, #100
	blo	l_1
	cmp r12, #100
	blo	l_2
	;beq reset

l_1
	bl light_one
l_2
	bl light_two
;reset
	;mov r12, #0

;this is where we stop the timer from making the interrupt request to the VIC
;i.e. we 'acknowledge' the interrupt
	ldr	r0,=T0
	mov	r1,#TimerResetTimer0Interrupt
	str	r1,[r0,#IR]	   	; remove MR0 interrupt request from timer

;here we stop the VIC from making the interrupt request to the CPU:
	ldr	r0,=VIC
	mov	r1,#0
	str	r1,[r0,#VectAddr]	; reset VIC	  -->Clearing it

	ldmfd	sp!,{r0-r5, r7, r12,pc}^	; return from interrupt, restoring previous state
							; and also restoring the CPSR

	AREA	Subroutines, CODE, READONLY
		
light_one
	ldr		r10, =stack_one
	ldr		r11, [r10]
	;ldmfd	r11!,{r0-r9,r12,pc}^	
	ldr	r1,=IO1DIR
	ldr	r2,=0x000f0000	;select P1.19--P1.16
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO1SET
	str	r2,[r1]		;set them to turn the LEDs off
	ldr	r2,=IO1CLR
; r1 points to the SET register
; r2 points to the CLEAR register

	ldr	r5,=0x00100000	; end when the mask reaches this value
	ldr	r3,=0x00010000	; start with P1.16.
floop	str	r3,[r2]	   	; clear the bit -> turn on the LED

;delay for about a half second
	ldr	r4,=2000000
dloop	subs	r4,r4,#1
	bne	dloop

	str	r3,[r1]		;set the bit -> turn off the LED
	cmp	r3,r5
	bne	floop
	
	stmfd	r11!,{r0-r9, r12,pc}
	bx lr
	
light_two
	ldr		r10, =stack_two
	ldr		r11, [r10]
	;ldmfd	r11!,{r0-r9, r12,pc}^	
	ldr	r1,=IO1DIR
	ldr	r2,=0x000f0000	;select P1.19--P1.16
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO1SET
	str	r2,[r1]		;set them to turn the LEDs off
	ldr	r2,=IO1CLR
; r1 points to the SET register
; r2 points to the CLEAR register

	ldr	r5,=0x00100000	; end when the mask reaches this value
	ldr	r3,=0x00020000	; start with P1.16.
floop2	str	r3,[r2]	   	; clear the bit -> turn on the LED

;delay for about a half second
	ldr	r4,=2000000
dloop2	subs	r4,r4,#1
	bne	dloop2

	str	r3,[r1]		;set the bit -> turn off the LED
	cmp	r3,r5
	bne	floop2
	
	stmfd	r11!,{r0-r9, r12,pc}
	bx lr

STACK_SIZE		EQU	0x400 ;1K

	AREA	Stuff, DATA, READWRITE
counter			dcd		0
	
STK_MEM			SPACE 	STACK_SIZE
stack_one
STK_MEM2		SPACE	STACK_SIZE
stack_two

	END



