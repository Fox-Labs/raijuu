#include <SoftwareSerial.h>

#define txPin 2
#define rxPin 0

#define keyPin 5

SoftwareSerial lcd(rxPin, txPin);

void setup()
{
  Serial.begin(9600);
  init_lcd();
  desliga_cursor();
  lcd.print("Sensor = ");
}

void loop()
{  
    int sensor = 0;
    for (int i = 0; i < 10; i++)
    {
      sensor = sensor + analogRead(keyPin);
    }
    sensor = sensor / 10;
  
    Serial.print("Sensor = ");
    Serial.println(sensor);
    
    if(sensor == 0)
    {
      lcd.print(0);
      lcd.print(0);
      lcd.print(0);
    }
    if(sensor > 0 && sensor < 10)
    {
      lcd.print(0);
      lcd.print(0);
      lcd.print(sensor);
    }
    if(sensor >= 10 && sensor < 100)
    {
      lcd.print(0);
      lcd.print(sensor);
    }
    if(sensor >= 100)
    {
      lcd.print(sensor);
    }
    posicao(1,9);
    
    delay(300);
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

void limpa()
{
lcd.print(0xFE, BYTE);
lcd.print(0x01, BYTE);
}

void desliga_cursor()
{
lcd.print(0xFE, BYTE);
lcd.print(0x0C, BYTE);
}

void contraste(int valor)
{
  lcd.print(0xFE, BYTE);
  lcd.print(0xFD, BYTE);
  lcd.print(valor, BYTE);
}

void posicao(int linha, int coluna)
{
  lcd.print(0xFE, BYTE);
  if (linha == 1){lcd.print(128 + coluna, BYTE);}
  if (linha == 2){lcd.print(192 + coluna, BYTE);}
  if (linha == 3){lcd.print(148 + coluna, BYTE);}
  if (linha == 4){lcd.print(212 + coluna, BYTE);}
}
