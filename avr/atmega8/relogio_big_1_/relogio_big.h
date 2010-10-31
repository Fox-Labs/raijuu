//***********************************************************************
// Diretrizes de pré-compilação para módulo relogio_big
// Desenvolvido por Márcio José Soares - 06/08/2007
//***********************************************************************

//***********************************************************************
// Definições utilizadas nos arquivos de inclusão
//***********************************************************************
#define __AVR_ATmega8__
#define F_CPU 1000000UL		//1 MHz

//***********************************************************************
// Arquivos incluidos no módulo
//***********************************************************************
#include </usr/avr/include/stdio.h>
//#include </usr/avr/include/stlib.h>
#include </usr/avr/include/avr/io.h>
#include </usr/avr/include/avr/pgmspace.h>
#include </usr/avr/include/avr/interrupt.h>
#include </usr/avr/include/util/delay.h>

//***********************************************************************
// Tipos definidos pelo usuário
//***********************************************************************
typedef unsigned char  uint8;
typedef unsigned short uint16;
typedef unsigned long  uint32;

typedef unsigned char  byte;			//define char byte
typedef const unsigned char const_byte;		//define char constante

//***********************************************************************
// Definições do usuário utilizadas no módulo
//***********************************************************************
#define TRUE 1
#define FALSE 0

//***********************************************************************
//* Ligação entre as portas do AVR e os LEDs e Buzzer
//***********************************************************************
#define portLEDBuz	PORTC		//porta onde os LEDs e Buzzer
										//foram ligados

//***********************************************************************
//* Pinos de controle do AVR para os LEDs e Buzzer
//***********************************************************************
#define pLEDs		0x10		//0b00010000
#define pBUZ		0x08		//0b00001000

//***********************************************************************
//* Ligação entre as portas do AVR e o 74LS595 (Display Big)
//***********************************************************************
#define port595		PORTB		//porta onde está o controle do 595
#define porttrans   	PORTD		//porta para transferência dos 74595

//***********************************************************************
//* Pinos de controle do AVR para o 74LS595 (Disp Big)
//***********************************************************************
#define pdado		0x01		//0b00000001 - dados
#define pclock		0x02		//0b00000010 - clock
#define ptrans1	0x10		//0b00010000 - transferência disp 1
#define ptrans2	0x20		//0b00100000 - transferência disp 2
#define ptrans3	0x40		//0b01000000 - transferência disp 3
#define ptrans4	0x80		//0b10000000 - transferência disp 4
#define phab		0x04		//0b00000100 - habilitação dos displays

//***********************************************************************
//* Ligações entre as portas do AVR e o DS1302
//***********************************************************************
#define poutRTC	PORTC
#define psetRTC	DDRC
#define pinRTC		PINC

//***********************************************************************
//* Pinos de controle do AVR para o DS1302 (RTC)
//***********************************************************************
#define RTCio		0x00
#define RTCclk		0x01
#define RTCrst		0x02

//***********************************************************************
// Pinos de controle do AVR para o DS1620 (Temperatura)
//***********************************************************************
#define poutTEMP	PORTC
#define psetTEMP	DDRC
#define pinTEMP	PINC

#define TEMPio   	0x00
#define TEMPclk  	0x01
#define TEMPrst  	0x05 

//***********************************************************************
//* Macros para uso com os pinos de controle dos botões de ajuste
//***********************************************************************
#define all_press		(!(PINB & 0x10) && !(PINB & 0x08) && !(PINB & 0x20))
#define hora_press 	(!(PINB & 0x10) && !(PINB & 0x08))
#define min_press		(!(PINB & 0x10) && !(PINB & 0x20))

//***********************************************************************
//* Macros para uso com os pinos de controle dos LEDs e Buzzer
//***********************************************************************
#define leds_on		portLEDBuz |= pLEDs	//liga leds
#define leds_off		portLEDBuz &= ~pLEDs	//desliga leds
#define buzz_on		portLEDBuz |= pBUZ	//liga buzzer
#define buzz_off		portLEDBuz &= ~pBUZ	//desliga buzzer

//***********************************************************************
// Variáveis globais do módulo
//***********************************************************************
 
//variável para uso na comtagem do tempo
struct relogio{ 							//estrutura para guardar o tempo contado
	byte seg;								//guarda segundos passados
	byte min;								//guarda minutos passados
	byte hr;									//guarda horas passadas
}tempo;

byte conta;									//variável para contar o número de interrupções em um segundo
byte time_5s;								//variável para atualizar o display
byte time_temp;							//descide o que mostrar - hora ou temp
byte atualiza_RTC;						//variável para informar que deve atualizar o RTC
byte toca_buzz;							//variável para tocar o buzzer
byte disp[4];								//variáveis para guardar dados para os displays

uint16 temp_ds1620;						//variável global para uso nas conversões DS1620
byte conf1;									//sempre 1 quando DS1620 já configurado
byte sinal; 								//contem o sinal do valor convertido no DS1620
