#include <SD.h>

const int chipSelect = 8;

void setup()
{
    Serial.begin(9600);
    Serial.print("Iniciando cartao SD...");
    pinMode(10, OUTPUT);
  

    if (!SD.begin(chipSelect)) {
        Serial.println("Erro");
        return;
    }
    Serial.println("OK");
}

void loop()
{
    int menu;
    
    Serial.print("\n\n");
    Serial.println("Deseja:");
    Serial.println("1 - gravar");
    Serial.println("2 - ler");
    Serial.println("3 - remover");
    
    while (!Serial.available());
    menu = Serial.read();

    if (menu == '1') //Rotina de gravação do SD
    {
        File dataFile = SD.open("datalog.txt", FILE_WRITE);
    
        if(dataFile)
        {
            dataFile.println("Num, Temp");
    
            for (int i = 0; i < 50; i++)
            { 
                delay(1000);
                float sensor = (5.0 * analogRead(A0) * 100.0)/1024.0;
        
                Serial.println(i);
                dataFile.print(i);
                dataFile.print(" ,");
                dataFile.println(sensor, 2);
            }
        } 
        else
        {
            Serial.println("error opening datalog.txt");
        } 
    
        dataFile.close();
        Serial.println("done");
    }
    
    if(menu == '2')
    {
        File dataFile = SD.open("datalog.txt");

        if (dataFile)
        {
            while (dataFile.available())
            {
                Serial.write(dataFile.read());
            }
            dataFile.close();
        }
    }
    
    if(menu == '3')
    {
       if(SD.remove("datalog.txt") == 1)
       {
            Serial.println("removido");
       }
       else
       {
            Serial.println("erro");
       }
    }
}

