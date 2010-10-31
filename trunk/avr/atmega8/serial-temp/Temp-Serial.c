#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1


void initUSART();   //initializes USART
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void initADC();   //initializes ADC
uint16_t readADC(uint8_t ch); //reades ADC

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

void initUSART()
{
   //1 = output, 0 = input
   DDRD |= 0b00000010;  //PORTD (X on PD1)
   DDRD &= ~(0b00000001);  //PORTD (X on PD0)

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

void InitADC()
{
   ADMUX=(1<<REFS0);// For Aref=AVcc;
   ADCSRA=(1<<ADEN)|(7<<ADPS0);
}

uint16_t ReadADC(uint8_t ch)
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
   InitADC();
   //Enable USART
   InitUSART();

   //Infinite loop
   while(1)
   {

      if ( uart_getchar() == 't')
      {
         //Read ADC
         adc_value = ReadADC(0);

         //Convert to degree Centrigrade
         t = adc_value / 2;

         //Print to display
         printf("T: room temperature is %d C\n", t);	
      }
   }
}
