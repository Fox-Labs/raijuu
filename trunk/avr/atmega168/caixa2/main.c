#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>
#include <avr/sleep.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

#define SERVO_MIN 1000
#define SERVO_MAX 1900

void initusart();   //initializes USART
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void initpwm();   //initializes PWM
void initadc(uint8_t ch); //initializes ADC
uint16_t readadc(uint8_t ch); //reades ADC
void initINT0(void);
void inittimer(void);
//void insere(char c);

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

volatile char buff[4];

void initusart(){
    //1 = output, 0 = input
    DDRD |= 0b00000010;  //(TXD on PD1)
    DDRD &= ~(0b00000001);  //(RXD on PD0)

    //USART Baud rate: 9600
    UBRR0H = (8<<MYUBRR);
    UBRR0L = MYUBRR;
    UCSR0B = (1<<RXEN0)|(1<<TXEN0)|(1<<RXCIE0);
    UCSR0C = (1<<USBS0)|(3<<UCSZ00);

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

void initadc(uint8_t ch){
   //ADMUX=(1<<REFS0);// For Aref=AVcc;
   ADCSRA=(1<<ADEN)|(1 << ADATE)|(1<<ADSC)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);// Enable ADC interrupt and Free-Running Mode
   ADMUX|=ch;
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
    DDRB |= 0b00000110;   //set PB1, PB2
    //timer 1 - 16 bit Phase+Frequency correct - pre-scaler of 8- non-inverting
    TCCR1B = (1 << WGM13) | (0<<WGM12) | (0 << CS12) | (1 << CS11) | (0 << CS10);
    TCCR1A = (1 << WGM11) | (0<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
    ICR1 = 20000;
    //PB1 PWM sets to 1ms
    OCR1A = SERVO_MIN;    
}

void inittimer(){
    //timer 2
    TCCR2A = (0 << WGM21) | (0 << WGM20) | (0 << COM2A1) | (0 << COM2A0);
    TCCR2B = (0 << WGM22) | (1 << CS22) | (1 << CS21) | (1 << CS20);
    //TIMSK2 = (1 << TOIE2);
}

void initINT0(){
    EIMSK = (1<<INT0); //INT0 Interrupt Request Enable
    EICRA = (1<<ISC01)|(0<<ISC00); //Falling Edge of INT0
}

ISR(INT0_vect){
    //_delay_loop_2(0);
    if ((PIND & 0b00000100) == 0b00000100) printf("#L\n");
    _delay_loop_2(0);
    while ((PIND & 0b00000100) == 0b00000100);
    printf("#D\n");
}

ISR(ADC_vect){
    printf("#P%.4d\n",ADC);
}

ISR(TIMER2_OVF_vect){
    printf("#P%.4d\n",readadc(0) );
}

ISR(USART_RX_vect){
    int i;
    
    for(i = 0; i < 3; i++){
        buff[i] = buff[i+1];
    }
    buff[3] = uart_getchar();
    printf("%c",buff[3]);

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

    if (buff[3] == '?') printf("help\n");//Texto com os comandos aqui
    
    if (buff[1] == '#' && buff[2] == 'S' && buff[3] == '1'){
        printf("\n");
        PORTC |= 0b00000010;
    }
    if (buff[1] == '#' && buff[2] == 'S' && buff[3] == '0'){
        printf("\n");
        PORTC &= ~(0b00000010);
    }
    
    if (buff[1] == '#' && buff[2] == 'X' && buff[3] == '1'){
        printf("\n");
        PORTD |=  0b00100000;
    }
    if (buff[1] == '#' && buff[2] == 'X' && buff[3] == '0'){
        printf("\n");
        PORTD &=  ~(0b00100000);
    }
    if (buff[1] == '#' && buff[2] == 'Y' && buff[3] == '1'){
        printf("\n");
        PORTD |=  0b01000000;
    }
    if (buff[1] == '#' && buff[2] == 'Y' && buff[3] == '0'){
        printf("\n");
        PORTD &=  ~(0b01000000);
    }
    if (buff[1] == '#' && buff[2] == 'Z' && buff[3] == '1'){
        printf("\n");
        PORTD |=  0b10000000;
    }
    if (buff[1] == '#' && buff[2] == 'Z' && buff[3] == '0'){
        printf("\n");
        PORTD &=  ~(0b10000000);
    }
    
    if (buff[1] == '#' && buff[2] == 'P' && buff[3] == '1'){
        printf("\n");
        TIMSK2 |= (1 << TOIE2);
        //ADCSRA |= (1<<ADIE);
    }
    if (buff[1] == '#' && buff[2] == 'P' && buff[3] == '0'){
        printf("\n");
        TIMSK2 &= ~(1 << TOIE2);
        //ADCSRA &= ~(1<<ADIE);
    }

    if (buff[2] == '#' && buff[3] == 'A'){
        printf("\n");
        OCR1A = SERVO_MAX;
        for(i=0;i<50;i++) _delay_loop_2(0);
        OCR1A = SERVO_MIN;
    }
}

/*void insere(char c){
    int i;
    for(i = 0; i < 3; i++){
        buff[i] = buff[i+1];
    }
    buff[3] = c;
    printf("%c",c);
    
    //for(i = 0; i < 4; i++){
    //    printf("%c",buff[i]);
    //}
    //printf("\n");
}*/

int main(){
    
    //PC0 to PC7 as outputs
    DDRC|=0b11111110; 
    DDRD|=0b11111000;
    DDRB|=0b11111111;
    
    //Enable USART
    initusart();
    //Enable PWM
    initpwm();
    //Enable ADC
    initadc(0);
    //Enable INT0
    initINT0();
    //Enable Timer
    inittimer();
    
    printf("Poli Junior\n");
    printf("Caixa de Treinamento - v1.0\n");
    
    //Enable all interupts
    sei();
    
    //Infinite loop
    for(;;){
        sleep_mode();
    }
}
