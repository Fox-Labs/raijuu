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
int c_lcd; //Coluna LCD
int l_lcd; //Linha LCD
int nome = 1;

char nome_e[] = "M0000000.csv";
char nome_s[] = "R0000000.csv";

int linha = 0;

File file_e;

void setup()
{
  Serial.begin(9600);

  init_lcd();
  lcd_menu();
}

void loop()
{
  linha++;
  escreve_lcd("Linha: ",2,0);
  escreve_lcd(linha,2,8);
  //posicao(2,0);
  //lcd.print("Linha:  ");
  //lcd.print(linha);
  
  escreve_sd(file_e, String (LED) );
  escreve_sd(file_e, String (REF) );
  escreve_sd(file_e, String (DELAY) );
  escreve_sd(file_e, String (REF2) );
  escreve_sd(file_e, String (DELAY2) );
  escreve_sd(file_e, String ("\r\n") );
  
  delay(100);
}


void lcd_menu()
{
  char key;
  char old_key = 0;
  
  posicao(1,0);
  lcd.print("Rato:    000");
  posicao(2,0);
  lcd.print("Sessao: 0000");
  
  c_lcd = 9;
  l_lcd = 1; 
  posicao(l_lcd,c_lcd);
  
  while(true)
  {
    
    key = teclado (keyPin);
    
    if(key == '*')
    {
      c_lcd = c_lcd - 1;
      posicao(l_lcd, c_lcd);
      nome = nome - 1;
    }
    if(key == '#')
    {
      c_lcd = c_lcd + 1;
      posicao(l_lcd, c_lcd);
      nome = nome + 1;
    }
    if(key >= '0' && key <= '9') 
    {
      c_lcd = c_lcd + 1;
      lcd.print(key);
      nome_e[nome] = key; 
      nome_s[nome] = key;
      nome = nome + 1;
    }
    if (c_lcd == 12 && l_lcd == 1)
    {
      c_lcd = 8;
      l_lcd = 2;
      posicao(l_lcd, c_lcd);
    }
    if (c_lcd == 7 && l_lcd == 2)
    {
      c_lcd = 11;
      l_lcd = 1;
      posicao(l_lcd, c_lcd);
    }
    if (c_lcd == 8 && l_lcd == 1)
    {
      c_lcd = 9;
      l_lcd = 1;
      posicao(l_lcd, c_lcd);
      nome = nome + 1;
    }
    if (c_lcd == 12 && l_lcd == 2)
    {
      lcd.print(" Ok?");
      l_lcd = 2;
      c_lcd = 16;
      posicao(l_lcd, c_lcd);
    }
    if (c_lcd == 15 && l_lcd == 2)
    {
      posicao(2,13);
      lcd.print("   ");
      c_lcd = 11;
      l_lcd = 2;
      posicao(l_lcd,c_lcd);
    }
  
    if (c_lcd == 17 && l_lcd == 2)
    {
      limpa();
      lcd.print("Rodando:");
      lcd.print(nome_e);
    }
    
    if (c_lcd == 17 && l_lcd == 2) break;
    
    key = 0;
    delay(100);
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

void init_lcd()
{
  delay(500); //delay pedido pelo LCD
  pinMode(txPin, OUTPUT);
  lcd.begin(2400); //baudrate de 2400 bps pro LCD
  lcd.print(0x0D, BYTE); //identificador de baudrate
  contraste(0); //muda contraste
  controla_cursor(1); //liga o cursor piscando
  limpa(); //limpa display
}

void posicao(int linha, int coluna)
{
  lcd.print(0xFE, BYTE);
  if (linha == 1)
  {
    lcd.print(128 + coluna, BYTE);
  }
  if (linha == 2)
  {
    lcd.print(192 + coluna, BYTE);
  }
  if (linha == 3)
  {
    lcd.print(148 + coluna, BYTE);
  }
  if (linha == 4)
  {
    lcd.print(212 + coluna, BYTE);
  }
}

//strcat(crypted_aux,(char *) &aux1);

void escreve_lcd(char* texto,byte linha, byte coluna)
{
  lcd.print(0xFE, BYTE);
  if (linha == 1) lcd.print(128 + coluna, BYTE);
  if (linha == 2) lcd.print(192 + coluna, BYTE);
  if (linha == 3) lcd.print(148 + coluna, BYTE);
  if (linha == 4) lcd.print(212 + coluna, BYTE);
  lcd.print(texto);
}

void escreve_lcd(int texto,byte linha, byte coluna)
{
  char buffer[10];
  itoa (texto,buffer,10);
  escreve_lcd(buffer,linha,coluna);
}

void limpa() //Limpa a tela do LCD
{
lcd.print(0xFE, BYTE);
lcd.print(0x01, BYTE);
}

void contraste(int valor) //O valor esperado varia de 0 a 15,sendo que 0 é o maior contraste (o valor recomendando é 0)
{
  lcd.print(0xFE, BYTE);
  lcd.print(0xFD, BYTE);
  lcd.print(valor, BYTE);
}

void controla_cursor(int estado)
{
lcd.print(0xFE, BYTE);
if (estado == 1) lcd.print(0x0D, BYTE);
if (estado == 0) lcd.print(0x0C, BYTE);
}

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

int pega_numero(File file) // IDENTIFICA SE HÁ UM NUMERO APENAS OU UM CONJUNTO DE NÚMEROS DENTRO DO ARQUIVO
{
    int i = 0;

    while ( file.peek() >= '0' && file.peek() <= '9' )
    {
        i = i*10 + file.read() - '0'; // TRANSFORMADOR DE NÚMEROS INDIVIDUAIS EM DECIMAIS
    }
    
    while ( (file.peek() < '0' || file.peek() > '9') && file.available() )
    {
        file.read();
    }
    
    return i;
}

void sdInit()
{
  pinMode(10, OUTPUT);
  if (!SD.begin(8))
  {
      Serial.println("Erro ao iniciar cartao SD");
      return;
  }
  file_e = SD.open(nome_e);
  if (!file_e) Serial.println("Arquivo de entrada nao encontrado");
}

int sdLe()
{
  if (file_e.available() > 0)
  {
    //Colocar aqui lista de variaveis
    variavel_1 = pega_numero(file_e);// números inteiros, NECESSARIAMENTE
    variavel_2 = pega_numero(file_e);
  }
  if (file_e.available() == 0)
  {
    return -1;
  }
}

void sdEscreve(String data) //GRAVA OS RESULTADOS FINAIS NA MATRIZ
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
