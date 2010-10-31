#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

void initADC();   //initializes ADC
void initPWM();   //initializes ADC
uint16_t readADC(uint8_t ch); //reades ADC

void initADC()
{
   ADMUX=(1<<REFS0);// For Aref=AVcc;
   ADCSRA=(1<<ADEN)|(7<<ADPS0);
}

void initPWM()
{
   //set up 2 PWM channels on PB1 and PB2 using Timer1
   DDRB |= _BV(1) |  _BV(2);   //set PB1 and PB2 as outputs
   OCR1A = OCR1B = 0;   //PWM set to zero
   //timer 1 - 8 bit Fast PWM - no pre-scaler - non-inverting
   TCCR1B = (0 << WGM13) | (1<<WGM12) | (0 << CS12) | (0 << CS11) | (1 << CS10);
   TCCR1A = (0 << WGM11) | (1<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
}

uint16_t readADC(uint8_t ch)
{
   //Select ADC Channel ch must be 0-7
   ch=ch&0b00000111;
   ADMUX|=ch;
   
   //Start Single conversion
   ADCSRA|=(1<<ADSC);

   //Wait for conversion to complete
   while(!(ADCSRA & (1<<ADIF)));

   //Clear ADIF by writing one to it
   ADCSRA|=(1<<ADIF);

   return(ADC);
}

int main()
{
   uint16_t adc_value;
   uint8_t t;

   //Enable ADC
   initADC();

   //Enable PWM
   initPWM();
   
   //Blink the two leds on start up
   OCR1A = 255;
   OCR1B = 255;
   _delay_loop_2(0);

   //Infinite loop
   while(1)
   {
      //Read ADC
      adc_value = readADC(0);

      //Convert to degree Centrigrade
      t = adc_value / 2;
	  OCR1A = 5 + ( 10 * (t - 20) );
      OCR1B = 30;
   }
}
