#include <SD.h>

char nome_e[] = "entra000.csv"; // pode mudar o nome, mas deve manter o número de letras e números
char nome_s[] = "saida000.csv"; // idem

void setup()
{
    /******************************/
    /* Inicialização do cartão SD */
    /******************************/
    Serial.begin(9600);
    Serial.print("Iniciando cartao SD...");
    pinMode(10, OUTPUT);
    
    if (!SD.begin(8))
    {
        Serial.println("Erro");
        return;
    }
    Serial.println("OK");
}

void loop()
{
    /*******************************/
    /* Inicialização das variaveis */
    /*******************************/
    int m = 10;
    int teste[10]; // este trecho pode sair
    int i;
    int j;
    int menu;
    String text;
    
    for(j=0; j<m; j++)
    {
      teste[j] = 0;
    }
    
    Serial.print("\n"); // pede entrada dos nomes dos arquivos e entrada e saida
    Serial.println("Voce deseja:");
    Serial.println("1 - Testa gravacao");
    Serial.println("2 - Le arquivo de saida");
    
    while (!Serial.available()); //enquanto não estiver nada na serial, ele fica entro da alça
    menu = Serial.read(); // Assim que houver algo ele lê

    if (menu == '1') //Começar novo experimento
    {
        Serial.print("\nComecando teste: ");
        
        File file_e = SD.open(nome_e);
        if (!file_e) Serial.println("Arquivo de entrada nao encontrado");
    
        for(i=0; i<13; i++)
        {
            // pula uma linha - linha do CABEÇALHO - melhor manter esta linha para evitar problemas
            
            for(j=0;j<m;j++)
            {
              text = String(teste[j]) ;
              Serial.print(text);
              escreve_sd(file_e, String (teste[j]) );
            }
            
            Serial.println(' ');
            escreve_sd(file_e, "\r\n");

            
            for(j=0; j<m; j++)
            {
              teste[j] ++;
            }
            
        }
        
        file_e.close();
    } // DAQUI O SISTEMA VOLTA PARA O MENU
    
    if (menu == '2') // ESTE MENU SERVE PARA LER O ARQUIVO QUE FOI GRAVADO, CASO HAJA NECESSIDADE. sE MUDAR NUMEROS E NOMES, DEVE-SE ALTERAR AQUI TAMBEM
    {
        Serial.println("Digite o numero do experimento utilizando \n necesariamente 3 digitos (ex: 001)");
        for(i = 0; i < 3; i++)
        {
            while(Serial.available() == 0);
            nome_s[5+i] = Serial.read();
        }
        
        Serial.print("\nLendo experimento: ");
        for(i = 0; i < 12; i++)
        {
            Serial.print(nome_s[i]);
        }
        Serial.print("\n\n");
        
        File file = SD.open(nome_s);
        if (!file) Serial.println("Arquivo de entrada nao encontrado");

        if (file)
        {
            while (file.available())
            {
                Serial.write(file.read());
            }
            file.close();
        }
    }
}

int pega_numero(File file) // IDENTIFICA SE HÁ UM NUMERO APENAS OU UM CONJUNTO DE NÚMEROS DENTRO DO ARQUIVO
{
    int i = 0;

    //while ( file.peek() != ';' && file.peek() != '\r' && file.peek() != '\n' && file.peek() != ' ' )
    while ( file.peek() >= '0' && file.peek() <= '9' )
    {
        i = i*10 + file.read() - '0'; // TRANSFORMADOR DE NÚMEROS INDIVIDUAIS EM DECIMAIS
    }
    
    //while ( (file.peek() == ';' || file.peek() == '\r' || file.peek() == '\n') && file.available() )
    while ( (file.peek() < '0' || file.peek() > '9') && file.available() )
    {
        file.read();
    }
    
    return i;
}

void escreve_sd(File file_e, String data) //GRAVA OS RESULTADOS FINAIS NA MATRIZ
{
    int posicao;
    
    posicao = file_e.position();
    file_e.close();
 
    File file_s = SD.open(nome_s, FILE_WRITE);
    if (file_s)
    {
        file_s.print(data);
        if (data != "\r\n") file_s.print(';');
        file_s.close();
    }
    else Serial.println("Nao foi possivel criar arquivo de saida");
    
    file_e = SD.open(nome_e);
    file_e.seek(posicao);
}


