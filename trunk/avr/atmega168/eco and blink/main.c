#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1


void initusart();   //initializes USART
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();

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

ISR(USART_RX_vect){
   printf("%c", uart_getchar() );
}

int main(){

   //Enable USART
   initusart();

   DDRB |= 0b00001000 ;//set PB3 as output
   
   int i;
   
   printf("Blink");
   
   sei();
   
   for(;;){
      printf("Blink");
      PORTB = 0b00001000;
      for (i = 0; i<1000; i++) _delay_ms(10);
      PORTB = 0b00000000;
      for (i = 0; i<1000; i++) _delay_ms(10);
   }
}
