#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

#define del1 250
#define del2 25

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
    
    char c;
    int geral=0;
    int i;
    
    DDRD |= 0b11110000; // Step Motor PD7 a PD4
    PORTD = 0b10100000;
    
    DDRB |= 0b00000110; // Enable Step Motor
    PORTB = 0b00000110;
    
    DDRC |= 0b00011000; // Led PC3 e PC4 - Botão PC0 a PC2
    PORTC = 0b00011111; // Lembrar que os 3 menos significativos são pull-up dos resistores
    
    _delay_loop_2(0);
    
    printf("ECA - Estrutura Controladora de motores Avancada\n");
    
    for(;;)
    {   
        /******************************/
        /* F = frente                 */
        /* B = tras                   */
        /******************************/
        c = uart_getchar();
        if (c == 'F' || c == 'B' || c == 'f' || c == 'b' || c == 'T' || c== 't'){
            printf("%c", c );
            
            if (c == 'F' || c == 'f'){
                PORTB = 0b00000110;
                geral = geral + 10 * (uart_getchar() - 48);
                geral = geral + (uart_getchar() - 48);
                printf("%d\n", geral);
                step(geral);
                printf("OK!\n");
                geral = 0;
                PORTB = 0b00000000;
            }

            
            if (c == 'B' || c == 'b'){
                PORTB = 0b00000110;
                geral = geral + 10 * (uart_getchar() - 48);
                geral = geral + (uart_getchar() - 48);
                printf("%d\n", geral);
                step(-geral);
                printf("OK!\n");
                geral = 0;
                PORTB = 0b00000000;
            }

            if (c == 'T' || c == 't'){
                printf("1!\n");
                PORTD = 0b10100000; //n1
                for(i=0;i<del2;i++) _delay_loop_2(del1);
                printf("2!\n");
                PORTD = 0b01100000; //n2
                for(i=0;i<del2;i++) _delay_loop_2(del1);
                printf("3!\n");
                PORTD = 0b01010000; //n3
                for(i=0;i<del2;i++) _delay_loop_2(del1);
                printf("4!\n");
                PORTD = 0b10010000; //n4
                for(i=0;i<del2;i++) _delay_loop_2(del1);
                printf("OK!\n");
            }

        }
    }
}
