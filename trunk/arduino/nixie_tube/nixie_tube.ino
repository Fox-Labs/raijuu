//#include <stdio.h>
//#include <avr/io.h>
#include <avr/interrupt.h>
//#include <util/delay_basic.h>

#define pinPWM 9

void setup()
{
  Serial.begin(9600);
  pinMode(pinPWM, OUTPUT);
  
  initPWM();
  OCR1A = 0;
}

float vol;

/*void loop()
{
  delay(500);
  vol = analogRead(A1);
  vol = vol * 345 / 1024;
  if (vol < 170) OCR1A++;
  if (vol > 190) OCR1A--;
  
  Serial.print("pwm = ");
  Serial.println(OCR1A);
  Serial.print("vol = ");
  Serial.println(vol);
  Serial.println("");
  
  if (vol > 200 || OCR1A > 100)
  {
    Serial.print("ESTOUROU");
    OCR1A = 0;
    while(HIGH);
  }
}*/
  
void loop()
{
  int total;
  int data[3];
  float vol;
  
  if (Serial.available() >= 3) {

    for (int i=0; i<3; i++) {
      data[i] = Serial.read() - '0';
    }
    
    total = data[0] * 100 + data[1] * 10 + data[2];
    
    Serial.print("pwm = ");
    Serial.println(total);
    OCR1A = total;
    
    
    Serial.print("adc = ");
    Serial.println( analogRead(A1));
    Serial.print("vol = ");
    vol = analogRead(A1);
    vol = vol * 345/1024;
    Serial.println(vol);
    Serial.println("");
  }
}

void initPWM()
{
   OCR1A = 0;
   //timer 1 - 8 bit Fast PWM - divided by 1024 - non-inverting
   
   //Cristal 16MHz / 1 / 256 = 62,5 KHz
   //  (0 << CS12) | (0 << CS11) | (1 << CS10)
   TCCR1B = (0 << WGM13) | (1<<WGM12) | (0 << CS12) | (0 << CS11) | (1 << CS10);
   TCCR1A = (0 << WGM11) | (1<<WGM10) | (1 << COM1A1) | (0 << COM1A0);
}
