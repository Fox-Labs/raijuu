//Teste para a plaquinha do IR-Lirc:
//
//Faz o LED (PIND5) piscar seguindo a entrada do sensor de IR (PIND6),
//lembrando que o sinal de saida do sensor de IR é invertida.

#include <avr/io.h>
#include <avr/interrupt.h>

#include <util/delay_basic.h>

#define SHIFT_PORT PORTD
#define SHIFT_DDR DDRD

void main()
{
   SHIFT_DDR=0b00100000; //Pino PD5 como saida
   //Infinite loop
   while(1)
   {
	  if (PIND & 0b01000000)
	  {
		PORTD = 0b00000000;
      }
	  else PORTD = 0b00100000;
   }
}
