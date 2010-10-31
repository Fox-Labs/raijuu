//***********************************************************************
// Funções para uso do RTC DS1302
// Márcio José Soares
//
// Microcontrolador: AVR
// Compilador: avr-gcc (GCC) 4.1.0 - Linux / Win AVR
//
// Última alteração: 09/08/2007
//
// Atenção!
// Regra para escrita:
// Valor a ser inserido no DS1302 deve estar em BCD!
// fazer a conversão antes de usar write_byte!
//
// Regra para leitura:
// Valor recebido do DS1302 é lido em binário!!!
// necessário sua conversão pela função que irá manipular o dado!
//***********************************************************************

//***********************************************************************
//* Definições para registradores e controle do DS1302
//***********************************************************************
#define sec_w 		0x80		//endereço do reg para conf. segundos - escrita
#define sec_r 		0x81		//endereço do reg para conf. segundos - leitura

#define min_w 		0x82		//endereço do reg para conf. minutos - escrita
#define min_r 		0x83		//endereço do reg para conf. minutos - leitura

#define hour_w 	0x84		//endereço do reg para conf. horas - escrita
#define hour_r 	0x85		//endereço do reg para conf. horas - leitura

#define date_w 	0x86		// Microcontrolador: AVR MEGA//endereço do reg para conf. data - escrita
#define date_r 	0x87		//endereço do reg para conf. data - leitura

#define month_w 	0x88		//endereço do reg para conf. mes - escrita
#define month_r 	0x89		//endereço do reg para conf. mes - leitura

#define day_w 		0x8A		//endereço do reg para conf. dia semana - escrita
#define day_r 		0x8B		//endereço do reg para conf. dia semana - leitura

#define year_w 	0x8C		//endereço do reg para conf. ano - escrita
#define year_r 	0x8D		//endereço do reg para conf. ano - leitura

#define w_protect 0x8E		//endereço do reg para proteção contra escrita
#define r_protect 0x8F		//endereço do reg para proteção contra escrita - leitura

#define t_rate_w 	0x90		//trickle rate escrita
#define t_rate_r 	0x91		//trickle rate leitura

#define ram_w		0xC0		//inicio do endereço da RAM presente no DS1302 - escrita
#define ram_r		0xC1		//inicio do endereço da RAM presente no DS1302 - leitura

//***********************************************************************
//Variáveis globais para o módulo DS1302.c
//***********************************************************************
byte dia, mes, ano, dow;      		//variáveis para receber dados
byte hora, min, seg; 					//das funções do módulo DS1302.C

//***********************************************************************

//***********************************************************************
// Funções do módulo
//***********************************************************************

//***********************************************************************
// Função para converter binário->bcd 
// recebe 	- byte a converter 
// retorna 	- byte convertido
//***********************************************************************
byte bin_bcd(byte rec){

   byte lsb, msb, ret;//, i ,j;

	if(rec > 9){
  		msb = (rec / 10) & 0x0F;		//pega inteiro da divisão
		msb <<= 4;							//shift left x4
		lsb = (rec % 10) & 0x0F;		//resto da divisão
	}
	else{
		msb = 0;				//zero
		lsb = rec;
	}
	
	ret = msb | lsb;	//junta as partes

   return ret;			//retorna byte alterado
}

//***********************************************************************
// Função para resetar o DS1302
//
// Entradas - nenhuma
// Saídas   - nenhuma
//***********************************************************************
void reset(void){

	psetRTC |= _BV(RTCrst) ; 			//levanta reset
	poutRTC &= ~_BV(RTCclk); 			//abaixa clock
	poutRTC &= ~_BV(RTCrst); 			//abaixa reset
	poutRTC |= _BV(RTCrst) ; 			//levanta reset

}

//***********************************************************************
// Função para escrever um byte no DS1302
//
// Entradas - nenhuma
// Saídas   - nenhuma
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
// Função para ler um byte do DS1302
//
// Entradas - nenhuma
// Saídas   - byte lido
//***********************************************************************
byte read(void){

	byte i;
	byte R_Byte, R_Byte2, TmpByte;

	psetRTC |= _BV(RTCio) ; 			//levanta pino data

	R_Byte = 0x00;							//inicia variáveis
	R_Byte2 = 0x00;
	poutRTC &= ~_BV(RTCio); 			//abaixo pino data;
	psetRTC &= ~_BV(RTCio); 			//abaixa pino - garantia e perda de um ciclo;

	for(i = 0; i < 4; i++){ 			//pega os quatro primeiros bits
		TmpByte = 0;
		if(bit_is_set(pinRTC,RTCio))	//nível lógico 1?
			TmpByte = 1;					//faz byte temporário = 00000001

		TmpByte <<= 7;						//shift left x7 = 10000000
		R_Byte >>= 1;						//shift rigth x1
		R_Byte |= TmpByte;				//junta partes

		poutRTC |= _BV(RTCclk) ; 		//levanta clock
		_delay_us(2);						//aguarda
		poutRTC &= ~_BV(RTCclk); 		//abaixa clock
		_delay_us(2);						//aguarda
	}
	
	for(i = 0; i < 4; i++){ 			//pega os próximos 4 bits
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
// Função para ler um dado do DS1302
//
// Entradas - endereço do registrador a ser lido
// Saídas   - byte lido
//***********************************************************************
byte read_byte(byte w_byte){
	
	byte temp;							//variável aux

	reset();								//reseta DS1302
	write(w_byte);						//envia endereço do registro a ser lido
	temp = read();						//lê dado retornado
	poutRTC &= ~_BV(RTCrst); 		//abaixa reset
	poutRTC &= ~_BV(RTCclk); 		//abaixa clock

	return temp;						//retorna byte lido

}

//***********************************************************************
// Função para escrever um dado no DS1302
//
// Entradas - endereço do registrador e byte a ser escrito
// Saídas   - nenhuma
//***********************************************************************
void write_byte(byte w_byte, byte w_2_byte){

	reset();								//reseta DS1302
	write(w_byte);						//envia end. do reg
	write(w_2_byte);					//envia byte a ser escrito no reg.
	poutRTC &= ~_BV(RTCrst); 		//abaixa reset
	poutRTC &= ~_BV(RTCclk); 		//abaixa clock

}

//***********************************************************************
// Função para inicializar o DS1302
//
// Entradas - nenhuma
// Saídas   - nenhuma
//
// valor a ser inserido no Ds1302 deve estar em BCD!
// fazer a conversão antes de usar write_byte!
//***********************************************************************
void init_rtc(void){

	write_byte(w_protect, 0x00);		//habilita escrita
	write_byte(t_rate_w, 0x00);		//desabilita carga

}

//***********************************************************************
// Função para atualizar hora no DS1302
//
// Entradas - nenhuma
// Saídas   - nenhuma
//
// valor a ser inserido no Ds1302 deve estar em BCD!
// fazer a conversão antes de usar write_byte!
//***********************************************************************
void rtc_set_time(void){

	write_byte(hour_w, bin_bcd(hora));	//escreve hora
	write_byte(min_w, bin_bcd(min));		//escreve minutos
	write_byte(sec_w, bin_bcd(seg));		//escreve segundos

}

//***********************************************************************
// Função para ler a hora inserida no DS1302
//
// Entradas - endereço do registrador e byte a ser escrito
// Saídas   - nenhuma
//
// valor recebido do DS1302 em binário... necessário sua conversão
// pela função que irá manipular o dado
//***********************************************************************
void rtc_get_time(void){

	hora = read_byte(hour_r);			//pega hora
	min = read_byte(min_r);				//pega minutos
	seg = read_byte(sec_r);				//pega segundos

}
