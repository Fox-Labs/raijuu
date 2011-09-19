#define key_1 48
#define key_2 75
#define key_3 128
#define key_4 190
#define key_5 295
#define key_6 386
#define key_7 490
#define key_8 611
#define key_9 710
#define key_10 747
#define key_11 786
#define key_12 860

#define erro 10


long sensor;
char key;
char old_key = 0;

void setup()
{
  Serial.begin(9600); 
}

void loop()
{
  if(analogRead(0) == 0)
  {
    old_key = 0;
  }
  
  if(analogRead(0) != 0)
  {
    delay(100);
    
    sensor = 0;
    for (int i = 0; i < 50; i++)
    {
      sensor = sensor + analogRead(0);
    }
    sensor = sensor / 50;
  
    Serial.print("Sensor = ");
    Serial.println(sensor);
  
    key = tecla(sensor);
  
    if ( (key != old_key) && (key != 0) )
    {
      old_key = key;
      Serial.print("Key = ");
      Serial.println(key);
      while(analogRead(0) != 0);
    }
    
  }
 
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
