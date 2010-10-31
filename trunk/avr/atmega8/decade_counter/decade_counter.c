#include <avr/io.h>
#include <avr/interrupt.h>

#include <util/delay_basic.h>


#define SHIFT_PORT PORTD
#define SHIFT_DDR DDRD


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

void clock_4017()
{
   PORTD |= _BV(PD3);
   delay();
   PORTD &= ~(_BV(PD3));
}

void reset_4017()
{
   PORTD |= _BV(PD4);
   delay();
   PORTD &= ~(_BV(PD4));
}


void main()
{

   uint8_t i=0;

   //Port D
   SHIFT_DDR=0xFF; //Porta D totalmente como saida.
   
   //Porta D zerada
   SHIFT_PORT=0x00;

   //Infinite loop
   while(1)
   {
	  i++;
	  if (i==4)
	  {
         i=0;
         reset_4017();
		 Wait();
      }
	  else
	  {
         clock_4017();
         Wait();
      }
   }
}
