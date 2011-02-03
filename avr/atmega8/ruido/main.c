#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>
#include <avr/sleep.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR (FOSC/16/BAUD-1)

#define n_pis 3 //numero de vezes que os leds piscam.
#define t_pis 12 //tempo que os leds ficam acessos entre uma piscada e outra.
#define base 100 //Começa no base e vai descendo de 5dB em 5dB. Valor minimo = Base - 35


void initusart();   //initializes USART
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void initadc(); //initializes ADC
uint16_t readadc(uint8_t ch); //reades ADC
void pisca(); //Pisca

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

void initusart(){
    //1 = output, 0 = input
    DDRD |= 0b00000010;  //(TXD on PD1)
    DDRD &= ~(0b00000001);  //(RXD on PD0)

    //USART Baud rate: 9600
    UBRRH = (MYUBRR>>8);
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
    ADMUX=(0<<REFS0)|(0<<REFS1);// For Aref=AVcc;
    ADCSRA=(1<<ADEN)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);
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

void pisca(){
    int i, j;
    
    for(i = 0; i < 2*n_pis; i++){
        for(j = 0; j < t_pis; j++){
            _delay_loop_2(0);
        }
        
        if ( (PORTD & 0b00010000) == 0 ){
            PORTD |= 0b00010000;
        }
        
        else{
            PORTD &= ~(0b00010000);
        }
    }
}

int main(){
    int sig;
    int i;

    //Enable ADC
    initadc();
    //Enable USART
    initusart();
 
    DDRD |= 0b00010000;
    PORTD|= 0b11100000;
 
    printf("Poli Junior\n");
    printf("Sensor De Ruido - v1.0\n");
    
    //printf("barinhas = %d\n", (base - (((PIND & 0b11100000) >> 5 )*5) ) );

    for(;;){
        
        //Matematica ^.^
        sig = readadc(0);
        sig = sig * ( (5 / 10.24 ) / 4.7);
        printf("sig = %d\n",sig);
      
        //Loop de decisão se pisca ou não pisca
        if (sig > (base - (((PIND & 0b11100000) >> 5 )*5) ) ) {
            for(i = 0; i < 25; i++) _delay_loop_2(0);
            

            sig = readadc(0);
            sig = sig * ( (5 / 10.24 ) / 4.7);
            printf("sig = %d\n",sig);
            
            if (sig > (base - (((PIND & 0b11100000) >> 5 )*5) ) ) {
                pisca();
            }
        }
        
	PORTD &= ~(0b00010000);
    
	//for(i = 0; i < 200; i++) _delay_loop_2(0);
	_delay_loop_2(0);
    }
}
