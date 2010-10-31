//***********************************************************************
// Fun��es para uso do DS1620 (TEMP)
// Desenvolvido por M�rcio Jos� Soares
//
// Microcontrolador: AVR
// Compilador: avr-gcc (GCC) 4.1.0 - Linux
//
// �ltima altera��o: 21/08/2007
//
//***********************************************************************

//******************************************************************************
// Defini��es para os registradores e controle do DS1620
//******************************************************************************
#define ESCRCONF  0x0C           //protocolo para escrita
#define LECONF    0xAC           //protocolo para leitura
#define DS_CPU    0x02           //bit de config.: termometro no modo serial
#define DS_NCPU   0x00           //bit de config.: termometro no modo "standalone"
#define DS_ONE    0x01           //bit de config.: uma convers�o por vez, quando ligado
#define DS_CONT   0x00           //bit de config.: convers�o cont�nua, quando ligado

#define DS_INIT   0xEE           //protocolo para iniciar a convers�o
#define DS_STOP   0x22           //protocolo para parar a convers�o
#define DS_TEMP   0xAA           //protocolo para ler a temperatura

#define DS_RHI    0xA1           //protocolo para ler "High-Temperature Setting"
#define DS_WHI    0x01           //protocolo para escrever "High-Temperature Setting"
#define DS_RLO    0xA2           //protocolo para ler "Low-Temperature Setting"
#define DS_WLO    0x02           //protocolo para escrever "Low-Temperature Setting"

//***********************************************************************
// Fun��es do m�dulo
//***********************************************************************

//******************************************************************************
// Fun��o para escrever dados no DS1620
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
// Fun��o para ler dado do DS1620
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
   for(i=0;i<9;i++){          		//s�o 9 bits a ler
      poutTEMP &= ~_BV(TEMPclk);		// abaixa clock
      temp_ds1620 >>= 0x01;      	//gira dado a direita
      if(bit_is_set(pinTEMP,TEMPio))//se bit igual a 1
         temp_ds1620 |= 0x0100;   	//levanta bit 8
      else
         temp_ds1620 &= ~0x0100;  	//abaixa bit 8

      poutTEMP |= _BV(TEMPclk);		//levanta clock
      

   }
   poutTEMP &= ~_BV(TEMPrst);  		//desabilita DS1620

   psetTEMP = 0xFF;						//todos os pinos como sa�da

 
}

//******************************************************************************
// Fun��o para ler a configura��o do DS1620
// Ajuda na depura��o do programa e verifica��o do DS1620
//
// Entradas - nenhuma
// Saidas   - nenhuma (reflete dados diretamente na serial
//******************************************************************************
void read_config_ds1620(void){

   unsigned char aux, i;

   aux=0x00;
   write_ds1620(LECONF);    			//prepara para ler configura��o

   poutTEMP &= ~_BV(TEMPio); 			//configura pino como entrada
   psetTEMP &= ~_BV(TEMPio); 

   poutTEMP |= _BV(TEMPrst);			//habilita DS1620

   for(i=0;i<7;i++){          		//s�o 8 bits
      poutTEMP &= ~_BV(TEMPclk);		//abaixa clock
      if(bit_is_set(pinTEMP,TEMPio))
         aux |= 0x80;      			//bit7 = 1
      else
         aux &= ~0x80;     			//bit7 = 0
      poutTEMP |= _BV(TEMPclk);		//levanta clock
	  aux >>= 0x01;           			//gira dado a direita
   }

   psetTEMP = 0xFF;						//todos os pinos como sa�da
   poutTEMP &= ~_BV(TEMPrst);  		//desabilita DS1620

}

//******************************************************************************
// Fun��o para configurar o DS1620
// Entradas - nenhuma
// Saidas   - nenhuma
//******************************************************************************
void config_ds1620(void){

   //avisa que vai escrever dado no registrador de config.
   poutTEMP |= _BV(TEMPclk);        //levanta clock
   poutTEMP |= _BV(TEMPrst);        //habilita DS1620
   write_ds1620(ESCRCONF);  			//entra no modo configura��o
   write_ds1620(DS_CPU | DS_CONT);  //modo CPU + modo continuo = 0x02
   poutTEMP &= ~_BV(TEMPrst);

   _delay_ms(10);							//aguarda iniciar

   conf1=1;                			//setup pronto
   
 }

//******************************************************************************
// Fun��o para iniciar leituras no DS1620
// Entradas - nenhuma
// Saidas   - nenhuma
//******************************************************************************
void start_ds1620(void){

   //inicia as convers�es
   poutTEMP |= _BV(TEMPclk);        //levanta clock
   poutTEMP |= _BV(TEMPrst);        //habilita DS1620
   write_ds1620(DS_INIT);   			//inicia DS1620 (convers�es)
   poutTEMP &= ~_BV(TEMPrst);       //desabilita DS1620
}

//******************************************************************************
// Fun��o para parar leituras no DS1620
// Entradas - nenhuma
// Saidas   - nenhuma
//******************************************************************************
void stop_ds1620(void){   
  
   //p�ra convers�es
   poutTEMP |= _BV(TEMPclk);     	//levanta clock
   poutTEMP |= _BV(TEMPrst);        //habilita DS1620
   write_ds1620(DS_STOP);   			//para convers�es no DS1620
   poutTEMP &= ~_BV(TEMPrst);       //desabilita DS1620
  
}


//******************************************************************************
// Fun��o para converter valor recebido do CI DS1620
// Analisa se valo passado � negativo
// recebe 	- nada
// retorna 	- nada
//******************************************************************************
void conv_ds1620(void){

   sinal='+';                         			//convers�o sempre positiva
   if (temp_ds1620 & 0x100){  		  	  		//se o bit8 = 1 ent�o valor passado, negativo
      sinal='-';                      			//convers�o � negativa
      temp_ds1620 = (~temp_ds1620+1) & 0xFF;	//inverte dado e soma 1: complemento de dois
  }
   temp_ds1620 /= 2;	                  		//acerta dado
 
}


//******************************************************************************
// Fun��o para ler a temperatura do CI DS1620
// recebe 	- nada
// retorna 	- nada (valor convertido e pronto para uso dentro de temp_ds1620)
//******************************************************************************
void get_temp_ds1620(void){

		start_ds1620();						//inicia convers�o de temperatura
		_delay_ms(10);							//aguarda convers�o
		stop_ds1620();							//p�ra a convers�o
		read_ds1620();							//colhe �ltima leitura realizada
		conv_ds1620();							//converte o valor
}
