//***********************************************************************
// RELOGIO BIG usando AVR ATMEGA8 e Display Big (ET-111) - versão 2.0
// Desenvolvido por Márcio José Soares - 06/08/2007
//
// V1.0 - Conta tempo e mostra no display (relógio com hora e minutos)
// V1.5 - Guarda tempo em RTC para evitar ter que reajustar
// V2.0 - Mostra tempo e temperatura local (DS1620)
//
// Microcontrolador: ATMEGA8
// Clock: 1 MHz (interno)
// Compilador: avr-gcc (GCC) 4.1.0 - Linux / Win Avr - Windows
//
// Última alteração: 19/09/2007
//
//***********************************************************************

//***********************************************************************
// Outros arquivos incluidos no módulo
//***********************************************************************
#include "relogio_big.h"		//configurações gerais
#include "display_big.c"		//módulo de controle do display BIG
#include "ds1302.c"				//módulo de controle para o RTC DS1302
#include "ds1620.c"				//módulo de controle para o DS1620 (temp)

//***********************************************************************
// Funções do módulo
//***********************************************************************

//***********************************************************************
// Função atualiza_disp() - atualiza display
//
// Entradas - tipo (0-hora, 1-temp)
// Saídas   - nenhuma
//***********************************************************************
void atualiza_disp(byte tipo){

	byte aux, aux1, i;						//variáveis auxiliares

	if(tipo){
		get_temp_ds1620();
		if (temp_ds1620 > 9){
			aux  = temp_ds1620 / 10;				//pega dezena
			aux1 = temp_ds1620 % 10;				//pega unidade
		}
		else{
			aux  = 0;									//não há dezena
			aux1 = temp_ds1620;						//apenas unidade
		}

		disp[0] = aux;								//insere valor nas variáveis
		disp[1] = aux1;
		disp[2] = 0x0B;							//disp3 com simbolo para Grau
		disp[3] = 0x0C;							//disp4 com a letra C

	}
	else{
		if (tempo.hr > 9){
			aux  = tempo.hr / 10;				//pega dezena
			aux1 = tempo.hr % 10;				//pega unidade
		}
		else{
			aux  = 0;								//não há dezena
			aux1 = tempo.hr;						//apenas unidade
		}

		disp[0] = aux;								//insere valor nas variáveis
		disp[1] = aux1;

		if (tempo.min > 9){
			aux  = tempo.min / 10;				//pega dezena
			aux1 = tempo.min % 10;				//pega unidade
		}
		else{
			aux  = 0;								//não há dezena
			aux1 = tempo.min;						//apenas unidade
		}

		disp[2] = aux;								//insere valor nas variáveis
		disp[3] = aux1;
	}

	for (i=0; i<4; i++)							//envia dados para display
		escreve_dado(i, disp[i]);
}

//***********************************************************************
// Interrupção Externa INT0
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
ISR(SIG_INTERRUPT0){

	conta++;                      	//incrementa contagem (interrupções)

   if (conta == 60){             	//igual a 60 interrupções?
      conta=0;                   	//zera
		tempo.seg++;						//incrementa segundos
		time_5s++;							//incrementa contador para cinco segundos

		if (tempo.seg > 59){				//60 segundos?
			tempo.seg=0;					//zera segundos
			tempo.min++;					//incrementa minutos
			atualiza_RTC = 1;				//atualiza RTC a cada minuto

			if (tempo.min > 59){			//60 minutos?
				tempo.min=0;				//zera minutos
				tempo.hr++;					//incrementa hora
				toca_buzz = 1;				//beep a cada hora
	
				if (tempo.hr > 23){		//24 horas?
					tempo.hr=0;
					tempo.min=0;
					tempo.seg=0;
				}
			}
		}
	}
}

//***********************************************************************
// Função para inicializar as variáveis globais
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
void init_vars(void){

	byte i;

	tempo.seg=0;					//zera variáveis do relógio
	tempo.min=0;
	tempo.hr=0;
	conta=0;
	atualiza_RTC=0;
	toca_buzz=0;
	for (i=0;i<4;i++)
		disp[i]=0;					//zera variáveis do display
}

//***********************************************************************
// Função para inicializar a interrupção externa INT0
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
void init_INT0(void){

	MCUCR = 0x02;					//borda de descida gera a int no pino INT0
	GICR  = 0x40;					//habilita a int através do pino INT0
}

//***********************************************************************
// Função para inicializar microcontrolador
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
void init_AVR(void){

	PORTB = 0x38;		 			// pull-up em PB5, PB4 e PB3
	DDRB  = 0xC7;		 			// portb PB7, PB6, PB2, PB1 e PB0 saída
										// PB5, PB4 e PB3 entrada 
	
	PORTC = 0x00;		 			// sem pull-ups 
	DDRC  = 0xFF;		 			// portc saída 

	PORTD = 0x00;		 			// sem pull-ups 	
	DDRD  = 0xFB;		 			// portd saída, exceto PD2 (INT0)
 
}

//***********************************************************************
// Função para zerar relógio
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
void zera_relogio(void){
	
	tempo.seg = 0x00;
	tempo.min = 0x00;
	tempo.hr  = 0x00;
	conta 	 = 0x00;
	atualiza_disp(0x00);				//atualiza display

}

//***********************************************************************
// Função para ativar o buzzer
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
void toca_buzzer(void){

	byte i, j;

	for (j=0; j<2; j++){
		buzz_on;							//ativa beep
		for(i=0; i<100; i++)
			_delay_ms(2);				//aguarda 200 ms
		buzz_off;						//desliga beep
		for(i=0; i<100; i++)
			_delay_ms(1);				//aguarda 100 ms
	}

}

//***********************************************************************
// Função para atualizar relógio
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
void atual_RTC(void){

	hora = tempo.hr;				//variáveis hora, min e seg em DS1302.c
	min = tempo.min;
	seg = tempo.seg;
	rtc_set_time();				//atualiza RTC

}
//***********************************************************************
// Função para acertar horas
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
void acerta_hora(void){	

	byte j;							//variável auxiliar

	GICR  = 0x00;					//desabilita a INT0
	conta = 0;
   tempo.seg = 0;
	while(hora_press){			//enquanto pedido de acerto faça

		if (all_press)				//se tudo pressionado, zera
			zera_relogio();

		tempo.hr++;
		for (j=0;j<10;j++)		//temporiza 0,10 segundos
			_delay_ms(10);   		//temporiza 0,01 segundos

		if (tempo.hr > 23){		//24 horas?
			tempo.hr=0;				//zera
			atualiza_disp(0x00);	//atualiza display
		}
		else							//não chegou no limite
			atualiza_disp(0x00); //apenas atualiza
	}
	atual_RTC();					//atualiza relógio
	GICR = 0x40;					//habilita INT0
}

//***********************************************************************
// Função para acertar minutos
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
void acerta_minutos(void){	

	byte j;							//variável auxiliar

	GICR  = 0x00;					//desabilita a INT0
	conta = 0;
   tempo.seg = 0;
	while(min_press){				//enquanto pedido de acerto faça

		if (all_press)				//se tudo pressionado, zera
			zera_relogio();

		tempo.min++;
		for (j=0;j<10;j++)		//temporiza 0,10 segundos
			_delay_ms(10);   		//temporiza 0,01 segundos

		if (tempo.min > 59){		//24 horas?
			tempo.min=0;			//zera
			atualiza_disp(0x00);	//atualiza display
		}
		else							//não chegou no limite
			atualiza_disp(0x00);	//apenas atualiza
	}
	atual_RTC();					//atualiza relógio
	GICR = 0x40;					//habilita INT0
}

//***********************************************************************
// Função principal - MAIN
//***********************************************************************
int main(void){
	
	unsigned char j;				//variável auxiliar 
	
	cli();
	init_AVR();						//configura microcontrolador
	init_vars();					//inicia variáveis globais
	sei();							//habilita ints

   reset_hab;						//desabilita displays
	set_dt;							//coloca pinos de dado e clock
	set_clk;							//em estado lógico 1
	set_hab;							//habilita displays

	poutRTC &= ~_BV(RTCrst);		//desabilita DS1302
	poutTEMP &= ~_BV(TEMPrst);		//desabilita DS1620

	for (j=0;j<100;j++)			//temporiza 1 segundo antes de iniciar
		_delay_ms(10); 

	zera_relogio();				//zera variáveis do relógio
	init_rtc();						//inicia RTC
	_delay_ms(10);					//aguarda
	config_ds1620();				//configura DS1620
	get_temp_ds1620();			//le hora no DS1620
	_delay_ms(10);					//aguarda

	rtc_get_time();				//colhe horário no RTC
	tempo.hr = hora;				//atualiza var com hora inserida no RTC
	tempo.min = min;
	tempo.seg = seg;
	atualiza_disp(0x00);			//atualiza display com hora

	time_temp=0x00;				//começa mostrando horas, então na próxima mostre a temperatura
	time_5s=0x00;					//zera próximos 5 segundos

	init_INT0();					//configura interrupção externa INT0

	while (TRUE){					//faz "eternamente"
	
		if (hora_press)			//se pino PB4 e PB2 pressionados ajusta hora
			acerta_hora();
		
		if (min_press)				//se pino PB4 e PB5 pressionados ajusta minutos
			acerta_minutos();

		if(time_5s == 5){					//mostra hora?
			if (time_temp){
				atualiza_disp(0x00);		//atualiza display com hora
				leds_on;						//liga leds
				time_temp=0x00;
				if (toca_buzz){
					toca_buzzer();			//ativa buzzer - avisa hora cheia
					toca_buzz=0;			//já tocou, aguarda próxima hora
					time_temp = 1;			//tem que mostrar a hora
				}
			}
			else{
				atualiza_disp(0x01);		//atualiza disp com temperatura
				leds_off;					//desliga leds
				time_temp=0x01;			//na próxima mostre hora
			}
			time_5s=0x00;					//zera e aguarda a próxima
		}
		
		if (atualiza_RTC){
			atual_RTC();					//atualiza relógio
			atualiza_RTC = 0;				//já atualizou, aguarda próximo minuto
		}

		
	}	

	return (0);
}

