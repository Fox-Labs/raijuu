//***********************************************************************
// Fun��es para uso do RTC DS1302
// M�rcio Jos� Soares
//
// Microcontrolador: AVR
// Compilador: avr-gcc (GCC) 4.1.0 - Linux / Win AVR
//
// �ltima altera��o: 09/08/2007
//
// Aten��o!
// Regra para escrita:
// Valor a ser inserido no DS1302 deve estar em BCD!
// fazer a convers�o antes de usar write_byte!
//
// Regra para leitura:
// Valor recebido do DS1302 � lido em bin�rio!!!
// necess�rio sua convers�o pela fun��o que ir� manipular o dado!
//***********************************************************************

//***********************************************************************
//* Defini��es para registradores e controle do DS1302
//***********************************************************************
#define sec_w 		0x80		//endere�o do reg para conf. segundos - escrita
#define sec_r 		0x81		//endere�o do reg para conf. segundos - leitura

#define min_w 		0x82		//endere�o do reg para conf. minutos - escrita
#define min_r 		0x83		//endere�o do reg para conf. minutos - leitura

#define hour_w 	0x84		//endere�o do reg para conf. horas - escrita
#define hour_r 	0x85		//endere�o do reg para conf. horas - leitura

#define date_w 	0x86		// Microcontrolador: AVR MEGA//endere�o do reg para conf. data - escrita
#define date_r 	0x87		//endere�o do reg para conf. data - leitura

#define month_w 	0x88		//endere�o do reg para conf. mes - escrita
#define month_r 	0x89		//endere�o do reg para conf. mes - leitura

#define day_w 		0x8A		//endere�o do reg para conf. dia semana - escrita
#define day_r 		0x8B		//endere�o do reg para conf. dia semana - leitura

#define year_w 	0x8C		//endere�o do reg para conf. ano - escrita
#define year_r 	0x8D		//endere�o do reg para conf. ano - leitura

#define w_protect 0x8E		//endere�o do reg para prote��o contra escrita
#define r_protect 0x8F		//endere�o do reg para prote��o contra escrita - leitura

#define t_rate_w 	0x90		//trickle rate escrita
#define t_rate_r 	0x91		//trickle rate leitura

#define ram_w		0xC0		//inicio do endere�o da RAM presente no DS1302 - escrita
#define ram_r		0xC1		//inicio do endere�o da RAM presente no DS1302 - leitura

//***********************************************************************
//Vari�veis globais para o m�dulo DS1302.c
//***********************************************************************
byte dia, mes, ano, dow;      		//vari�veis para receber dados
byte hora, min, seg; 					//das fun��es do m�dulo DS1302.C

//***********************************************************************

//***********************************************************************
// Fun��es do m�dulo
//***********************************************************************

//***********************************************************************
// Fun��o para converter bin�rio->bcd 
// recebe 	- byte a converter 
// retorna 	- byte convertido
//***********************************************************************
byte bin_bcd(byte rec){

   byte lsb, msb, ret;//, i ,j;

	if(rec > 9){
  		msb = (rec / 10) & 0x0F;		//pega inteiro da divis�o
		msb <<= 4;							//shift left x4
		lsb = (rec % 10) & 0x0F;		//resto da divis�o
	}
	else{
		msb = 0;				//zero
		lsb = rec;
	}
	
	ret = msb | lsb;	//junta as partes

   return ret;			//retorna byte alterado
}

//***********************************************************************
// Fun��o para resetar o DS1302
//
// Entradas - nenhuma
// Sa�das   - nenhuma
//***********************************************************************
void reset(void){

	psetRTC |= _BV(RTCrst) ; 			//levanta reset
	poutRTC &= ~_BV(RTCclk); 			//abaixa clock
	poutRTC &= ~_BV(RTCrst); 			//abaixa reset
	poutRTC |= _BV(RTCrst) ; 			//levanta reset

}

//***********************************************************************
// Fun��o para escrever um byte no DS1302
//
// Entradas - nenhuma
// Sa�das   - nenhuma
//***********************************************************************
void write(byte W_Byte){
	byte i;
	
	psetRTC = 0xFF;

	for(i = 0; i < 8; i++){
		poutRTC &= ~_BV(RTCio); 		//abaixa data_io 
		if(W_Byte & 0x01)					//compara bit com 1
			poutRTC |= _BV(RTCio) ; 	//levanta data_io
		
		poutRTC |= _BV(RTCclk) ; 		//levanta clock
		_delay_us(2);						//aguarda
		poutRTC &= ~_BV(RTCclk); 		//abaixa clock
		_delay_us(2);						//aguarda
		W_Byte >>=1;						//shift a direita
	}

}

//***********************************************************************
// Fun��o para ler um byte do DS1302
//
// Entradas - nenhuma
// Sa�das   - byte lido
//***********************************************************************
byte read(void){

	byte i;
	byte R_Byte, R_Byte2, TmpByte;

	psetRTC |= _BV(RTCio) ; 			//levanta pino data

	R_Byte = 0x00;							//inicia vari�veis
	R_Byte2 = 0x00;
	poutRTC &= ~_BV(RTCio); 			//abaixo pino data;
	psetRTC &= ~_BV(RTCio); 			//abaixa pino - garantia e perda de um ciclo;

	for(i = 0; i < 4; i++){ 			//pega os quatro primeiros bits
		TmpByte = 0;
		if(bit_is_set(pinRTC,RTCio))	//n�vel l�gico 1?
			TmpByte = 1;					//faz byte tempor�rio = 00000001

		TmpByte <<= 7;						//shift left x7 = 10000000
		R_Byte >>= 1;						//shift rigth x1
		R_Byte |= TmpByte;				//junta partes

		poutRTC |= _BV(RTCclk) ; 		//levanta clock
		_delay_us(2);						//aguarda
		poutRTC &= ~_BV(RTCclk); 		//abaixa clock
		_delay_us(2);						//aguarda
	}
	
	for(i = 0; i < 4; i++){ 			//pega os pr�ximos 4 bits
		TmpByte = 0;						//
		if(bit_is_set(pinRTC,RTCio))	//
			TmpByte = 1;

		TmpByte <<= 7;
		R_Byte2 >>= 1;
		R_Byte2 |= TmpByte;

		poutRTC |= _BV(RTCclk) ; 		//levanta clock
		_delay_us(2);						//aguarda
		poutRTC &= ~_BV(RTCclk); 		//abaixa clock
		_delay_us(2);						//aguarda
	}
	R_Byte >>= 4;							//shift rigth x4
	R_Byte2 >>= 4;
	R_Byte = (R_Byte2 * 10) + R_Byte;//monta

	return R_Byte;							//retorna

}

//***********************************************************************
// Fun��o para ler um dado do DS1302
//
// Entradas - endere�o do registrador a ser lido
// Sa�das   - byte lido
//***********************************************************************
byte read_byte(byte w_byte){
	
	byte temp;							//vari�vel aux

	reset();								//reseta DS1302
	write(w_byte);						//envia endere�o do registro a ser lido
	temp = read();						//l� dado retornado
	poutRTC &= ~_BV(RTCrst); 		//abaixa reset
	poutRTC &= ~_BV(RTCclk); 		//abaixa clock

	return temp;						//retorna byte lido

}

//***********************************************************************
// Fun��o para escrever um dado no DS1302
//
// Entradas - endere�o do registrador e byte a ser escrito
// Sa�das   - nenhuma
//***********************************************************************
void write_byte(byte w_byte, byte w_2_byte){

	reset();								//reseta DS1302
	write(w_byte);						//envia end. do reg
	write(w_2_byte);					//envia byte a ser escrito no reg.
	poutRTC &= ~_BV(RTCrst); 		//abaixa reset
	poutRTC &= ~_BV(RTCclk); 		//abaixa clock

}

//***********************************************************************
// Fun��o para inicializar o DS1302
//
// Entradas - nenhuma
// Sa�das   - nenhuma
//
// valor a ser inserido no Ds1302 deve estar em BCD!
// fazer a convers�o antes de usar write_byte!
//***********************************************************************
void init_rtc(void){

	write_byte(w_protect, 0x00);		//habilita escrita
	write_byte(t_rate_w, 0x00);		//desabilita carga

}

//***********************************************************************
// Fun��o para atualizar hora no DS1302
//
// Entradas - nenhuma
// Sa�das   - nenhuma
//
// valor a ser inserido no Ds1302 deve estar em BCD!
// fazer a convers�o antes de usar write_byte!
//***********************************************************************
void rtc_set_time(void){

	write_byte(hour_w, bin_bcd(hora));	//escreve hora
	write_byte(min_w, bin_bcd(min));		//escreve minutos
	write_byte(sec_w, bin_bcd(seg));		//escreve segundos

}

//***********************************************************************
// Fun��o para ler a hora inserida no DS1302
//
// Entradas - endere�o do registrador e byte a ser escrito
// Sa�das   - nenhuma
//
// valor recebido do DS1302 em bin�rio... necess�rio sua convers�o
// pela fun��o que ir� manipular o dado
//***********************************************************************
void rtc_get_time(void){

	hora = read_byte(hour_r);			//pega hora
	min = read_byte(min_r);				//pega minutos
	seg = read_byte(sec_r);				//pega segundos

}
