/********************************************/
/* Prova de conceito:                       */
/* Estudo de protocolo de comunicação.      */
/* Utiliza um servo, um LM35 e quatro leds  */
/* + um led com PWM                         */
/********************************************/

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

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

void initusart(){
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

ISR(USART_RX_vect){
    int i;
    char c, z;
    uint16_t geral;
    
    c = uart_getchar();
    if (c == '?')
        printf("help\n");//Texto com os comandos aqui
    
    if (c == '#'){
        /******************************/
        /* ? = help                   */ 
        /* S = som                    */
        /* R = rele                   */
        /* C = choque                 */
        /* P = pot                    */
        /* L = ldr                    */
        /* I = iluminação_ldr         */
        /* A = alimentador            */
        /******************************/
        c = uart_getchar();
        if (c == 'S' || c == 'R' || c == 'C' || c == 'P' || c == 'L' || c == 'L' || c == 'I' || c == 'A' || c== '?'){
            printf("#%c", c );

            if (c == 'S'){
                z = uart_getchar();
                if (z == '1'){
                    printf("1\n");
                    PORTC |= 0b00000010;
                }
                if (z == '0'){
                    printf("0\n");
                    PORTC &= ~(0b00000010);
                }
            }

            if (c == 'L'){//Tambem so pra teste, caso o resultado do LDR se altere,o mesmo sera informado por interupção
                if ( (PIND &= 0b00000100) == 1)
                    printf("1\n");
                else
                    printf("0\n");
            }
        }
        c = 0;
        geral = 0;
    }
}

int main(){
    
    //PC0 to PC7 as outputs
    DDRC|=0b11111111; 
    DDRD|=0b11011100;
    DDRB|=0b11111111;
    
    //Enable USART
    initusart();
    
    sei();//Enable all interupts
    
    printf("Poli Junior\n");
    printf("Caixa de Treinamento - v1.0\n");
    //Infinite loop
    for(;;){
        if (uart_getchar() == 'q') printf("q");
    }
}
