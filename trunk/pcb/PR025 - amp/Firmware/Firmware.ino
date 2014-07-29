// AudioPlug Plug(PORTLOW);     // uses JeePorts P1 and P2 or the T4A ExpandPlug

/*
AudioPlug Plug(PORTHIGH);  // uses JeePorts P3 and P4
Wiring Connections
- Pwr Relay - D4 Orange
- CS - D7 Blue Pin 2
- Clk - A2 Grey Pin 6
- Data - D6 Orange Pin 3
- Mute -  A3 White Pin 8
- IR - A1 Port 2
*/

#include <AudioPlug.h>
#include <Encoder.h>
#include <Wire.h>

AudioPlug Plug(PORTLOW);
Encoder encoder(2, 3);
int volume = 0;

unsigned char frequencyH = 0;
unsigned char frequencyL = 0;
unsigned int frequencyB;

double frequency = 89.1; //starting frequency

void setup()
{
	Serial.begin(57600);
	Serial.println("[AudioPlug test]");
	Plug.addBoard(TWOCHANNELS);
        Plug.setMute(MUTEOFF);
        
	Wire.begin();
	setFrequency();
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
