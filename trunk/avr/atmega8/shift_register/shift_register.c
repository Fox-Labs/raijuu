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


void delay_595()
{
   _delay_loop_1(5);
}

void clock_595()
{
   PORTD |= _BV(PD1);
   delay_595();
   PORTD &= ~(_BV(PD1));
}

void out_595(uint8_t i)
{
   uint8_t k;
   k = 0b10000000;
   while (k>0b00000000)
   {
	  PORTD = i/k;   //Coloca o digito mais significativo (atualmente) na porta de dado
      clock_595();
	  i = i%k;
	  k>>=1;
   }
   delay_595();   //Espera de novo
   PORTD |= _BV(PD2);
   clock_595();
   PORTD = 0x00;
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
	  if (i==16) i=1;
      Wait();
	  out_595(i);
   }
}
