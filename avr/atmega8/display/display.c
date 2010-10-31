#include <avr/io.h>
#include <avr/interrupt.h>

#include <util/delay_basic.h>


#define SHIFT_PORT PORTD
#define SHIFT_DDR DDRD

#define LINHA_DATA PD4
#define LINHA_CLOCK PD5
#define LINHA_LATCH PD6

#define COLUNA_CLOCK PD2
#define COLUNA_RESET PD3

void Wait()
{
   uint8_t i;
   for(i=0;i<50;i++)
   {
      _delay_loop_2(0);
   }
}

void delay()
{
   _delay_loop_1(5);
}

void pulse(uint8_t pin)
{
   PORTD |= _BV(pin);
   delay();
   PORTD &= ~(_BV(pin));
}

void out_595(uint8_t i)
{
   uint8_t k;
   k = 0b10000000;
   while (k>0b00000000)
   {
      delay();
	  if (i/k == 0) PORTD &= ~(_BV(LINHA_DATA));
      if (i/k == 1) PORTD |= _BV(LINHA_DATA);
      pulse(LINHA_CLOCK);
	  i = i%k;
	  k>>=1;
   }
   delay();   //Espera de novo
   PORTD |= _BV(LINHA_LATCH);
   PORTD |= _BV(LINHA_CLOCK);
   PORTD |= _BV(COLUNA_CLOCK);
   delay();
   PORTD &= ~(_BV(LINHA_CLOCK));
   PORTD &= ~(_BV(COLUNA_CLOCK));
   PORTD &= ~(_BV(LINHA_LATCH));
}


void main()
{
   uint8_t display[15];
   uint8_t i=0;

   //Space invaders bitmap
   display[0] = 0b01111111;
   display[1] = 0b00001001;
   display[2] = 0b00001001;
   display[3] = 0b00001111;
   display[4] = 0b00000000;
   display[5] = 0b01111000;
   display[6] = 0b01001000;
   display[7] = 0b01001000;
   display[8] = 0b01111000;
   display[9] = 0b00000000;
   display[10] = 0b01111111;
   display[11] = 0b00100000;
   display[12] = 0b00100000;
   display[13] = 0b00000000;
   display[14] = 0b01110100;

   //Port D
   SHIFT_DDR=0xFF; //Porta D totalmente como saida.
   
   //Porta D zerada
   SHIFT_PORT=0x00;

   //Infinite loop
   while(1)
   {
      pulse(COLUNA_RESET);
	  delay();
      for(i=0;i<15;i++){
	     out_595(display[i]);
      }
   }
}
