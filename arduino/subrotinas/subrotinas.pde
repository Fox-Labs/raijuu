#include <SoftwareSerial.h>
#include <SD.h>

#define txPin 2 //Pino do sinal do LCD
#define rxPin 0 //Deve ser mantido em 0

#define keyPin 5 //Pino analogico do Teclado

//Valores de calibração do teclado
#define key_1 48
#define key_2 95
#define key_3 137
#define key_4 198
#define key_5 334
#define key_6 431
#define key_7 557
#define key_8 722
#define key_9 800
#define key_10 884
#define key_11 949
#define key_12 972
#define erro 15

SoftwareSerial lcd(rxPin, txPin);
int c_lcd = 1; //Coluna LCD
int l_lcd = 1; //Linha LCD

char nome_e[] = "M0000000.csv";
char nome_s[] = "R0000000.csv";
File file_e;
File file_s;

int LED1;
int LED2;
int LED3;
int LED4;

void setup()
{
  Serial.begin(9600);

  lcdInit();
  sdInit();
}

void loop()
{
  lcdMenu();
  sdOpen();
  while( file_e.available() )
  {
    sdLeMatrix();
    sdEscreveMatrix();
  }
  sdClose();
}


void lcdMenu()
{
  int nome = 1;
  char tecla = 0;
  
  lcdLimpa();
  lcdEscreve("Rato:    000",1,1);
  lcdEscreve("Sessao: 0000",2,1);
  lcdEscreve(1,10);
  
  while(true)
  {
    tecla = 0;
    tecla = teclado (keyPin);
    delay(100);
    
    if(tecla == '*')
    {
      lcdEscreve(l_lcd,c_lcd - 1);
      nome = nome - 1;
    }
    if(tecla == '#')
    {
      lcdEscreve(l_lcd,c_lcd + 1);
      nome = nome + 1;
    }
    if(tecla >= '0' && tecla <= '9') 
    {
      lcdEscreve(tecla,l_lcd,c_lcd);
      nome_e[nome] = nome_s[nome] = tecla;
      nome = nome + 1;
    }
    if (l_lcd == 1 && c_lcd == 13)
    {
      lcdEscreve(2,9);
    }
    if (l_lcd == 2 && c_lcd == 8)
    {
      lcdEscreve(1,12);
    }
    if (l_lcd == 1 && c_lcd == 9)
    {
      lcdEscreve(1,10);
      nome = nome + 1;
    }
    if (l_lcd == 2 && c_lcd == 13)
    {
      lcdEscreve(" Ok?",0,0);
    }
    if (l_lcd == 2 && c_lcd == 16)
    {
      lcdEscreve("    ",2,13);
      lcdEscreve(2,12);
    }
    if (l_lcd == 2 && c_lcd == 18)
    {
      lcdLimpa();
      lcdEscreve("Rodando:",1,1);
      nome_e[8] = nome_s[8] = '.';
      lcdEscreve(nome_s,0,0);
    }
    if (l_lcd == 1 && c_lcd == 21) break;
  }
}

char teclado(byte pino)
{
  int sensor = 0;
  char tecla = 0;

  while(analogRead(pino) == 0);
  delay(100);

  for (int i = 0; i < 10; i++)
  {
    sensor = sensor + analogRead(pino);
  }
  sensor = sensor / 10;

  //key_nº e o erro são valores definidos no incio do codigo como #defines
  if (sensor < (key_1 + erro) && sensor > (key_1 - erro) ) tecla = '1';
  if (sensor < (key_2 + erro) && sensor > (key_2 - erro) ) tecla = '2';
  if (sensor < (key_3 + erro) && sensor > (key_3 - erro) ) tecla = '3';
  if (sensor < (key_4 + erro) && sensor > (key_4 - erro) ) tecla = '4';
  if (sensor < (key_5 + erro) && sensor > (key_5 - erro) ) tecla = '5';
  if (sensor < (key_6 + erro) && sensor > (key_6 - erro) ) tecla = '6';
  if (sensor < (key_7 + erro) && sensor > (key_7 - erro) ) tecla = '7';
  if (sensor < (key_8 + erro) && sensor > (key_8 - erro) ) tecla = '8';
  if (sensor < (key_9 + erro) && sensor > (key_9 - erro) ) tecla = '9';
  if (sensor < (key_10 + erro) && sensor > (key_10 - erro) ) tecla = '*';
  if (sensor < (key_11 + erro) && sensor > (key_11 - erro) ) tecla = '0';
  if (sensor < (key_12 + erro) && sensor > (key_12 - erro) ) tecla = '#'; 

  while(analogRead(pino) != 0);

  return tecla;
}

void lcdInit()
{
  delay(500); //delay pedido pelo LCD
  pinMode(txPin, OUTPUT);
  lcd.begin(2400); //baudrate de 2400 bps pro LCD
  lcd.print(0x0D, BYTE); //identificador de baudrate
  lcdContraste(0); //muda contraste
  lcdCursor(1); //liga o cursor piscando
  lcdLimpa(); //limpa display
}

void lcdEscreve(int linha, int coluna)
{
  if (linha == 0 && coluna == 0)
  {
    linha = l_lcd;
    coluna = c_lcd;
  }
  
  lcd.print(0xFE, BYTE);
  if (linha == 1) lcd.print(127 + coluna, BYTE);
  if (linha == 2) lcd.print(191 + coluna, BYTE);
  if (linha == 3) lcd.print(147 + coluna, BYTE);
  if (linha == 4) lcd.print(211 + coluna, BYTE);
  
  l_lcd = linha;
  c_lcd = coluna;
}

void lcdEscreve(char letra, int linha, int coluna)
{
  if (linha == 0 && coluna == 0)
  {
    linha = l_lcd;
    coluna  = c_lcd;
  }
  
  lcdEscreve(linha,coluna);
  
  lcd.print(letra);
  
  l_lcd = linha;
  c_lcd = coluna + 1;
}

void lcdEscreve(char texto[], int linha, int coluna)
{
  lcdEscreve(texto[0], linha, coluna);
  for (int i = 1; texto[i] != '\0'; i++)
  {
    lcdEscreve(texto[i], 0, 0);
  }
}

void lcdEscreve(long numero, int linha, int coluna)
{
  if (linha == 0 && coluna == 0)
  {
    linha = l_lcd;
    coluna  = c_lcd;
  }
  
  char buffer[10];
  ltoa (numero,buffer,10);
  lcdEscreve(buffer,linha,coluna);
}

void lcdEscreve(int numero, int linha, int coluna)
{
  lcdEscreve ((long)numero, linha, coluna);
}

void lcdLimpa() //Limpa a tela do LCD
{
lcd.print(0xFE, BYTE);
lcd.print(0x01, BYTE);
}

void lcdContraste(int valor) //O valor esperado varia de 0 a 15,sendo que 0 é o maior contraste (o valor recomendando é 0)
{
  lcd.print(0xFE, BYTE);
  lcd.print(0xFD, BYTE);
  lcd.print(valor, BYTE);
}

void lcdCursor(int estado)
{
lcd.print(0xFE, BYTE);
if (estado == 1) lcd.print(0x0D, BYTE);
if (estado == 0) lcd.print(0x0C, BYTE);
}

int pegaNumero() // IDENTIFICA SE HÁ UM NUMERO APENAS OU UM CONJUNTO DE NÚMEROS DENTRO DO ARQUIVO
{
    int numero = 0;

    while ( file_e.peek() >= '0' && file_e.peek() <= '9' )
    {
        numero = numero*10 + file_e.read() - '0'; // TRANSFORMADOR DE NÚMEROS INDIVIDUAIS EM DECIMAIS
    }
    
    while ( (file_e.peek() < '0' || file_e.peek() > '9') && file_e.available() )
    {
        file_e.read();
    }
    
    return numero;
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

void sdOpen()
{ 
  file_e = SD.open(nome_e);
  if (!file_e) Serial.println("Arquivo de entrada nao encontrado"); 
}

void sdClose()
{
  file_s.close();
  file_e.close();  
}

int sdLe()
{
  if (file_e.available())
  {
    return pegaNumero();
  }
  if (file_e.available() == 0)
  {
    return -1;
  }
}

void sdEscreve(String data) //GRAVA OS RESULTADOS FINAIS NA MATRIZ
{
  int posicao = -1;
  
  posicao = file_e.position();
  file_e.close();
   
  file_s = SD.open(nome_s, FILE_WRITE);
  if (file_s)
  {
      file_s.print(data);
      if (data != "\r\n")
      {
        file_s.print(';');
      }
      file_s.close();
  }
  else Serial.println("Nao foi possivel criar arquivo de saida");
  
  file_e = SD.open(nome_e);
  file_e.seek(posicao);
}

void sdLeMatrix()
{
  LED1 = sdLe();
  LED2 = sdLe();
  LED3 = sdLe();
  LED4 = sdLe();
}

void sdEscreveMatrix()
{
  sdEscreve( String(LED1) );
  sdEscreve( String(LED2) );
  sdEscreve( String(LED3) );
  sdEscreve( String(LED4) );
  sdEscreve( String("\r\n") );

}

