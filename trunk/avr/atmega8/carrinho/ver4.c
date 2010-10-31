/****************************************************/
/*  Versão Funcionando na Pista                     */
/*  Precisa das labaredas e as vezes não faz o gap  */
/****************************************************/

#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

#define ESQ OCR1A
#define DIR OCR1B
#define FULL 153
#define P 40
#define D 20
#define delay 25
#define SOMA 300

#define A1 0
#define A2 0
#define A3 0
#define A4 0
#define A5 0

void initUSART();
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void initADC();
uint16_t readADC(uint8_t ch);
void wait();
void initPWM();
uint16_t sensor();

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

void initADC(){
    ADMUX=(1<<REFS0);
    ADCSRA=(1<<ADEN)|(7<<ADPS0);
}

uint16_t readADC(uint8_t ch){
    ch=ch&0b00000111;
    ADMUX&=0b11110000;
    ADMUX|=ch;
    ADCSRA|=(1<<ADSC);
    while(!(ADCSRA & (1<<ADIF)));
    ADCSRA|=(1<<ADIF);
    return(ADC);
}

void initPWM(){
   //set up 2 PWM channels on PB1 and PB2 using Timer1
   DDRB |= _BV(1) |  _BV(2);   //set PB1 and PB2 as outputs
   OCR1A = OCR1B = 0;   //PWM set to zero
   //timer 1 - 8 bit Fast PWM - no pre-scaler - non-inverting12
   TCCR1B = (0 << WGM13) | (0<<WGM12) | (0 << CS12) | (1 << CS11) | (1 << CS10);
   TCCR1A = (0 << WGM11) | (1<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
}

uint16_t sensor(uint16_t e_anterior){
    float e;
    uint16_t adc1, adc2, adc3, adc4, adc5;
    adc1 = readADC(4) - A1;
    adc2 = readADC(3) - A2;
    adc3 = readADC(2) - A3;
    adc4 = readADC(1) - A4;
    adc5 = readADC(0) - A5;
    if ( (adc1 + adc2 + adc3 + adc4 + adc5) < SOMA) e = e_anterior;
    else e = ( ( (adc1 * -2.0) + (adc2 * -1.0) + (adc3 * 0.0) + (adc4 * 1.0) + (adc5 * 2.0) ) / (adc1 + adc2 + adc3 + adc4 + adc5) ) * 30;
    return e;
}

void motor(int out){
    if (out < 0) {
        DIR = FULL;
        if ( (FULL + out) < 0) ESQ = 0;
        else ESQ = FULL + out;
        printf("E:%d D:%d    ", FULL + out, FULL);
    }
    
    if (out > 0) {
        ESQ = FULL;
        if ( (FULL - out) < 0) DIR = 0;
        else DIR = FULL - out;
        printf("E:%d D:%d    ", FULL, FULL - out);
    }
    
    if (out == 0) {
        ESQ = FULL;
        DIR = FULL;
        printf("E:%d D:%d    ", FULL, FULL);
    }
    
}    

int main()
{
    DDRD |= 0b11110000;
    PORTD = 0b10100000;
    
    int i;
    char c = '3';
    uint16_t e = 0, e_anterior = 0;
    uint16_t out;
    uint16_t adc1, adc2, adc3, adc4, adc5;
	
    initADC();
    initUSART();
    initPWM();
    //printf("1: Ler valores do sensor RAW + E\n2: Ajustar variaveis\n3: Rodar\n");
    for(i=0;i<50;i++) _delay_loop_2(0);
        
    //c = uart_getchar();
    /******************************/
    /* 1 = RAW + E                */ 
    /* 2 = Ajuste                 */
    /* 3 = Rodar                  */
    /******************************/
    if (c == '1' || c == '2' || c == '3'){
        printf("%c", c );
        if (c == '1'){
            for(;;){
                adc1 = readADC(4) - A1;
                adc2 = readADC(3) - A2;
                adc3 = readADC(2) - A3;
                adc4 = readADC(1) - A4;
                adc5 = readADC(0) - A5;
                printf("V1:%4d  V2:%4d  V3:%4d  V4:%4d  V5:%4d    ", adc1, adc2, adc3, adc4, adc5);
                e = sensor(e_anterior);
                printf("ERRO:%d    ", e);
                out = (int) ( P * e + D * (e - e_anterior) ) / 10;
                printf("O:%d\n", out);
                e_anterior = e;
            }
        }
        
        if (c == '2'){
        }
        
    }

    //e_anterior = sensor();
    for(;;)
    {   
        e = sensor(e_anterior);
        printf("ERRO:%d     ", e);
        out = (int) ( P * e + D * (e - e_anterior)) / 10;
        //if ( out <= 255 && out >= -255)
        motor(out);
        printf("O:%d\n", out);
	    e_anterior = e;
        _delay_loop_2(delay);
        /*
	    CR = %
	    255 = 100
	    230 = 90
	    204 = 80
	    178 = 70
	    153 = 60
	    128 = 50
	    102 = 40
	    77 = 30
	    51 = 20
	    26 = 10
	    */
    }
}
