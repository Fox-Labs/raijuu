#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

void initUSART();
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void initADC();
uint16_t readADC(uint8_t ch);
void wait();
void initPWM();

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

/*void wait()
{
   uint8_t i;
   for(i=0;i<25;i++)
   {
      _delay_loop_2(0);
   }
}*/

void initUSART()
{
    DDRD |= 0b00000010;
    DDRD &= ~(0b00000001);

    UBRRH = (8<<MYUBRR);
    UBRRL = MYUBRR;
    UCSRB = (1<<RXEN)|(1<<TXEN);
    UCSRC = (1<<URSEL)|(3<<UCSZ0);

    stdout = &mystdout;
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

void initADC()
{
    ADMUX=(1<<REFS0);
    ADCSRA=(1<<ADEN)|(7<<ADPS0);
}

uint16_t readADC(uint8_t ch)
{
    ch=ch&0b00000111;
    ADMUX&=0b11110000;
    ADMUX|=ch;
    ADCSRA|=(1<<ADSC);
    while(!(ADCSRA & (1<<ADIF)));
    ADCSRA|=(1<<ADIF);
    return(ADC);
}

void initPWM()
{
   //set up 2 PWM channels on PB1 and PB2 using Timer1
   DDRB |= _BV(1) |  _BV(2);   //set PB1 and PB2 as outputs
   OCR1A = OCR1B = 0;   //PWM set to zero
   //timer 1 - 8 bit Fast PWM - no pre-scaler - non-inverting12
   TCCR1B = (0 << WGM13) | (1<<WGM12) | (1 << CS12) | (0 << CS11) | (0 << CS10);
   TCCR1A = (0 << WGM11) | (1<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
}

int main()
{
    DDRD |= 0b11110000;
    PORTD = 0b10100000;
    
    uint16_t adc1;
    uint16_t adc2;
    uint16_t adc3;
    uint16_t adc4;
    uint16_t adc5;
     
    initADC();
    initUSART();
    initPWM();
    
    
    
    OCR1A = OCR1B = 77;
    
    for(;;)
    {   
        
        adc1 = readADC(0);
        adc2 = readADC(1);
        adc3 = readADC(2);
        adc4 = readADC(3);
        adc5 = readADC(4);
        printf("V1:%4d V2:%4d V3:%4d V4:%4d V5:%4d\n", adc1, adc2, adc3, adc4, adc5);
        
        /*
        OCR = %
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
        
        
        if(adc4 > 600){
            OCR1A = 77;
            OCR1B = 0;
        }
        if(adc2 > 600){
            OCR1A = 0;
            OCR1B = 77;
        }
        
        /*if(adc4<600 && adc2<600){
            OCR1A = 77;
            OCR1B = 77;
        }
    
        /* Versão Guilherme
        
        if(adc4 > 500 && adc2 < 200 ){
            OCR1A = 102;
            OCR1B = 40;
        }
        else {
        if(adc2 > 500 && adc4 < 200){
            OCR1A = 40;
            OCR1B = 102;
        }
        else {
            OCR1A = 90;
            OCR1B = 90;
        }
        
        //if(adc3 > 500){
        //    OCR1A = OCR1B = 77;
        //}
        
        /*if(adc3 > 500){
            OCR1A = OCR1B = 255;
        }
        if(adc1 > 500){
            OCR1A = 230;
            OCR1B = 178;
        }
        if(adc5 > 500){
            OCR1A = 178;
            OCR1B = 230;
        }*/
        
    }
}
