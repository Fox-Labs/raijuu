#include <stdio.h>
#include <avr/io.h>
#include <util/delay.h>

#define FOSC 16000000
#define F_CPU 16000000

int main(){
   
   DDRB |= 0b00001000 ;//set PB3 as output
   
   int i;
   
   //Infinite loop
   for(;;){
      PORTB = 0b00001000;
      for (i = 0; i<1000; i++) _delay_ms(10);
      PORTB = 0b00000000;
      for (i = 0; i<1000; i++) _delay_ms(10);
   }
}
