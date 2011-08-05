#include <SD.h>

#define LED1 2
#define LED2 3
#define LED3 4
#define LED4 5

char nome_e[] = "entrada/led.csv";
char nome_s[] = "saida/saida.csv";

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
    pinMode(LED1, OUTPUT);
    pinMode(LED2, OUTPUT);
    pinMode(LED3, OUTPUT);
    pinMode(LED4, OUTPUT);
}

void loop()
{
    /*******************************/
    /* Inicialização das variaveis */
    /*******************************/
    int led[4];
    int time;
    int i;
    int menu;
    char string[12];
    
    Serial.print("\n\n");
    Serial.println("Deseja:");
    Serial.println("1 - criar um novo arquivo de entrada");
    Serial.println("2 - ler um arquivo de saida");
    Serial.println("3 - remover");
    Serial.println("4 - rodar um experimento");
    
    while (!Serial.available());
    menu = Serial.read();
    delay(100);
    while (Serial.available()) Serial.read();
    
    
    if (menu == '1') //Rotina de gravação do SD
    {
        le_string(string);
        File file = SD.open(string, FILE_WRITE);
        
        if(Serial.available())
        {
            while (Serial.available() > 0)
            {
                file.print( Serial.read() );
            }
            file.close();
        } 
        else
        {
            Serial.println("Erro ao criar arquivo");
        }
    }
    
    if(menu == '2')
    {
        le_string(string);
        File file = SD.open(string);

        if (file)
        {
            while (file.available())
            {
                Serial.write(file.read());
            }
            file.close();
        }
    }
    
    if(menu == '3')
    {
        le_string(string);
        if(SD.remove(string) == 1)
        {
            Serial.println("removido");
        }
        else
        {
            Serial.println("Erro ao remover arquivo");
        }
    }

    if(menu == '4')
    {
        File file_e = SD.open(nome_e);
        if (!file_e) Serial.println("Arquivo de entrada nao encontrado");
    
        if (file_e)
        {
            // pula uma linha
            while (file_e.read() != '\n');
            
            // Enquanto o arquivo de entrada não estiver terminado
            while (file_e.available())
            {
                //Pega uma linha
                for (i=0; i<4; i++)
                {
                    led[i] = pega_numero(file_e);
                }
                time = pega_numero(file_e);
                
                //Faz alguma coisa com a linha
                for (i=0; i<4; i++)
                {
                    digitalWrite(LED1 + i, led[i]);
                }
                delay(time);
                
                //Manda a linha pro arquivo de saida
                String text = String(led[0]) + ';' + String(led[1]) + ';' + String(led[2]) + ';' + String(led[3]) + ';' + String(time);
                Serial.println(text);
                escreve_sd(file_e, text);
            }
            
            file_e.close();
        }
    }
}

int pega_numero(File file)
{
    int i = 0;

    //while ( file.peek() != ';' && file.peek() != '\r' && file.peek() != '\n' && file.peek() != ' ' )
    while ( file.peek() >= '0' && file.peek() <= '9' )
    {
        i = i*10 + file.read() - 48; 
    }
    
    //while ( (file.peek() == ';' || file.peek() == '\r' || file.peek() == '\n') && file.available() )
    while ( (file.peek() < '0' || file.peek() > '9') && file.available() )
    {
        file.read();
    }
    
    return i;
}

void escreve_sd(File file_e, String data)
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

char le_string(char string[12])
{
    int i;
    
    Serial.print("Lendo string: ");
    
    for(i = 0; i < 12; i++){
        while(Serial.available() == 0);
        string[i] = Serial.read();
    }
    
    for (i = 0; i<12; i++)
    {
        Serial.print(string[i]);
    }
}

