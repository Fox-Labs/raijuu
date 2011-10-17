char rato[] = "000";
int c_lcd = 1; //Coluna LCD
int l_lcd = 13; //Linha LCD

void setup()
{
  Serial.begin(9600);
    
  init_lcd();
  
  posicao(1,0);
  Serial.print("Rato:        000");
  posicao(2,0);
  Serial.print("Sessao:       00");
  
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
    Serial.print(c);
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
  Serial.print(0x0D, BYTE); //identificador de baudrate
  delay(100);
  contraste(0); //muda contraste
  delay(100);
  limpa(); //limpa display
}

void posicao(int coluna, int linha)
{
  delay(100);
  Serial.print(0xFE, BYTE);
  delay(100);
  if (coluna == 1)
  {
    Serial.print(128 + linha, BYTE);
  }
  if (coluna == 2)
  {
    Serial.print(192 + linha, BYTE);
  }
}

void limpa()
{
Serial.print(0xFE, BYTE);
Serial.print(0x01, BYTE);
}

void backlight(int estado)
{
  Serial.print(0xFE, BYTE);
  if (estado == LOW) Serial.print(0xFF, BYTE);
  if (estado == LOW) Serial.print(0xFE, BYTE);
}

void contraste(int valor)
{
  Serial.print(0xFE, BYTE);
  Serial.print(0xFD, BYTE);
  Serial.print(valor, BYTE);
}
