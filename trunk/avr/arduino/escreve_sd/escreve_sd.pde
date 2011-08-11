/***************************************/
/* Exemplo de uso da função escreve_sd */
/***************************************/

//METODO ANTIGO
String text = String(LED)+';'+String(REF)+';'+String(DELAY)+';'+String(REF2)+';'+String(DELAY2) ;

//METODO NOVO
escreve_sd(file_e, String (LED) );
escreve_sd(file_e, String (REF) );
escreve_sd(file_e, String (DELAY) );
escreve_sd(file_e, String (REF2) );
escreve_sd(file_e, String (DELAY2) );
escreve_sd(file_e, String ("\r\n") );

//Detalhes
//
// # Não é mais necesario adicionar o ';'
//   A função escreve_sd ja o adiciona automaticamente
//
// # Deve-se necesariamente escrever o caracter de termino de linha "\r\n" ao final de uma linha
//
// # Isso aumenta o tempo de escrita do programa, mas nada perceptivel


/******************************/
/* Função escreve_sd - ver1.1 */
/******************************/
void escreve_sd(File file_e, String data) //GRAVA OS RESULTADOS FINAIS NA MATRIZ
{
    int posicao;
    
    posicao = file_e.position();
    file_e.close();
 
    File file_s = SD.open(nome_s, FILE_WRITE);
    if (file_s)
    {
        file_s.print(data); //Não mais adiciona automaticamente um fim de linha, isso deve ser controlado pelo usuario
        if (data != "\r\n") file_s.print(';'); //Caso não seja um fim de linha, adiciona o caractere ';'
        file_s.close();
    }
    else Serial.println("Nao foi possivel criar arquivo de saida");
    
    file_e = SD.open(nome_e);
    file_e.seek(posicao);
}
