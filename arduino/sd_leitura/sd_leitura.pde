#include <SD.h>


Sd2Card card;
SdVolume volume;
SdFile root;

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
  Serial.println("3 - ler todos os arquivos de saida");
  
  while (!Serial.available());
  menu = Serial.read();
  delay(100);
  
  if(menu == '1')
  {
    leNome(nome);
    leArquivo();
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
  
  if(menu == '3')
  { 
    if (!card.init(SPI_HALF_SPEED,8)) Serial.print("card.init failed!");
    if (!volume.init(&card)) Serial.print("vol.init failed!");
    if (!root.openRoot(&volume)) Serial.print("openRoot failed");
  
    listaArquivo();
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

void leArquivo()
{
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

void listaArquivo()
{
  dir_t p;
  
  root.rewind();
  while (root.readDir(p) > 0)
  {
    // done if past last used entry
    if (p.name[0] == DIR_NAME_FREE) break;

    // skip deleted entry and entries for . and  ..
    if (p.name[0] == DIR_NAME_DELETED || p.name[0] == '.') continue;

    // only list subdirectories and files
    if (!DIR_IS_FILE_OR_SUBDIR(&p)) continue;
   
    if(p.name[0] == 'r' || p.name[0] == 'R')
    {    
      for (uint8_t i = 0; i < 9; i++)
      {
        nome[i] = p.name[i];
        if (i == 8)
        {
          nome[8] = '.';
          nome[9] = 'c';
          nome[10] = 's';
          nome[11] = 'v';
        }
      }
      Serial.println(nome);
      leArquivo();
    }
    Serial.println();
  }
}


