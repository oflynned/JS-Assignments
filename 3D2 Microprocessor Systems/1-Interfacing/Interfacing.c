/******************************************************************************
 *
 * Sample program to make the LEDs P1.16 -- P1.19 light up in sequence, endlessly
 * (c) Mike Brady, 2011.
 *
 *****************************************************************************/
                  
#include <LPC213x.H>                    /* LPC213x definitions                */
#include <stdio.h>

extern void start (void);
extern void init_serial (void);		    /* Initialize Serial Interface   */

//pins
const int a = 8;
const int b = 9;
const int c = 10;
const int d = 17;
const int e = 12;
const int f = 13;
const int g = 16;
const int dp = 15;

unsigned int illuminate(int num) {
	switch(num){
		case 15:
			//f
			return (1<<b) | (1<<c) | (1<<d); 
		case 14:
			//e
			return (1<<b) | (1<<c);
		case 13:
			//d
			return (1<<a) | (1<<f);
		case 12:
			//c
			return (1<<b) | (1<<c) | (1<<g);
		case 11:
			//b
			return (1<<a) | (1<<b);
		case 10:
			//a
			return (1<<d);
		case 9:
			return (1<<d) | (1<<e);
		case 8:
			return (1<<dp);
		case 7:
			return (1<<d) | (1<<g) | (1<<f) | (1<<e);
		case 6:
			return (1<<b);
		case 5:
			return (1<<b) | (1<<e);
		case 4:
			return (1<<e) | (1<<d) | (1<<a);
		case 3:
			return (1<<f) | (1<<e);
		case 2:
			return (1<<f) | (1<<c);
		case 1:
			return (1<<a) | (1<<d) | (1<<e) | (1<<f) | (1<<g);
		case 0:
			return (1<<g);
		default:
			return 0x0000000;
	}		
}

void delay (void) {                     /* Delay function                     */
	unsigned int cnt;
	for (cnt = 0; cnt < 5000000; cnt++);
}

int main (void) {
	unsigned int mask;
	init_serial();
	
	//print welcome message
	printf("\n*********************************************************");
	printf("\n*  Make LEDs P1.16 to P1.19 flash on and off in sequence.");
	printf("\n*********************************************************");

	//Set P1.16 as an output

	IO0DIR = 0x0003B700;   // P1.16 to P1.19 are outputs
 	IO0SET = 0x0003B700;   // Turn 'em off

	while(1) {
		/*for (mask=0x00010000;mask<0x00100000;mask<<=1) {
			IO0CLR = mask;	// turn on the led by pulling output low
			delay();
			IO0SET = mask;	// turn off the led again...
		} */

			int count;
			for(count = 15; count>=0; count--){
				IO0CLR = illuminate(count);	// turn on the led by pulling output low
				delay();
				IO0SET = illuminate(count);
			}
	}

// The following is commented out because it will never be executed.
//	return 0;
}



