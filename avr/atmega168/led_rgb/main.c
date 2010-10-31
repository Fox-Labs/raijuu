#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

#define RED OCR2A
#define BLUE OCR1A
#define GREEN OCR1B


void initusart();   //initializes USART
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void initPWM();   //initializes ADC
uint8_t hex(char hez);

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

void initusart(){
   //1 = output, 0 = input
   DDRD |= 0b00000010;  //(TXD on PD1)
   DDRD &= ~(0b00000001);  //(RXD on PD0)

   //USART Baud rate: 9600
   UBRR0H = (8<<MYUBRR);
   UBRR0L = MYUBRR;
   UCSR0B = (1<<RXEN0)|(1<<TXEN0)|(1<<RXCIE0);
   UCSR0C = (1<<USBS0)|(3<<UCSZ00);

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
   //set up 3 PWM channels on PB1, PB2 and PB3
   DDRB |= 0b00001110 ;   //set PB1, PB2 and PB3 as outputs
   BLUE = GREEN = RED = 0;   //PWMs set to zero
   //timer 1 - 8 bit Fast PWM - no pre-scaler - non-inverting
   //timer 2 - 8 bit Fast PWM - no pre-scaler - non-inverting
   TCCR1B = (0 << WGM13) | (1<<WGM12) | (0 << CS12) | (0 << CS11) | (1 << CS10);
   TCCR1A = (0 << WGM11) | (1<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
   TCCR2A = (1 << WGM21) | (1<<WGM20) | (1 << COM2A1) | (0 << COM2A0);
   TCCR2B = (0 << CS22) | (0 << CS21) | (1 << CS20);
}

uint8_t hex(char hex){
   if (hex > 47 && hex <58) return (hex - 48);
   if (hex > 64 && hex <71) return (hex - 55);
   if (hex > 96 && hex <103) return (hex - 87);
}

int main(){

   uint8_t dez, uni;

   //Enable USART
   initusart();

   //Enable PWM
   initPWM();

   BLUE = GREEN = RED = 255;
   _delay_loop_2(0);
   BLUE = GREEN = RED = 0;
   
   //Infinite loop
   for(;;){
      if ( uart_getchar() == '#'){
         printf ("#");
         
         dez = uart_getchar();
         uni = uart_getchar();
         RED = hex(dez)*16 + hex(uni);
         printf ("%c%c",dez,uni);
         
         dez = uart_getchar();
         uni = uart_getchar();
         GREEN = hex(dez)*16 + hex(uni);
         printf ("%c%c",dez,uni);
         
         dez = uart_getchar();
         uni = uart_getchar();
         BLUE = hex(dez)*16 + hex(uni);
         printf ("%c%c\n",dez,uni);
      }
   }
}
