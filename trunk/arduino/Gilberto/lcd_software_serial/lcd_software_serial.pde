#include <SoftwareSerial.h>

#define txPin 2
#define rxPin 3

SoftwareSerial lcd(rxPin, txPin);
char rato[] = "000";
int c_lcd = 1; //Coluna LCD
int l_lcd = 13; //Linha LCD

void setup()
{
  Serial.begin(9600);
    
  init_lcd();
  
  posicao(1,0);
  lcd.print("Rato:        000");
  posicao(2,0);
  lcd.print("Sessao:       00");
  
  posicao(1,13);
}

void loop()
{
  char c;
  
  while(Serial.available() == 0);
  c = Serial.read();
  if(c == '*')
  {
    l_lcd = l_lcd - 1;
    posicao(c_lcd, l_lcd);
  }
  if(c == '#')
  {
    l_lcd = l_lcd + 1;
    posicao(c_lcd, l_lcd);
  }
  if(c >= '0' && c <= '9') 
  {
    l_lcd = l_lcd + 1;
    lcd.print(c);
  }
  if (l_lcd == 16 && c_lcd == 1)
  {
    l_lcd = 14;
    c_lcd = 2;
    posicao(c_lcd, l_lcd);
  }
  if (l_lcd == 13 && c_lcd == 2)
  {
    l_lcd = 15;
    c_lcd = 1;
    posicao(c_lcd, l_lcd);
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

void posicao(int coluna, int linha)
{
  delay(100);
  lcd.print(0xFE, BYTE);
  delay(100);
  if (coluna == 1)
  {
    lcd.print(128 + linha, BYTE);
  }
  if (coluna == 2)
  {
    lcd.print(192 + linha, BYTE);
  }
}

void limpa()
{
lcd.print(0xFE, BYTE);
lcd.print(0x01, BYTE);
}

void backlight(int estado)
{
  lcd.print(0xFE, BYTE);
  if (estado == LOW) lcd.print(0xFF, BYTE);
  if (estado == LOW) lcd.print(0xFE, BYTE);
}

void contraste(int valor)
{
  lcd.print(0xFE, BYTE);
  lcd.print(0xFD, BYTE);
  lcd.print(valor, BYTE);
}
