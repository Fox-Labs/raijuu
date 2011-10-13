#include <SD.h>

File file;
char nome[] = "M0000000.csv";

void setup()
{
  Serial.begin(9600);
  sdInit();
}

void loop()
{
  int menu = 0;
  
  Serial.println("\n");
  Serial.println("Voce deseja:");
  Serial.println("1 - ler um arquivo");
  Serial.println("2 - remover um arquivo");
  
  while (!Serial.available());
  menu = Serial.read();
  delay(100);
  
  if(menu == '1')
  {
    leNome(nome);
    
    file = SD.open(nome, FILE_READ);

    if(file)
    {
      while (file.available())
      {
        Serial.write(file.read());
      }
      file.close();
    }
    else
    {
      Serial.println("Erro ao abrir arquivo");
    }
  }
  
  if(menu == '2')
  {
    leNome(nome);
    
    if(SD.remove(nome) == 1)
    {
      Serial.println("removido");
    }
    else
    {
      Serial.println("Erro ao remover arquivo");
    }
  }
  
}

void sdInit()
{
  pinMode(10, OUTPUT);
  if (!SD.begin(8))
  {
    Serial.println("Erro ao iniciar cartao SD");
    return;
  }
}

char leNome(char nome[])
{
  Serial.println("Digite o nome do arquivo: ");
  Serial.println();
  for(int i = 0; i < 12; i++)
  {
    while(Serial.available() == 0);
    nome[i] = Serial.read();
    Serial.print(nome[i]);
  }
  Serial.println();
}

