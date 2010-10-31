//***********************************************************************
// Diretrizes de pré-compilação para módulo display_big
// Desenvolvido por Márcio José Soares - 09/08/2007
//***********************************************************************

//******************************************************************
//* Definições para macros de controle dos pinos do 74LS595 (Disp BIG)
//******************************************************************
#define set_dt 		port595 |= pdado				//seta pino de dados
#define reset_dt 		port595 &= ~pdado	 			//reseta pino de dados

#define set_clk		port595 |= pclock				//seta pino de clock
#define reset_clk 	port595 &= ~pclock 			//reset pino de dados

#define set_hab		port595 &= ~phab				//seta pino de habilitação
#define reset_hab 	port595 |= phab 				//reset pino de habilitação

#define set_trans1		porttrans |= ptrans1		//seta pino de transferência
#define reset_trans1 	porttrans &= ~ptrans1	//reset pino de transferência

#define set_trans2		porttrans |= ptrans2		//seta pino de transferência
#define reset_trans2 	porttrans &= ~ptrans2	//reset pino de transferência

#define set_trans3		porttrans |= ptrans3		//seta pino de transferência
#define reset_trans3 	porttrans &= ~ptrans3 	//reset pino de transferência

#define set_trans4		porttrans |= ptrans4		//seta pino de transferência
#define reset_trans4 	porttrans &= ~ptrans4	//reset pino de transferência

//***********************************************************************
// Variáveis globais do módulo
//***********************************************************************

//guarda valores para conversão BCD com display BIG
//ordem dos segmentos -> f, e, d, g, c, a, b, ponto
const_byte bcd_7seg[] = {0xEE, /*d0 - b11101110*/
								 0x0A, /*d1 - b00001010*/
								 0x76, /*d2 - b01110110*/
								 0x3E, /*d3 - b00111110*/
								 0x9A, /*d4 - b10011010*/
								 0xBC, /*d5 - b10111100*/
								 0xFC, /*d6 - b11111100*/
								 0x0E, /*d7 - b00001110*/
								 0xFE, /*d8 - b11111110*/
								 0x9E, /*d9 - b10011110*/
								 0x01, /*ponto - b00000001*/
								 0x96, /*simbolo grau - b10010110*/
								 0xE4  /*caracter C - Celsius - b11100100*/
									 };


