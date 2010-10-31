/***********************************************************************************************/
/* Just a list of the common commands used when messing with the internal eeprom of the atmega */
/*                                                                                             */
/* #include <avr/eeprom.h>                                                                     */
/*                                                                                             */
/* uint8_t eeprom_read_byte (const uint8_t *addr)                                              */
/* void eeprom_write_byte (uint8_t *addr, uint8_t value)                                       */
/* uint16_t eeprom_read_word (const uint16_t *addr)                                            */
/* void eeprom_write_word (uint16_t *addr, uint16_t value)                                     */
/* void eeprom_read_block (void *pointer_ram, const void *pointer_eeprom, size_t n)            */
/* void eeprom_write_block (const void *pointer_ram, void *pointer_eeprom, size_t n)           */
/***********************************************************************************************/

#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/eeprom.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR FOSC/16/BAUD-1

void initusart();   //initializes USART
static int uart_putchar(char c, FILE *stream);
uint8_t uart_getchar();

static FILE mystdout = FDEV_SETUP_STREAM(uart_putchar, NULL, _FDEV_SETUP_WRITE);

uint8_t EEMEM string[10];

void initusart(){
    //1 = output, 0 = input
    DDRD |= 0b00000010;  //(TXD on PD1)
    DDRD &= ~(0b00000001);  //(RXD on PD0)

    //USART Baud rate: 9600
    UBRRH = (8<<MYUBRR);
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

int main(){
    char c;
    int i=0;
    
    initusart();
    printf("EEPROM TEST: Press m for menu.\n");
    while(1){
        c = uart_getchar();
        
        if (c == 'm'){
            printf("Press rn to read a char to position \"n\" of the eeprom.\n");
            printf("Press wn to write a char to position \"n\" of the eeprom.\n");
            printf("The positions of the eeprom are limited from 0 to 9.\n");
        }
        
        if (c == 'r'){
            printf("r");
            i = uart_getchar() - 48;
            printf ("%d : %c\n", i, eeprom_read_byte(&string[i]) );
        }
        
        if (c == 'w'){
            printf("w");
            i = uart_getchar() - 48;
            printf("%d : ", i);
            c = uart_getchar();
            printf("%c\n", c);
            eeprom_write_byte (&string[i], c);
        }
    }
}    
