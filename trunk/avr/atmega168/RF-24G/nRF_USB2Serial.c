#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>

#define FOSC 16000000
#define BAUD 9600
#define MYUBRR (FOSC/16/BAUD-1)

#define RED OCR2A
#define BLUE OCR1A
#define GREEN OCR1B


//Define functions
//======================
void ioinit(void);
uint8_t uart_getchar(void);
void put_char(char byte);

void delay_ms(uint16_t x); //General purpose delay
void delay_us(uint8_t x);

void initPWM(void);

#include <nRF2401A_lib.c>

//======================



ISR (SIG_USART_RECV)//USART Receive Interrupt
{
	cli();//Disable Interrupts
	
	rf_tx_array[1] = rf_tx_array[2] = UDR0;
	
	config_tx_nRF2401A();
	tx_data_nRF2401A();
	config_rx_nRF2401A();
	
	sei();//Enable Interrupts
	
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
		if (_01A_PORT_PIN & (1<<_01A_DR))
		{
			rx_data_nRF2401A();
			
			if (rf_rx_array[0] == 59 && rf_rx_array[1] == rf_rx_array[2] && rf_rx_array[3] == 42)
			{
				put_char(rf_rx_array[1]);
			}
		}
		
		if(rf_rx_array[1] >= 48 && rf_rx_array[1] <= 55){
			if(rf_rx_array[1] == 48) {//0
				RED = 0;
				GREEN = 0;
				BLUE = 0;
			}
			if(rf_rx_array[1] == 49) {//1
				RED = 255;
				GREEN = 0;
				BLUE = 0;
			}
			if(rf_rx_array[1] == 50) {//2
				RED = 0;
				GREEN = 255;
				BLUE = 0;
			}
			if(rf_rx_array[1] == 51) {//3
				RED = 0;
				GREEN = 0;
				BLUE = 255;
			}
			if(rf_rx_array[1] == 52) {//4
				RED = 255;
				GREEN = 255;
				BLUE = 0;
			}
			if(rf_rx_array[1] == 53) {//5
				RED = 255;
				GREEN = 0;
				BLUE = 255;
			}
			if(rf_rx_array[1] == 54) {//6
				RED = 0;
				GREEN = 255;
				BLUE = 255;
			}
			if(rf_rx_array[1] == 55) {//7
				RED = 255;
				GREEN = 255;
				BLUE = 255;
			}
			
		}
		
		
	}
}

void initPWM(){
   //set up 3 PWM channels on PB1, PB2 and PB3
   DDRB |= 0b00001110 ;   //set PB1, PB2 and PB3 as outputs
   BLUE = GREEN = RED = 0;   //PWMs set to zero
   //timer 1 - 8 bit Fast PWM - no pre-scaler - non-inverting
   //timer 2 - 8 bit Fast PWM - no pre-scaler - non-inverting
   TCCR1B = (0 << WGM13) | (1<<WGM12) | (0 << CS12) | (0 << CS11) | (1 << CS10);
   TCCR1A = (0 << WGM11) | (1<<WGM10) | (1 << COM1A1) | (0 << COM1A0) | (1 << COM1B1) | (0 << COM1B0);
   TCCR2A = (1 << WGM21) | (1<<WGM20) | (1 << COM2A1) | (0 << COM2A0);
   TCCR2B = (0 << CS22) | (0 << CS21) | (1 << CS20);
}

void ioinit(void)
{
	
	//1 = output, 0 = input
	DDRD |= 0b00000010;  //(TXD on PD1)
	DDRD &= ~(0b00000001);  //(RXD on PD0)
	
	//1 = output, 0 = input
	DDRD = 0b01010100;

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
	/* Wait for empty transmit buffer */
	while ( !( UCSR0A & (1<<UDRE0)) );
	/* Put data into buffer, sends the data */
	UDR0 = byte;
}


