#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>
#include <util/twi.h>
#include <inttypes.h>
#include <compat/twi.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>

#define FOSC 16000000
#define BAUD 9600
#define I2C_CLOCK  100000
#define MYUBRR FOSC/16/BAUD-1

void init_usart();
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
void i2c_init(void);
unsigned char i2c_start(unsigned char address);
void i2c_stop(void);
unsigned char i2c_write( unsigned char data );
unsigned char i2c_readAck(void);
unsigned char i2c_readNak(void);
void init_INT(void);
void init_adc();   //initializes ADC
uint16_t read_adc(uint8_t ch); //reades ADC
int read(uint16_t i);
void write(uint16_t i, int dado);
void salva_dado();

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

volatile int time_s, time_m, time_h;
volatile int flag=0;
volatile uint16_t pos=0;

void init_usart(){
    //1 = output, 0 = input
    DDRD |= 0b00000010; //(TXD on PD1)
    DDRD &= ~(0b00000001); //(RXD on PD0)

    //USART Baud rate: 9600
    UBRR0H = (8<<MYUBRR);
    UBRR0L = MYUBRR;
    UCSR0B = (1<<RXEN0)|(1<<TXEN0)|(1<<RXCIE0); //RX Interrupt Enable
    UCSR0C = (3<<UCSZ00);

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

void i2c_init(void){
    TWSR = 0; //No prescaler
    TWBR = ((FOSC/I2C_CLOCK)-16)/2;
}

unsigned char i2c_start(unsigned char address){
    uint8_t   twst;
    //Send START condition
    TWCR = (1<<TWINT) | (1<<TWSTA) | (1<<TWEN);
    //Wait until transmission completed
    while(!(TWCR & (1<<TWINT)));
    //Check value of TWI Status Register. Mask prescaler bits.
    twst = TW_STATUS & 0xF8;
    if ( (twst != TW_START) && (twst != TW_REP_START)) return 1;
    //Send device address
    TWDR = address;
    TWCR = (1<<TWINT) | (1<<TWEN);
    //Wait until transmission completed and ACK/NACK has been received
    while(!(TWCR & (1<<TWINT)));
    //Check value of TWI Status Register. Mask prescaler bits.
    twst = TW_STATUS & 0xF8;
    if ( (twst != TW_MT_SLA_ACK) && (twst != TW_MR_SLA_ACK) ) return 1;
    return 0;
}

void i2c_stop(void){
    //Send stop condition
    TWCR = (1<<TWINT) | (1<<TWEN) | (1<<TWSTO);
    //Wait until stop condition is executed and bus released
    while(TWCR & (1<<TWSTO));
}

unsigned char i2c_write( unsigned char data ){
    uint8_t   twst;
    //Send data to the previously addressed device
    TWDR = data;
    TWCR = (1<<TWINT) | (1<<TWEN);
    //Wait until transmission completed
    while(!(TWCR & (1<<TWINT)));
    //Check value of TWI Status Register. Mask prescaler bits
    twst = TW_STATUS & 0xF8;
    if( twst != TW_MT_DATA_ACK) return 1;
    return 0;
}

unsigned char i2c_readAck(void){
    TWCR = (1<<TWINT) | (1<<TWEN) | (1<<TWEA);
    while(!(TWCR & (1<<TWINT)));    
    return TWDR;
}

unsigned char i2c_readNak(void){
    TWCR = (1<<TWINT) | (1<<TWEN);
    while(!(TWCR & (1<<TWINT)));
    return TWDR;
}

void init_INT(void){
    EIMSK = (1<<INT0)|(1<<INT1); //INT0 and INT1 Interrupt Request Enable
    EICRA = (1<<ISC01)|(0<<ISC00)|(1<<ISC11)|(0<<ISC10); //Falling Edge of INT0 and INT1
}

void init_adc(){
   ADMUX=(1<<REFS0);// For Aref=AVcc;
   ADCSRA=(1<<ADEN)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);
}

uint16_t read_adc(uint8_t ch){
   ADMUX|=ch;
   
   //Start Single conversion
   ADCSRA|=(1<<ADSC);

   //Wait for conversion to complete
   while(!(ADCSRA & (1<<ADIF)));
       
   //Clear ADIF by writing one to it
   ADCSRA|=(1<<ADIF);
   
   return(ADC);
}

int read(uint16_t i){
    int a=255;
    
    if ( (i < 2048) ){
        i2c_start( ( (i/256)*2 ) + 0xA0 );
        i2c_write(i%256);
        i2c_stop();
        _delay_loop_2(0);
        
        i2c_start( ( (i/256)*2 ) + 0xA1 );
        
        a = i2c_readNak();
        i2c_stop();
        _delay_loop_2(0);
    }
    return a;
}

void write(uint16_t i, int dado){
    if ( (i < 2048) && (dado < 256) ){
        i2c_start( ( (i/256)*2 ) + 0xA0 );
        i2c_write(i%256);
        i2c_write(dado);
        i2c_stop();
        _delay_loop_2(0);
    }
}

void salva_dado(){
    write(pos,read_adc(0));
    pos++;
    write(pos,time_h);
    pos++;
    write(pos,time_m);
    pos++;
}

ISR(INT0_vect){
    
    time_s++;
    
    if(time_s >= 60){
        time_s = 0;
        time_m++;
        if(flag == 1 && ((time_m%2) == 0))
            salva_dado();
    }
    
    if(time_m >= 60){
        time_m = 0;
        time_h++;
    }
    
    if(time_h >= 24){
        time_h = 0;
    }
}

ISR(INT1_vect){
    uint16_t i;
    if( (PIND & 0b00001000) == 0 && flag == 0){
        /*****************/
        /* Apaga memoria */
        /*****************/
        printf("Apagando memoria...");
        for (i = 0; i < 2048; i++){
            write(i, 0);
        }
        printf("OK\n");
        flag=1;
        while( (PIND & 0b00001000) == 0);
    }
}

ISR(USART_RX_vect){
    int a;
    int i;
    
    a = uart_getchar();
    
    if (a == 't'){
        printf("%.2d:%.2d:%.2d\n", time_h, time_m, time_s);
    }

    if (a == 'd'){
        printf("DUMP\n");
        printf("TEMP ; TIME\n");
        
        for (i=0; i<2048; i=i+3){
            printf("%d ; %.2d:%.2d\n", read(i), read(i+1), read(i+2) );
        }
    }
    
    if(a == 'c'){
        printf("%d\n", read_adc(0)/2);
    }
    
}

int main(){
    int a;
    
    init_usart();
    init_adc();
    i2c_init();
    init_INT();
    
    printf("Data Logger v1.0\n");
    
    /***************************************/
    /* Inicio da aquisição de dados do RTC */
    /***************************************/
    i2c_start(0xD0);
    i2c_write(0x00);
    i2c_stop();

    _delay_loop_2(0);
    
    i2c_start(0xD1);
    
    //Second
    a = i2c_readAck();
    time_s = a%16 + 10*(a/16);
    //Minute
    a = i2c_readAck();
    time_m = a%16 + 10*(a/16);
    //Hour
    a = i2c_readNak();
    time_h = a%16 + 10*(a/16);
    
    printf("%.2d:%.2d:%.2d\n", time_h, time_m, time_s);
    
    i2c_stop();
    _delay_loop_2(0);
    /***************************************/
    /*  Fim da aquisição de dados do RTC   */
    /***************************************/
    
    sei(); //Enable "ALL" Interrupts
    
    for(;;){
        sleep_mode();
    }
}
