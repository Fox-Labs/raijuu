#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>
#include <util/twi.h>
#include <inttypes.h>
#include <compat/twi.h>
#include <avr/interrupt.h>

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

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

volatile int time_s, time_m, time_h;

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

void write(uint16_t i, int dado){
    if (dado < 256){
        i2c_start(0xD0);
        i2c_write(i);
        i2c_write(dado);
        i2c_stop();
        _delay_loop_2(0);
    }
}

ISR(USART_RX_vect){
    int a;
    int uni, dez;
    
    a = uart_getchar();
    
    if (a == 't'){
        
        write(7, 0x10);
        
        printf("hora:");
        dez = uart_getchar() - 48;
        printf("%d",dez);
        uni = uart_getchar() - 48;
        printf("%d",uni);
        write(2, ((dez<<4) + uni) );
        printf("\n");
        
        printf("minuto:");
        dez = uart_getchar() - 48;
        printf("%d",dez);
        uni = uart_getchar() - 48;
        printf("%d",uni);
        write(1, ((dez<<4) + uni) );
        printf("\n");
        
        printf("segundo:");
        dez = uart_getchar() - 48;
        printf("%d",dez);
        uni = uart_getchar() - 48;
        printf("%d",uni);
        write(0, ((dez<<4) + uni) );
        printf("\n");
        
        printf("DONE");
    }
}

int main(){
    int a;
    
    init_usart();
    i2c_init();
    
    printf("Serial pronta...\n");

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
    
    sei(); //Enable "ALL" Interrupts
    
    for(;;){
    }
}
