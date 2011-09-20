#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1


void initUSART();   //initializes USART
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void initPWM();   //initializes ADC

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

void initUSART(){
    //1 = output, 0 = input
    DDRD |= 0b00000010;  //(TXD on PD1)
    DDRD &= ~(0b00000001);  //(RXD on PD0)

    //USART Baud rate: 9600
    UBRR0H = (8<<MYUBRR);
    UBRR0L = MYUBRR;
    UCSR0B = (1<<RXEN0)|(1<<TXEN0)|(1<<RXCIE0);
    UCSR0C = (3<<UCSZ00);

    stdout = &mystdout; //Required for printf init
}

static int uart_putchar(char c, FILE *stream){
   if (c == '\n') uart_putchar('\r', stream);

   loop_until_bit_is_set(UCSR0A, UDRE0);
   UDR0 = c;

   return 0;
}

uint8_t uart_getchar(){
   while( !(UCSR0A & (1<<RXC0)) );
   return(UDR0);
}

void initPWM()
{
   //set up 2 PWM channels on PB1 and PB2 using Timer1
   DDRB |= _BV(1) |  _BV(2);   //set PB1 and PB2 as outputs
   OCR1A = OCR1B = 0;   //PWM set to zero
   //timer 1 - 8 bit Fast PWM - divided by 1024 - non-inverting
   TCCR1B = (0 << WGM13) | (1<<WGM12) | (1 << CS12) | (0 << CS11) | (1 << CS10);
   TCCR1A = (0 << WGM11) | (1<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
}

int main()
{
   uint8_t p;

   //Enable USART
   initUSART();

   //Enable PWM
   initPWM();

   //Blink the two leds on start up
   //OCR1A = 255;
   //_delay_loop_2(0);
   OCR1A = 0;
   
   //Infinite loop
   while(1)
   {

      if ( uart_getchar() == '#')
      {
         p = 100 * (uart_getchar() - 48);
		 p = p + 10 * (uart_getchar() - 48);
		 p = p + (uart_getchar() - 48);
		 printf ("#%d\n",p);
		 OCR1A = p;
      }
   }
}
