//***********************************************************************
// Funções para uso do DS1620 (TEMP)
// Desenvolvido por Márcio José Soares
//
// Microcontrolador: AVR
// Compilador: avr-gcc (GCC) 4.1.0 - Linux
//
// Última alteração: 21/08/2007
//
//***********************************************************************

//******************************************************************************
// Definições para os registradores e controle do DS1620
//******************************************************************************
#define ESCRCONF  0x0C           //protocolo para escrita
#define LECONF    0xAC           //protocolo para leitura
#define DS_CPU    0x02           //bit de config.: termometro no modo serial
#define DS_NCPU   0x00           //bit de config.: termometro no modo "standalone"
#define DS_ONE    0x01           //bit de config.: uma conversão por vez, quando ligado
#define DS_CONT   0x00           //bit de config.: conversão contínua, quando ligado

#define DS_INIT   0xEE           //protocolo para iniciar a conversão
#define DS_STOP   0x22           //protocolo para parar a conversão
#define DS_TEMP   0xAA           //protocolo para ler a temperatura

#define DS_RHI    0xA1           //protocolo para ler "High-Temperature Setting"
#define DS_WHI    0x01           //protocolo para escrever "High-Temperature Setting"
#define DS_RLO    0xA2           //protocolo para ler "Low-Temperature Setting"
#define DS_WLO    0x02           //protocolo para escrever "Low-Temperature Setting"

//***********************************************************************
// Funções do módulo
//***********************************************************************

//******************************************************************************
// Função para escrever dados no DS1620
// Entradas - valor a escrever (byte a escrever)
// Saidas   - nenhuma
//******************************************************************************
void write_ds1620(unsigned char dado){

   byte i;

   for (i=0;i<8;i++){
   	 poutTEMP &= ~_BV(TEMPclk); 			// abaixa clock
     if (bit_is_set(dado, i))     			//se bit = 1, insere 1
        poutTEMP |= _BV(TEMPio) ;
     else											//se bit = 0, insere 0
        poutTEMP &= ~_BV(TEMPio) ;   
     poutTEMP |= _BV(TEMPclk) ; 				//levanta clock
  }

}

//******************************************************************************
// Função para ler dado do DS1620
// Entradas - nenhuma
// Saidas   - nenhuma
//******************************************************************************
void read_ds1620(void){

   byte i;
 
   poutTEMP |= _BV(TEMPclk);			//levanta clock
   poutTEMP |= _BV(TEMPrst);			//habilita DS1620
   write_ds1620(DS_TEMP);   			//envia comando para DS1620, solicitando leitura
   	
  
   poutTEMP &= ~_BV(TEMPio); 			//configura pino como entrada
   psetTEMP &= ~_BV(TEMPio); 


   poutTEMP |= _BV(TEMPrst);			//habilita DS1620
   for(i=0;i<9;i++){          		//são 9 bits a ler
      poutTEMP &= ~_BV(TEMPclk);		// abaixa clock
      temp_ds1620 >>= 0x01;      	//gira dado a direita
      if(bit_is_set(pinTEMP,TEMPio))//se bit igual a 1
         temp_ds1620 |= 0x0100;   	//levanta bit 8
      else
         temp_ds1620 &= ~0x0100;  	//abaixa bit 8

      poutTEMP |= _BV(TEMPclk);		//levanta clock
      

   }
   poutTEMP &= ~_BV(TEMPrst);  		//desabilita DS1620

   psetTEMP = 0xFF;						//todos os pinos como saída

 
}

//******************************************************************************
// Função para ler a configuração do DS1620
// Ajuda na depuração do programa e verificação do DS1620
//
// Entradas - nenhuma
// Saidas   - nenhuma (reflete dados diretamente na serial
//******************************************************************************
void read_config_ds1620(void){

   unsigned char aux, i;

   aux=0x00;
   write_ds1620(LECONF);    			//prepara para ler configuração

   poutTEMP &= ~_BV(TEMPio); 			//configura pino como entrada
   psetTEMP &= ~_BV(TEMPio); 

   poutTEMP |= _BV(TEMPrst);			//habilita DS1620

   for(i=0;i<7;i++){          		//são 8 bits
      poutTEMP &= ~_BV(TEMPclk);		//abaixa clock
      if(bit_is_set(pinTEMP,TEMPio))
         aux |= 0x80;      			//bit7 = 1
      else
         aux &= ~0x80;     			//bit7 = 0
      poutTEMP |= _BV(TEMPclk);		//levanta clock
	  aux >>= 0x01;           			//gira dado a direita
   }

   psetTEMP = 0xFF;						//todos os pinos como saída
   poutTEMP &= ~_BV(TEMPrst);  		//desabilita DS1620

}

//******************************************************************************
// Função para configurar o DS1620
// Entradas - nenhuma
// Saidas   - nenhuma
//******************************************************************************
void config_ds1620(void){

   //avisa que vai escrever dado no registrador de config.
   poutTEMP |= _BV(TEMPclk);        //levanta clock
   poutTEMP |= _BV(TEMPrst);        //habilita DS1620
   write_ds1620(ESCRCONF);  			//entra no modo configuração
   write_ds1620(DS_CPU | DS_CONT);  //modo CPU + modo continuo = 0x02
   poutTEMP &= ~_BV(TEMPrst);

   _delay_ms(10);							//aguarda iniciar

   conf1=1;                			//setup pronto
   
 }

//******************************************************************************
// Função para iniciar leituras no DS1620
// Entradas - nenhuma
// Saidas   - nenhuma
//******************************************************************************
void start_ds1620(void){

   //inicia as conversões
   poutTEMP |= _BV(TEMPclk);        //levanta clock
   poutTEMP |= _BV(TEMPrst);        //habilita DS1620
   write_ds1620(DS_INIT);   			//inicia DS1620 (conversões)
   poutTEMP &= ~_BV(TEMPrst);       //desabilita DS1620
}

//******************************************************************************
// Função para parar leituras no DS1620
// Entradas - nenhuma
// Saidas   - nenhuma
//******************************************************************************
void stop_ds1620(void){   
  
   //pára conversões
   poutTEMP |= _BV(TEMPclk);     	//levanta clock
   poutTEMP |= _BV(TEMPrst);        //habilita DS1620
   write_ds1620(DS_STOP);   			//para conversões no DS1620
   poutTEMP &= ~_BV(TEMPrst);       //desabilita DS1620
  
}


//******************************************************************************
// Função para converter valor recebido do CI DS1620
// Analisa se valo passado é negativo
// recebe 	- nada
// retorna 	- nada
//******************************************************************************
void conv_ds1620(void){

   sinal='+';                         			//conversão sempre positiva
   if (temp_ds1620 & 0x100){  		  	  		//se o bit8 = 1 então valor passado, negativo
      sinal='-';                      			//conversão é negativa
      temp_ds1620 = (~temp_ds1620+1) & 0xFF;	//inverte dado e soma 1: complemento de dois
  }
   temp_ds1620 /= 2;	                  		//acerta dado
 
}


//******************************************************************************
// Função para ler a temperatura do CI DS1620
// recebe 	- nada
// retorna 	- nada (valor convertido e pronto para uso dentro de temp_ds1620)
//******************************************************************************
void get_temp_ds1620(void){

		start_ds1620();						//inicia conversão de temperatura
		_delay_ms(10);							//aguarda conversão
		stop_ds1620();							//pára a conversão
		read_ds1620();							//colhe última leitura realizada
		conv_ds1620();							//converte o valor
}
