#include <SD.h>

#define LED1 2
#define LED2 3
#define LED3 4
#define LED4 5

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
    
    /**************************/
    /* Inicialização dos LEDs */
    /**************************/
    pinMode(LED1, OUTPUT); // este trecho pode sair
    pinMode(LED2, OUTPUT);
    pinMode(LED3, OUTPUT);
    pinMode(LED4, OUTPUT);
}

void loop()
{
    /*******************************/
    /* Inicialização das variaveis */
    /*******************************/
    int led[4]; // este trecho pode sais
    int time;
    int i;
    int menu;
    
    Serial.print("\n"); // pede entrada dos nomes dos arquivos e entrada e saida
    Serial.println("Voce deseja:");
    Serial.println("1 - Comecar um novo experimento");
    Serial.println("2 - Ler um arquivo de saida");
    
    while (!Serial.available()); //enquanto não estiver nada na serial, ele fica entro da alça
    menu = Serial.read(); // Assim que houver algo ele lê

    if (menu == '1') //Começar novo experimento
    {
        Serial.println("Digite o numero do experimento utilizando \nnecesariamente 3 digitos (ex: 001)");
        for(i = 0; i < 3; i++) // se quiser aumentar o número de dígitos de números no nome do arquivo é aqui. e.g., de 3 para x
        {
            while(Serial.available() == 0);
            nome_e[5+i] = nome_s[5+i] = Serial.read(); //pergunda o número do experimento e muda aqui no nome - se muda numero de letras de 5 para 3 é aqui que muda
        }
        
        Serial.print("\nComecando experimento: ");
        for(i = 0; i < 12; i++) // imprime o nome do experimento. Se mudar o nome do arquivo, deve modificar aqui
        {
            Serial.print(nome_e[i]);
        }
        Serial.print("\n\n");
        
        File file_e = SD.open(nome_e);
        if (!file_e) Serial.println("Arquivo de entrada nao encontrado");
    
        if (file_e)
        {
            // pula uma linha - linha do CABEÇALHO - melhor manter esta linha para evitar problemas
            while (file_e.read() != '\n'); 
            escreve_sd(file_e, "");
            
            // Enquanto o arquivo de entrada não estiver terminado
            while (file_e.available()) // enquanto houve dados a serem lidos, ele prossegue lendo
            {
                //Pega uma linha
                for (i=0; i<4; i++) // aqui substituo o que se segue com a lista de variáveis incluídas no arquivo, um nome para cada coluna
                {
                    led[i] = pega_numero(file_e);
                }
                time = pega_numero(file_e); // números inteiros, NECESSARIAMENTE
                
                //Faz alguma coisa com a linha
                for (i=0; i<4; i++) // esta parte pode ser substituída com nosso código
                {
                    digitalWrite(LED1 + i, led[i]);
                }
                delay(time);
                
                //Manda a linha pro arquivo de saida
                //abaixo entra a lista das variáveis a serem GRAVADAS, incluindo as lidas e as geradas
                // deve ser dentro de "String (...), incluindo no parênteses todas as variáveis a serem gravadas, na ordem desejada
                String text = String(led[0]) + ';' + String(led[1]) + ';' + String(led[2]) + ';' + String(led[3]) + ';' + String(time); 
                Serial.println(text); // este trecho está enviando a saida para o serial. Não há necessidade de mante esse trecho.
                escreve_sd(file_e, text); // este trecho guarda a posição do arquivo de entrada. NÃO SE TRATA DO ARQUIVO DE SAÍDA
            }
            
            file_e.close();
        }
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
        file_s.println(data);
        file_s.close();
    }
    else Serial.println("Nao foi possivel criar arquivo de saida");
    
    file_e = SD.open(nome_e);
    file_e.seek(posicao);
}


