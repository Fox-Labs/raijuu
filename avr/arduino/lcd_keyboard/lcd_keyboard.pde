#include <SoftwareSerial.h>

#define txPin 2
#define rxPin 0

#define keyPin 0

#define key_1 48
#define key_2 86
#define key_3 128
#define key_4 196
#define key_5 308
#define key_6 410
#define key_7 535
#define key_8 686
#define key_9 778
#define key_10 845
#define key_11 922
#define key_12 952

#define erro 15

SoftwareSerial lcd(rxPin, txPin);
int c_lcd; //Coluna LCD
int l_lcd; //Linha LCD
int nome = 1;

char nome_e[] = "M0000000.csv";
char nome_s[] = "R0000000.csv";

int linha = 0;

void setup()
{
  Serial.begin(9600);

  init_lcd();
  lcd_menu();
}

void loop()
{
  linha++;
  lcd_linha(linha);
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
    
    if(analogRead(0) == 0)
    {
      old_key = 0;
    }
    
    if(analogRead(0) != 0)
    {
      delay(100);
    
      int sensor = 0;
      for (int i = 0; i < 10; i++)
      {
        sensor = sensor + analogRead(0);
      }
      sensor = sensor / 10;
  
      key = tecla(sensor);
  
      if ( (key != old_key) && (key != 0) )
      {
        old_key = key;
      
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
        
        while(analogRead(0) != 0);
        
      }
    
    }
    
    if (c_lcd == 17 && l_lcd == 2) break;
    
    delay(100);
  }
}

void init_lcd()
{
  delay(500); //delay pedido pelo LCD
  pinMode(txPin, OUTPUT);
  lcd.begin(2400);
  lcd.print(0x0D, BYTE); //identificador de baudrate
  delay(100);
  contraste(0); //muda contraste
  delay(100);
  limpa(); //limpa display
}

void lcd_linha(int linha)
{
  posicao(2,0);
  lcd.print("Linha:  ");
  lcd.print(linha);
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
}

void limpa()
{
lcd.print(0xFE, BYTE);
lcd.print(0x01, BYTE);
}

void contraste(int valor)
{
  lcd.print(0xFE, BYTE);
  lcd.print(0xFD, BYTE);
  lcd.print(valor, BYTE);
}

char tecla(int sensor)
{
  if (sensor < (key_1 + erro) && sensor > (key_1 - erro) ) return '1';
  if (sensor < (key_2 + erro) && sensor > (key_2 - erro) ) return '2';
  if (sensor < (key_3 + erro) && sensor > (key_3 - erro) ) return '3';
  if (sensor < (key_4 + erro) && sensor > (key_4 - erro) ) return '4';
  if (sensor < (key_5 + erro) && sensor > (key_5 - erro) ) return '5';
  if (sensor < (key_6 + erro) && sensor > (key_6 - erro) ) return '6';
  if (sensor < (key_7 + erro) && sensor > (key_7 - erro) ) return '7';
  if (sensor < (key_8 + erro) && sensor > (key_8 - erro) ) return '8';
  if (sensor < (key_9 + erro) && sensor > (key_9 - erro) ) return '9';
  if (sensor < (key_10 + erro) && sensor > (key_10 - erro) ) return '*';
  if (sensor < (key_11 + erro) && sensor > (key_11 - erro) ) return '0';
  if (sensor < (key_12 + erro) && sensor > (key_12 - erro) ) return '#';
  return 0;
}
