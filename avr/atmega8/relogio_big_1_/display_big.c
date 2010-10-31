//***********************************************************************
// MODULO DISPLAY BIG - fun��es para uso do Display Big (ET-111) - v 1.0
// Desenvolvido por M�rcio Jos� Soares - 06/08/2007
//
// Microcontrolador: AVR MEGA
// Compilador: avr-gcc (GCC) 4.1.0 - Linux / Win AVR - Windows
//
// �ltima altera��o: 09/08/2007
//
//***********************************************************************

//***********************************************************************
// Arquivos incluidos no m�dulo
//***********************************************************************
#include "display_big.h"

//***********************************************************************
// Fun��es do m�dulo
//***********************************************************************

//***********************************************************************
// Fun��o escreve_disp() -escreve dado no display habilitado
//
// Entradas - dado
// Sa�das   - nenhuma
//***********************************************************************
void escreve_disp(byte dado){

	byte b;
	
	reset_clk;						//desabilita clock
	for (b=0;b<8;b++){
		if (dado/128)				//insere bit no pino de dados
			set_dt;					//1
		else
			reset_dt;				//0
			
		set_clk;						//seta clock
		_delay_ms(6);				//aguarda 5 ms
		reset_clk;					//desabilita clock
		
		dado = dado * 2;			//shift left
	}	
		
}
	
//***********************************************************************
// Fun��o transfer_disp() - tranfere dado no FF para o latch do display
//
// Entradas - numero do display a transferir
// Sa�das   - nenhuma
//***********************************************************************
void transfer_disp(byte nr_disp){
	
		
	switch (nr_disp){
		case 0x00:
			set_trans1;						//habilita transfer�ncia
			_delay_ms(10);	
			reset_trans1;					//desabilita transfer�ncia
			break;
		case 0x01:
			set_trans2;						//habilita transfer�ncia
			_delay_ms(10);	
			reset_trans2;					//desabilita transfer�ncia
			break;
		case 0x02:
			set_trans3;						//habilita transfer�ncia
			_delay_ms(10);	
			reset_trans3;					//desabilita transfer�ncia
			break;
		case 0x03:
			set_trans4;						//habilita transfer�ncia
			_delay_ms(10);	
			reset_trans4;					//desabilita transfer�ncia
			break;
		default:
			set_trans1;						//habilita transfer�ncia
			_delay_ms(10);	
			reset_trans1;					//desabilita transfer�ncia
	}
}

//***********************************************************************
// Fun��o apaga_display() - envia 00H para 74LS595
//
// Entradas - numero do display a apagar
// Sa�das   - nenhuma
//***********************************************************************
void apaga_display(byte nr_disp){
	
	escreve_disp(0x00); 			//apaga display (limpa registradores 74LS595)
	transfer_disp(nr_disp);		//seleciona display
	
}	
	
//***********************************************************************
// Fun��o escreve_display() - escreve um dado no display solicitado
//
// Entradas - numero do display
//				  dado (0 a 9) ou 
//				  comando (10 - acende ponto)
// Sa�das   - nenhuma
//***********************************************************************
void escreve_dado(byte nr_disp, byte dadocom){
	
	if ((dadocom >= 0x00) && (dadocom <=0x0C)){		//dentro da faixa?
		escreve_disp(bcd_7seg[dadocom]);					//escreve dado
		transfer_disp(nr_disp);								//transfere p/ display
	}
}
