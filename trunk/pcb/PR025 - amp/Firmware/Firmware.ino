#define CLK_PIN  4
#define DATA_PIN 5
#define MUTE_PIN 6
#define CS_PIN   7
#define CS_DISPLAY_PIN 12

#include <AudioPlug.h>
#include <Encoder.h>
#include <Wire.h>
#include <LiquidCrystal.h>

AudioPlug Plug(PORTLOW);
Encoder encoder(2, 3);
LiquidCrystal lcd(DATA_PIN, CLK_PIN, CS_DISPLAY_PIN);
int volume = 0;

unsigned char frequencyH = 0;
unsigned char frequencyL = 0;
unsigned int frequencyB;

double frequency = 89.1; //starting frequency

void setup()
{
	Serial.begin(9600);
	Plug.addBoard(TWOCHANNELS);
        Plug.setMute(MUTEOFF);
        
	Wire.begin();
	setFrequency();

        lcd.begin(16, 2);
        
        lcd.setCursor(0, 0);
        lcd.print("PRE-AMP");
}

void loop()
{
	//Plug.setMute(MUTEON);
	//Plug.setMute(MUTEOFF);
		
	Plug.setVolume(0, volume);
	Plug.setVolume(1, volume);

	// send to plug
	Plug.sendVolumeData();

	volume = encoder.read();
	if (volume > 255)
	{
	  volume = 255;
	  encoder.write(255);
	}
	if (volume < 0)
	{
	  volume = 0;
	  encoder.write(0);
	}
	Serial.println(volume);

        lcd.setCursor(0, 1);
        lcd.print("VOL: ");
        lcd.print(volume);
        
        delay(100);
}

void setFrequency()
{
  frequencyB = 4 * (frequency * 1000000 + 225000) / 32768;
  frequencyH = frequencyB >> 8;
  frequencyL = frequencyB & 0XFF;
  delay(200);
  Wire.beginTransmission(0x60);
  Wire.write(frequencyH);
  Wire.write(frequencyL);
  Wire.write(0xB0);
  Wire.write(0x10);
  Wire.write(0x00);
  Wire.endTransmission();
  delay(100);  
}
