/* Controle de 2 servos atraves da porta serial */

#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1


void initusart();   //initializes USART
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void initpwm();   //initializes PWM

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

void initusart(){
    //1 = output, 0 = input
    DDRD |= 0b00000010;  //(TXD on PD1)
    DDRD &= ~(0b00000001);  //(RXD on PD0)

    //USART Baud rate: 9600
    UBRRH = (8<<MYUBRR);
    UBRRL = MYUBRR;
    UCSRB = (1<<RXEN)|(1<<TXEN);
    UCSRC = (1<<URSEL)|(3<<UCSZ0);

    stdout = &mystdout; //Required for printf init
}

static int uart_putchar(char c, FILE *stream)
{
   if (c == '\n') uart_putchar('\r', stream);

   loop_until_bit_is_set(UCSRA, UDRE);
   UDR = c;

   return 0;
}

uint8_t uart_getchar()
{
   while( !(UCSRA & (1<<RXC)) );
   return(UDR);
}

void initpwm(){
    //set up 2 PWM channels on PB1 and PB2 using Timer1
    DDRB |= 0b00000110;   //set PB1 and PB2 as outputs
    OCR1A = OCR1B = 1000;   //PWM set to zero
    //timer 1 - 8 bit Fast PWM - no pre-scaler - non-inverting
    TCCR1B = (1 << WGM13) | (0<<WGM12) | (0 << CS12) | (1 << CS11) | (0 << CS10);
    TCCR1A = (1 << WGM11) | (0<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
    ICR1 = 20000;
}

int main(){
    uint16_t p; //position
    char s;//servo

    //Enable USART
    initusart();

    //Enable PWM
    initpwm();

    //Infinite loop
    while(1){
        if ( uart_getchar() == '#'){
            s = uart_getchar();
            p =  1000*(uart_getchar() - 48);
            p =  p + 100*(uart_getchar() - 48);
            p =  p + 10*(uart_getchar() - 48);
            p =  p + (uart_getchar() - 48);
            printf ("#%c%d\n",s,p);
            if (s == 'A') OCR1A = p;
            if (s == 'B') OCR1B = p;
            p = s = 0;
        }
    }
}
