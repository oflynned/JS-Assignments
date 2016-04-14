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

aloop	
	bl	starter
	b	aloop  		; branch always
;main program execution will never drop below the statement above.

	AREA	InterruptStuff, CODE, READONLY
interrupt_handler	sub	lr,lr,#4
	stmfd	sp!,{r0-r5, r7, r12,lr}	; the lr will be restored to the pc	--> saving the workspace to the stack

;this is the body of the interrupt handler


	 ldr r7, =counter
	 ldr r12, [r7]
	 add r12, r12, #1	 ;increment counter
	 str r12, [r7] 		;Store new counter value


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
		
starter
	ldr r7, =counter
	ldr r12, [r7]

 	ldr	r3,=0x00010000	; start with P1.16.
	ldr r4, = 0x00020000 ;LED 17
 	;str	r3,[r9]	   		; clear the bit -> turn on the LED
	str	r4,[r8]			;set the bit -> turn off the LED 1
	str	r3,[r8]			;set the bit -> turn off the LED 1
	;Count to 200 --> 200*5ms = 1s

	 cmp r12, #400
	 BCS greater_than400
	 str	r3,[r8]			;set the bit -> turn off the LED 1
	 str	r4,[r9]		  	;Turn on LED 17
greater_than400

	;	str r4,[r8]	   		;Turn off LED 17
;		str	r3,[r9]	 	 ;Turn on the LED

	 cmp r12, #800
	 BCC greater_than600		
		str r4,[r8]	   		;Turn off LED 17
		str	r3,[r9]	 	 ;Turn on the LED
greater_than600

	cmp r12, #1000
	BNE keepcounting
 	mov r12, #0		;Restarting the counter to 1 second
	str r12, [r7] 	;Stores zero value into counter
keepcounting
	bx lr

	AREA	Stuff, DATA, READWRITE

;starting_light	dcd		0x00010000	;Pin 16
counter		 	dcd		0	 ;Set the value to 0
shift_counter 	dcd		-1	 ;Set the value to 0
	END


