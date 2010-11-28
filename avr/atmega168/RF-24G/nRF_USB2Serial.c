//Bibliotecas
//======================
#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>

#include <nRF2401A_lib.c>

//======================

//Defines
//======================
#define FOSC 16000000
#define BAUD 9600
#define MYUBRR (FOSC/16/BAUD-1)

#define RED OCR2A
#define BLUE OCR1A
#define GREEN OCR1B

//======================

//Variaveis Globais
//======================
volatile char buff[4];

//======================

//Funcoes
//======================
void ioinit(void);
uint8_t uart_getchar(void);
void put_char(char byte);
void initPWM(void);
uint8_t hex_to_dec(char hex);

//======================




ISR (SIG_USART_RECV)//USART
{
	cli();//Desabilita Interrupcoes
	
	rf_tx_array[1] = rf_tx_array[2] = UDR0;
	
	config_tx_nRF2401A();
	tx_data_nRF2401A();
	config_rx_nRF2401A();
    
    put_char(rf_tx_array[1]);

	sei();//Habilita Interrupcoes
	
}

int main(void)
{
	int x=0;
	
	ioinit();
	initPWM();
	
	RED = GREEN = BLUE = 0;

	for (x = 0; x < 4; x++)
	{
		rf_rx_array[x] = 0;
	}
	
	rf_tx_array[0] = 59; // ;
	rf_tx_array[3] = 42; // *
	
	config_rx_nRF2401A();
	
	sei();
	
	for(;;)
	{	
		if (_01A_PORT_PIN & (1<<_01A_DR)) //Recebeu algumna coisa
		{
			rx_data_nRF2401A();
			
			if (rf_rx_array[0] == 59 && rf_rx_array[1] == rf_rx_array[2] && rf_rx_array[3] == 42) //Msg Valida
			{
                //Joga dado no buff FIFO
				for(x = 0; x < 3; x++){
                    buff[x] = buff[x+1];
                }
                buff[x] = rf_rx_array[1];
                printf("%c",buff[x]);
                
                //Se string no buff bate com o esperado, muda valor do PWM do led especificado
                if ( (buff[0] == 'R' || buff[0] == 'r') && buff[3] == ';'){
                    RED = hex_to_dec(buff[1])*16 + hex_to_dec(buff[2]);
                }
                if ( (buff[0] == 'G' || buff[0] == 'g') && buff[3] == ';'){
                    GREEN = hex_to_dec(buff[1])*16 + hex_to_dec(buff[2]);
                }
                if ( (buff[0] == 'B' || buff[0] == 'b') && buff[3] == ';'){
                    BLUE = hex_to_dec(buff[1])*16 + hex_to_dec(buff[2]);
                }
                
			}
		}
	}
}

void initPWM(){
   //3 Canais PWM em PB1, PB2 and PB3
   DDRB |= 0b00001110 ;   //PB1, PB2 e PB3 sao saidas
   BLUE = GREEN = RED = 0;   //PWMs comecam em zero
   //timer 1 - 8 bit Fast PWM - no pre-scaler - non-inverting
   //timer 2 - 8 bit Fast PWM - no pre-scaler - non-inverting
   TCCR1B = (0 << WGM13) | (1<<WGM12) | (0 << CS12) | (0 << CS11) | (1 << CS10);
   TCCR1A = (0 << WGM11) | (1<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
   TCCR2A = (1 << WGM21) | (1<<WGM20) | (1 << COM2A1) | (0 << COM2A0);
   TCCR2B = (0 << CS22) | (0 << CS21) | (1 << CS20);
}

void ioinit(void)
{
	//1 = saida, 0 = entrada
	//DDRD |= 0b00000010;  //(TXD on PD1)
	//DDRD &= ~(0b00000001);  //(RXD on PD0)
	
	//1 = saida, 0 = entrada
	DDRD = 0b01010110;
	
	//PORTC; 1 = habilita resistor pullup
	PORTC = 0b00000001;
	DDRC = 0b00000000;

	//USART Baud rate: 9600
	UBRR0H = (MYUBRR>>8);
	UBRR0L = MYUBRR;
	UCSR0B = (1<<RXEN0)|(1<<TXEN0)|(1<<RXCIE0);
	UCSR0C = (1<<USBS0)|(3<<UCSZ00);
}


uint8_t uart_getchar(void)
{
    while( !(UCSR0A & (1<<RXC0)) );
    return(UDR0);
}

void put_char(char byte)
{
	while ( !( UCSR0A & (1<<UDRE0)) );
	UDR0 = byte;
}

uint8_t hex_to_dec(char hex)
{
   if (hex > 47 && hex <58) return (hex - 48);
   if (hex > 64 && hex <71) return (hex - 55);
   if (hex > 96 && hex <103) return (hex - 87);
   
   return 0;
}

