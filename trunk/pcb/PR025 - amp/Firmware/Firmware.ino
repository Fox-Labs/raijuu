#include <AudioPlug.h>
#include <Encoder.h>
#include <Wire.h>

AudioPlug Plug(PORTLOW);
Encoder myEnc(2, 3);

unsigned char frequencyH = 0;
unsigned char frequencyL = 0;
unsigned int frequencyB;

double frequency = 89.1; //starting frequency
double initFrequency = 89.1; //starting frequency

char c;
uint8_t Channel;
uint8_t Value;
bool getChannel = false;
bool getValue = false;
bool stereo = false;

long oldPosition  = -999;

unsigned char buffer[5];

// convert signed float in the range of [ -95,5 to + 35,5 ] to a channel Byte Value
uint8_t dB2Byte (float dBValue)
{
	if (dBValue >= 31.5)
		return 255;
	if (dBValue <= -95.5)
		return 0;
		
	return (uint8_t)(255 + (dBValue - 31.5)*2);
}

// convert a Byte Value to the corresponding dB value
float byte2dB(uint8_t Value)
{
	// calc val to dB
	return (float)(31.5 - ((255 - Value) >> 1)); 
}

void setup()
{
	Serial.begin(57600);
	Serial.println("[AudioPlug test]");
	Plug.addBoard(TWOCHANNELS);
	Plug.showChannelMap();
	Wire.begin();
	setFrequency();
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

void loop()
{
	if (Serial.available())
	{
		c = Serial.read();
		if ((c == ' ') || (c == '\n'))
			return;		

		switch(c)
		{
			case 'M':
				Value = 0;
				getValue = true;
				return;
			
			case '=':
				Value = 190;
				getValue = true;
				return;
			
			case 'm':
				while (!Serial.available());
				c = Serial.read();
				if (c == '1') 
					Plug.setMute(MUTEON);
				else 
					Plug.setMute(MUTEOFF);
				return;
			
			case 's':	
				stereo = true;

			case 'c':
				Channel = 0;
				getChannel = true;
				getValue = false;
				return;
			
			case 'v':
				Value = 0;
				getValue = true;
				getChannel = false;
				return;
			
			case '\r':
				if (getValue)
				{
					getValue = false;
					Plug.setVolume(Channel, Value);
					if (stereo)
					{
						stereo = false;
						Plug.setVolume(Channel+1, Value);
						Serial.print ("Set Stereo channel: ");
					}
					else
					{
						Serial.print ("Set Channel: ");
					}
					
					// send to plug
					Plug.sendVolumeData();
					Serial.print (Channel, DEC);
					Serial.print (" to ");
					Serial.print (byte2dB(Value));
					Serial.println (" dB");
				}
				return;
		}
		
		if (getChannel)
		{
			Channel = (Channel * 10) + c - '0';
			return;
		}
		
		if (getValue)
		{
			Value = (Value * 10) + c - '0';
			return;
		}

		long newPosition = myEnc.read();
		if (newPosition != oldPosition)
		{
			oldPosition = newPosition;
			Serial.println(newPosition);
		}
	}
}
