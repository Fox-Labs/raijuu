#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

#define del1 250
#define del2 25

#define passo 15

void initUSART();
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void step(int n);

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

void initUSART(){
    DDRD |= 0b00000010;
    DDRD &= ~(0b00000001);

    UBRRH = (8<<MYUBRR);
    UBRRL = MYUBRR;
    UCSRB = (1<<RXEN)|(1<<TXEN);
    UCSRC = (1<<URSEL)|(3<<UCSZ0);

    stdout = &mystdout;
}

static int uart_putchar(char c, FILE *stream){
    if (c == '\n') uart_putchar('\r', stream);
    loop_until_bit_is_set(UCSRA, UDRE);
    UDR = c;
    return 0;
}

uint8_t uart_getchar(){
    while( !(UCSRA & (1<<RXC)) );
    return(UDR);
}

void step(int n){
    int i,j;
    if (n > 0){
        for(i = 0; i < n; i++){
            PORTD = 0b10100000; //n1
            for(j=0;j<del2;j++) _delay_loop_2(del1);
            PORTD = 0b01100000; //n2
            for(j=0;j<del2;j++) _delay_loop_2(del1);
            PORTD = 0b01010000; //n3
            for(j=0;j<del2;j++) _delay_loop_2(del1);
            PORTD = 0b10010000; //n4
            for(j=0;j<del2;j++) _delay_loop_2(del1);
        }
    }
    if (n < 0){
        n = -n;
        for(i = 0; i < n; i++){
            PORTD = 0b10010000; //n4
            for(j=0;j<del2;j++) _delay_loop_2(del1);
            PORTD = 0b01010000; //n3
            for(j=0;j<del2;j++) _delay_loop_2(del1);
            PORTD = 0b01100000; //n2
            for(j=0;j<del2;j++) _delay_loop_2(del1);
            PORTD = 0b10100000; //n1
            for(j=0;j<del2;j++) _delay_loop_2(del1);
        }
    }
}



int main()
{
    initUSART();
    int i;
    int pos = 0;
    
    DDRD |= 0b11110000; // Step Motor PD7 a PD4
    PORTD = 0b10100000;
    
    DDRB |= 0b00000110; // Enable Step Motor
    PORTB = 0b00000110;
    
    DDRC |= 0b00011100; // Led PC3 e PC4 - Botão PC0 a PC2
    PORTC = 0b000001011; // Lembrar que os 3 menos significativos são pull-up dos resistores
    
    for(i=0;i<150;i++) _delay_loop_2(0);
    PORTC = 0b000010011;
    for(i=0;i<100;i++) _delay_loop_2(0);
    PORTC = 0b00000011;
    
    printf("ECA - Estrutura Controladora de motores Avancada\n");
    
    for(;;)
    {   
        
        //for(;;) printf("PINC = %d\n", PINC);
        
        if (PINC == 0b00000001){
            _delay_loop_2(del1);
            if (PINC == 0b00000001){
                PORTC = 0b00010011;
                step(passo);
                pos += 1;
                PORTC = 0b00000011;
                while (PINC != 0b00000011);
                for(i=0;i<10;i++) _delay_loop_2(0);
            }
        }
        
        if (PINC == 0b00000010){
            _delay_loop_2(del1);
            if (PINC == 0b00000010){
                PORTC = 0b00010011;
                step(2 * passo);
                pos += 2;
                PORTC = 0b00000011;
                while (PINC != 0b00000011);
                for(i=0;i<10;i++) _delay_loop_2(0);
            }
        }
        
        if (pos >= 5){
            PORTC = 0b00011011;
            step(-passo * 5);
            pos = 0;
            for(i=0;i<10;i++) _delay_loop_2(250);
            PORTC = 0b00000011;
        }
        
    }
}
