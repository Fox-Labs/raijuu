#define motor 3

int data[3];
int total;

void setup()
{
  Serial.begin(9600);
  pinMode(motor, OUTPUT);

}

void loop()
{
  if (Serial.available() >= 3) {

    for (int i=0; i<3; i++) {
      data[i] = Serial.read() - '0';
    }
    
    total = data[0] * 100 + data[1] * 10 + data[2];
    
    Serial.print("total = ");
    Serial.println(total);
      
    analogWrite(motor, total);
  }
}

