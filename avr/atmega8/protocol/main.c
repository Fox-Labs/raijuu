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
void initpwm();   //initializes PWM
void initadc();   //initializes ADC
uint16_t readadc(uint8_t ch); //reades ADC

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

void initadc(){
   ADMUX=(1<<REFS0);// For Aref=AVcc;
   ADCSRA=(1<<ADEN)|(7<<ADPS0);
}

uint16_t readadc(uint8_t ch){
   ADMUX|=ch;
   
   //Start Single conversion
   ADCSRA|=(1<<ADSC);

   //Wait for conversion to complete
   while(!(ADCSRA & (1<<ADIF)));
       
   //Clear ADIF by writing one to it
   ADCSRA|=(1<<ADIF);
   
   return(ADC);
}

void initpwm(){
    //set up 2 PWM channels on PB1 and PB2 using Timer1 and 1 PWM channel on PB3 using Timer2
    DDRB |= 0b00001110;   //set PB1, PB2 and PB3 as outputs
    //timer 1 - 16 bit Phase+Frequency correct - pre-scaler of 8- non-inverting
    TCCR1B = (1 << WGM13) | (0<<WGM12) | (0 << CS12) | (1 << CS11) | (0 << CS10);
    TCCR1A = (1 << WGM11) | (0<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
    ICR1 = 20000;
    //timer 2 - 8 bit fast PWM - pre-scaler of 8- non-inverting
    TCCR2 = (1 << WGM21) | (1 << WGM20) | (0 << CS22) | (0 << CS21) | (1 << CS20) | (1 << COM21) | (0 << COM20);
    //PB1 and PB2 PWM sets to 1ms
    OCR1A = OCR1B = 1400;  
    //PB3 duty cicle set to 0
    OCR2 = 0;    
}

int main(){
    uint16_t geral;
    int i;
    char c;//Caracter
    
    //PD4 to PD7 as outputs
    DDRD|=0b11110000; 
    
    //Enable USART
    initusart();
    //Enable PWM
    initpwm();
    //Enable ADC
    initadc();
    
    //Infinite loop
    for(;;){
        if (uart_getchar() == '#'){
            /******************************/
            /* ? = help                   */ 
            /* S = servo                  */
            /* O = out                    */
            /* T = temperature            */
            /* B = blink                  */
            /* P = open                   */
            /* c = temperature in celcius */
            /******************************/
            c = uart_getchar();
            if (c == 'S' || c == 'O' || c == 'T' || c == 'B' || c == 'P' || c == 'c' || c== '?'){
                printf("#%c", c );
                if (c == 'S' || c == 'B'){
                    geral = 1000 * (uart_getchar() - 48);
                    geral = geral + 100 * (uart_getchar() - 48);
                    geral = geral + 10 * (uart_getchar() - 48);
                    geral = geral + (uart_getchar() - 48);
                    if (c == 'S') OCR1A = geral;
                    if (c == 'B') OCR2 = geral;
                    printf("%d\n", geral);
                }
                
                if (c == 'O'){
                    geral = 16 * (uart_getchar() - 48);
                    geral = geral + 32 * (uart_getchar() - 48);
                    geral = geral + 64 * (uart_getchar() - 48);
                    geral = geral + 128 * (uart_getchar() - 48);
                    if (geral <= 240){
                        PORTD &= 0b00001111;
                        PORTD = PORTD + geral;
                        printf("%d\n", PORTD);
                    }
                    else printf("ERRO\n");
                }
                
                if (c == 'T'){
                    geral = readadc(0);
                    if (geral > 999) printf("%d\n", geral);
                    if (geral < 999 && geral > 99) printf("0%d\n", geral);
                    if (geral < 99 && geral > 9) printf("00%d\n", geral);
                    if (geral < 9) printf("000%d\n", geral);                        
                }
                
                if (c == 'P'){
                    OCR1A = 1000;
                    for(i=0;i<50;i++) _delay_loop_2(0);
                    OCR1A = 2000;
                    for(i=0;i<50;i++) _delay_loop_2(0);
                    OCR1A = 1000;
                    printf("\n");
                }
                
                if (c == 'c'){
                    geral = readadc(0);
                    printf(" - Room temperature is %d C\n", geral/2);
                }
                
                if (c == '?'){
                    printf("\n? = help\n"); 
                    printf("S = servo\n");
                    printf("O = out\n");
                    printf("T = temperature\n");
                    printf("B = blink\n");
                    printf("P = open\n");
                    printf("c = temperature in celcius\n");
                }
                
                geral = 0;
            }
        }
    }
}
