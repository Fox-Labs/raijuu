#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>
#include <math.h>
#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

#define lim 50
#define inc 5
#define per 0.1

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

/* void motor(int a, int b){
    if (a > 0 && b > 0){
        PORTD = 0b10100000;
    }
    if (a < 0 && b > 0){
        PORTD = 0b01100000;
    }
    if (a > 0 && b < 0){
        PORTD = 0b10010000;
    }
    if (a < 0 && b < 0){
        PORTD = 0b01010000;
    }
} */

int main()
{
    int j=0, laps=0;
    
    DDRD |= 0b11110000;
    PORTD = 0b10100000;
    
   /* uint16_t adc1;
    uint16_t adc2;
    uint16_t adc3;
    uint16_t adc4;
    uint16_t adc5;
    /*
    uint16_t adc1_old;
    uint16_t adc2_old;
    uint16_t adc3_old;
    uint16_t adc4_old;
    uint16_t adc5_old;
    */
    uint16_t adc1_new;
    uint16_t adc2_new;
    uint16_t adc3_new;
    uint16_t adc4_new;
    uint16_t adc5_new;
    
    uint16_t adc1_ref = 0;
    uint16_t adc2_ref = 0;
    uint16_t adc3_ref = 0;
    uint16_t adc4_ref = 0;
    uint16_t adc5_ref = 0;
    
    uint16_t adc1_high = 0;
    uint16_t adc2_high = 0;
    uint16_t adc3_high = 0;
    uint16_t adc4_high = 0;
    uint16_t adc5_high = 0;
    
    uint16_t adc1_low = 800;
    uint16_t adc2_low = 800;
    uint16_t adc3_low = 800;
    uint16_t adc4_low = 800;
    uint16_t adc5_low = 800;
    
    uint8_t adc1 = 0;
    uint8_t adc2 = 0;
    uint8_t adc3 = 0;
    uint8_t adc4 = 0;
    uint8_t adc5 = 0;
        
    
    initADC();
    initUSART();
    initPWM();
    
    /* OCR1A = 128; 
            OCR1B = 0;
    
    for (j=0;j<25;j++) 
        {
            for(j=0;j<300;j++) _delay_loop_2(0);
                
            if (readADC(0) > adc1_high)
                adc1_high = readADC(0);
            else
                {
                    if (readADC(0) < adc1_low)
                    adc1_low = readADC(0);
                }            
            if (readADC(1) > adc2_high)
                adc2_high = readADC(1);
            else
                {
                    if (readADC(1) < adc2_low)
                    adc2_low = readADC(1);
                }            
            
            if (readADC(2) > adc3_high)
                adc3_high = readADC(2);
            else
                {
                    if (readADC(2) < adc3_low)
                    adc3_low = readADC(2);
                }            
            
            if (readADC(3) > adc4_high)
                adc4_high = readADC(3);
            
            else
                {
                    if (readADC(3) < adc4_low)
                    adc4_low = readADC(3);
                }            
            
            if (readADC(4) > adc5_high)
                adc5_high = readADC(4);
            else
                {
                    if (readADC(4) < adc5_low)
                    adc5_low = readADC(4);
                }            
        }    
        
    adc1_ref = (adc1_high + adc1_low)/2;
    adc2_ref = (adc2_high + adc2_low)/2;
    adc3_ref = (adc3_high + adc3_low)/2;
    adc4_ref = (adc4_high + adc4_low)/2;
    adc5_ref = (adc5_high + adc5_low)/2;        
   
    OCR1A = OCR1B = 0;        
   
    for(j=0;j<0100;j++) _delay_loop_2(0); */
    
    OCR1A = OCR1B = 120;
    
     /*_delay_loop_2(100);
    OCR1A = OCR1B = 50;*/
    for(;;)
    {   
        // _delay_loop_2(100);
        adc1_new = readADC(0);
        adc2_new = readADC(1);
        adc3_new = readADC(2);
        adc4_new = readADC(3);
        adc5_new = readADC(4);
        
        if (adc1_new < 600)
            adc1 = 0;
        else
            adc1 = 1;
        
        if (adc2_new < 600)
            adc2 = 0;
        else
            adc2 = 1;
        
        if (adc3_new < 600)
            adc3 = 0;
        else
            adc3 = 1;
        
        if (adc4_new < 600)
            adc4 = 0;
        else
            adc4 = 1;
        
        if (adc5_new < 600)
            adc5 = 0;
        else
            adc5 = 1;
        
        if ((adc1 = 0) && (adc2 = 0 ) && (adc3 = 1) && (adc4 = 0) && (adc5 = 0)) {
            OCR1A =  120;
            OCR1B = 120;
        }
            
        if ((adc1 = 0) && (adc2 = 1) && (adc3 = 1) && (adc4 = 1) && (adc5 = 0)) {
            OCR1B = 120;
            OCR1A = 120;
        }
        
        if ((adc1 = 1) && (adc2 = 1) && (adc3 = 1) && (adc4 = 1) && (adc5 = 1)) {
            OCR1B = 120;
            OCR1A = 120;
        }
            
        if ((adc1 = 0) && (adc2 = 0) && (adc3 = 0) && (adc4 = 0) && (adc5 = 1)) {
            OCR1A = 100;
            OCR1B = 0;
        }
        
        if ((adc1 = 0) && (adc2 = 0) && (adc3 = 0) && (adc4 = 1) && (adc5 = 1)) {
            OCR1A = 100;
            OCR1B = 0;
        }
            
        if ((adc1 = 0) && (adc2 = 0) && (adc3 = 1) && (adc4 = 1) && (adc5 = 1))  {
            OCR1A = 100;
            OCR1B = 0;
        }
        
        if ((adc1 = 0) && (adc2 = 0) && (adc3 = 0) && (adc4 = 1) && (adc5 = 0))  {
            OCR1A = 100;
            OCR1B = 0;
        }
        
        if ((adc1 = 0) && (adc2 = 0) &&  (adc3 = 1) && (adc4 = 1) && (adc5 = 0))  {
            OCR1A = 100;
            OCR1B = 0;
        }
        
        if ((adc1 = 0) && (adc2 = 1) &&  (adc3 = 1) && (adc4 = 0) && (adc5 = 0))  {
            OCR1A = 0;
            OCR1B = 100;
        }
        
        if ((adc1 = 0) && (adc2 = 1) &&  (adc3 = 0) && (adc4 = 1) && (adc5 = 0))  {
            OCR1A = 0;
            OCR1B = 100;
        }
        
        if ((adc1 = 1) && (adc2 = 0) &&  (adc3 = 0) && (adc4 = 1) && (adc5 = 0))  {
            OCR1A = 0;
            OCR1B = 200;
        }
        
        if ((adc1 = 1) && (adc2 = 1) &&  (adc3 = 0) && (adc4 = 1) && (adc5 = 0)) {
            OCR1A = 0;
            OCR1B = 200;
        }
        
        if ((adc1 = 1) && (adc2 = 1) &&  (adc3 = 1) && (adc4 = 1) && (adc5 = 0))  {
            OCR1A = 0;
            OCR1B = 200;
        }
        
            
        printf("V1:%4d V2:%4d V3:%4d V4:%4d V5:%4d\n", adc1_new, adc2_new, adc3_new, adc4_new, adc5_new);
        
        /*  
        adc1 = adc1_new - adc1_old;
        adc2 = adc2_new - adc2_old;
        adc3 = adc3_new - adc3_old;
        adc4 = adc4_new - adc4_old;
        adc5 = adc5_new - adc5_old;
        
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
        
        /*
        if (abs(adc3) = lim && abs(adc1) < lim && abs(adc5) < lim && abs(adc2) < lim && abs(adc4) < lim)
            { 
                OCR1A = OCR1A;
                OCR1B = OCR1B;
            }
        

        else 
        {
            if (adc2 > lim)
                {
                    if (abs(adc1) < lim)
                        {
                            if (OCR1B + per*OCR1B >= '128')
                                OCR1B = 128;
                            if (OCR1A - per*OCR1A <= '0')
                                OCR1A = 0;
                            else 
                                {
                                    OCR1A = OCR1A - per*OCR1A ;
                                    OCR1B = OCR1B + per*OCR1B ;
                                }                        
                        }
                    else 
                        {
                            if (OCR1B + 2*per*OCR1B >= '128')
                                OCR1B = 128;
                            if (OCR1A - 2*per*OCR1A <= '0')
                                OCR1A = 0;
                            else 
                                { 
                                    OCR1A = OCR1A - 2*per*OCR1A ;
                                    OCR1B = OCR1B + 2*per*OCR1B ;
                                }                        
                        }
                }
            if (adc2 <= lim )
                {   
                    if (abs(adc5) < lim)
                        {
                            if (OCR1A + per*OCR1A >= '128')
                                OCR1A = 128;
                            if (OCR1B - per*OCR1B <= '0')
                                OCR1B = 0;
                            else 
                                { 
                                    OCR1A = OCR1A + per*OCR1A ;
                                    OCR1B = OCR1B - per*OCR1B ;
                                }
                        }
                    else 
                        {
                            if (OCR1A + 2*per*OCR1A >= '128')
                                OCR1A = 128;
                            if (OCR1B - 2*per*OCR1B <= '0')
                                OCR1B = 0;
                            else 
                                {
                                    OCR1A = OCR1A + 2*per*OCR1A ;
                                    OCR1B = OCR1B - 2*per*OCR1B ;
                                }
                        }
                } 
        }    
        /*    
        else 
        {
            if (adc2 > lim)
                {
                    if (abs(adc1) < lim)
                        {
                            if (OCR1B + inc >= '128')
                                OCR1B = 128;
                            if (OCR1A - inc <= '0')
                                OCR1A = 0;
                            else 
                                {
                                    OCR1A = OCR1A - inc ;
                                    OCR1B = OCR1B + inc ;
                                }                        
                        }
                    else 
                        {
                            if (OCR1B + 2*inc >= '128')
                                OCR1B = 128;
                            if (OCR1A - 2*inc <= '0')
                                OCR1A = 0;
                            else 
                                { 
                                    OCR1A = OCR1A - 2*inc ;
                                    OCR1B = OCR1B + 2*inc ;
                                }                        
                        }
                }
            if (adc4 > lim )
                {   
                    if (abs(adc5) < lim)
                        {
                            if (OCR1A + inc >= '128')
                                OCR1A = 128;
                            if (OCR1B - inc <= '0')
                                OCR1B = 0;
                            else 
                                { 
                                    OCR1A = OCR1A + inc ;
                                    OCR1B = OCR1B - inc ;
                                }
                        }
                    else 
                        {
                            if (OCR1A + 2*inc >= '128')
                                OCR1A = 128;
                            if (OCR1B - 2*inc <= '0')
                                OCR1B = 0;
                            else 
                                {
                                    OCR1A = OCR1A + 2*inc ;
                                    OCR1B = OCR1B - 2*inc ;
                                }
                        }
                } 
        }        
        */    
        /*
        adc1_old = adc1_new;
        adc2_old = adc2_new;
        adc3_old = adc3_new;
        adc4_old = adc4_new;
        adc5_old = adc5_new;
        
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
