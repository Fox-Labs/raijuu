#define key_1 50
#define key_2 95
#define key_3 138
#define key_4 200
#define key_5 334
#define key_6 432
#define key_7 559
#define key_8 724
#define key_9 800
#define key_10 889
#define key_11 952
#define key_12 975

#define erro 20


int sensor;
char key;
char old_key = 0;

void setup()
{
  Serial.begin(9600); 
}

void loop()
{
  
  sensor = 0;
  for (int i = 0; i < 10; i++)
  {
    sensor = sensor + analogRead(0);
  }
  sensor = sensor / 10;
  
  Serial.print("Sensor = ");
  Serial.println(sensor);
  
  key = tecla(sensor);
  
  if ( (key != old_key) && (key != 0) )
  {
    old_key = key;
    Serial.print("Key = ");
    Serial.println(key);
  }
  
  if (key == 0)
  {
    old_key = 0;
  }
  
  delay(100);
 
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
