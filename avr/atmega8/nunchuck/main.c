#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>
#include <util/twi.h>
#include <inttypes.h>
#include <compat/twi.h>

#define FOSC 16000000
#define BAUD 9600
#define I2C_CLOCK  100000
#define MYUBRR FOSC/16/BAUD-1

void i2c_init(void);
unsigned char i2c_start(unsigned char address);
void i2c_stop(void);
unsigned char i2c_write( unsigned char data );
unsigned char i2c_readAck(void);
unsigned char i2c_readNak(void);

void initUSART();   //initializes USART
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();
static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

void i2c_init(void)
{
    TWSR = 0;                         /* no prescaler */
    TWBR = ((FOSC/I2C_CLOCK)-16)/2;  /* must be > 10 for stable operation */ /*72*/
}

unsigned char i2c_start(unsigned char address)
{
    uint8_t   twst;
    // send START condition
    TWCR = (1<<TWINT) | (1<<TWSTA) | (1<<TWEN);
    // wait until transmission completed
    while(!(TWCR & (1<<TWINT)));
    // check value of TWI Status Register. Mask prescaler bits.
    twst = TW_STATUS & 0xF8;
    if ( (twst != TW_START) && (twst != TW_REP_START)) return 1;
    // send device address
    TWDR = address;
    TWCR = (1<<TWINT) | (1<<TWEN);
    // wail until transmission completed and ACK/NACK has been received
    while(!(TWCR & (1<<TWINT)));
    // check value of TWI Status Register. Mask prescaler bits.
    twst = TW_STATUS & 0xF8;
    if ( (twst != TW_MT_SLA_ACK) && (twst != TW_MR_SLA_ACK) ) return 1;
    return 0;
}

void i2c_stop(void)
{
    /* send stop condition */
    TWCR = (1<<TWINT) | (1<<TWEN) | (1<<TWSTO);
    // wait until stop condition is executed and bus released
    while(TWCR & (1<<TWSTO));
}

unsigned char i2c_write( unsigned char data )
{
    uint8_t   twst;
    // send data to the previously addressed device
    TWDR = data;
    TWCR = (1<<TWINT) | (1<<TWEN);
    // wait until transmission completed
    while(!(TWCR & (1<<TWINT)));
    // check value of TWI Status Register. Mask prescaler bits
    twst = TW_STATUS & 0xF8;
    if( twst != TW_MT_DATA_ACK) return 1;
    return 0;
}

unsigned char i2c_readAck(void)
{
    TWCR = (1<<TWINT) | (1<<TWEN) | (1<<TWEA);
    while(!(TWCR & (1<<TWINT)));    
    return TWDR;
}

unsigned char i2c_readNak(void)
{
    TWCR = (1<<TWINT) | (1<<TWEN);
    while(!(TWCR & (1<<TWINT)));
    return TWDR;
}

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


int main()
{
    int button;
    //Enable USART
    initUSART();
    //Enable I2C
    i2c_init();
    
    printf("Serial pronta...\n");
    
    i2c_start(0xA4);
    i2c_write(0xF0);
    i2c_write(0x55);
    i2c_stop();
    
    _delay_loop_2(0);
    
    i2c_start(0xA4);
    i2c_write(0xFB);
    i2c_write(0x00);
    i2c_stop();
    
    printf("Inicializacao pronta...\n");
    
    for(;;)
    {
        if ( uart_getchar() == 'n' || 'N')
        {
            i2c_start(0xA4);
            i2c_write(0x00);
            i2c_stop();
            
            _delay_loop_2(0);
            
            i2c_start(0xA5);
            printf("%.3d\n", i2c_readAck() );
            printf("%.3d\n", i2c_readAck() );
            printf("%.3d\n", i2c_readAck() );
            printf("%.3d\n", i2c_readAck() );
            printf("%.3d\n", i2c_readAck() );
            button = i2c_readNak();
            printf ("%d\n", button%2);
            button = button/2;
            printf ("%d\n", button%2);
            
            i2c_stop(); 
        }            
    }
}
