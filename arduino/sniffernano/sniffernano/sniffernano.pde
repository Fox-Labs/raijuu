/******************** Sniffer Nano *************************
This is the first vesion source code of Sniffer Nano.It' basic 
on the source code that written by Rainbow Chen.
It implements the use of a microcontroller to read the RFID Tag
and output the card ID .
                                  iteadstudio.com  7/30/2010
************************************************************/

#include "EEPROM.h"
#include "RFID.h"

unsigned char u8_state=0;
unsigned char u8_site=0;
unsigned char u8_catchend=0;
unsigned char u8_trgger=1;
unsigned char u8_DataArray[256];
unsigned char u8_FirstTime=0;
unsigned char u8_Comstate=0;
unsigned char u8_value;
unsigned long u64_rfid = 0; 
unsigned char u8_command[5];
unsigned char p=0;
  
ISR(TIMER1_CAPT_vect) 
{
    StopTimer
    CleanTimer
  if(u8_state==Waiting)
  {
    if(Time>1000)//500
    {
      //Serial.println();
      //Serial.print("S");
      u8_site = 0;
      u8_FirstTime=1;
    }

    if(u8_catchend==0)
    {
      if(u8_trgger==1)
      {
        SetBit
        if(Time>=6)//3
        {
          SetBit
          //Serial.print("1");
        }
        TriggerEgde_Low
      }
      else 
      {
        CleanBit
        if(Time>=6)//3
        {
          CleanBit
          //Serial.print("0");
        }
        TriggerEgde_High
      }
    }
  }  
}

void setup()
{
  InitialSystem();
  InitialTimer();
  Serial.println("Sniffer Nano F/W v1.0");
}

void loop()
{   
  
  switch(u8_state)
  {
  case Waiting:
    if(u8_catchend==1) 
    {
      u8_catchend=0;
      if(u8_FirstTime==1)
      {
        u8_state=Decoding;
      }
    }
    switch(u8_Comstate)
    {
    case Idle:
      if(Serial.available()>0)  u8_Comstate=ReveiveCOM;
      break;

    case ReveiveCOM:
      u8_command[p]=Serial.read();
      if((p==0)&&(u8_command[p]=='A')) {
        p++;
        u8_Comstate=Idle;
      }              
      else if((p==1)&&(u8_command[p]=='T')) {
        p++;
        u8_Comstate=Idle;
      }  
      else if((p==2)&&(u8_command[p]=='+')) {
        p++;
        u8_Comstate=Idle;
      }
      else if((p==3)&&(u8_command[p]=='B')) {
        p++;
        u8_Comstate=Idle;
      }
      else if(p==4) {
        u8_Comstate=Action;  
      }
      else { 
        p=0 ; 
        u8_Comstate=Idle;
      }          
      break;

    case Action:
      u8_value=u8_command[4];
      if(u8_value<0x03)  
      {                    
       EEPROM.write(0, u8_value); 
       Serial.print("OK");                 
      }
      else
      {
        EEPROM.write(0, 0x04); 
        Serial.print("ERROR");   
      }             
      p=0;
      u8_Comstate=Idle;
      break;

    default:
      u8_Comstate=Idle;
      p=0;
      break;
    }       
    break;

  case Decoding:
    decode();
    break;

  case Process:
    OutputData();
    u8_FirstTime=0;
    break;


  default:
    u8_state=0;
    break;
  }

}


void decode(void)
{ 
  unsigned char i,j,k;
  unsigned char temp = 0;
  unsigned char start_data[21]={
    1,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1    };
  unsigned char row_parity = 0; 
  unsigned char id_code[11] = {
    0,0,0,0,0,0,0,0,0,0,0    }; 

  for(i=0;i<200;i++)
  {
    for(j=0;j<20;j++)
    {        
      if(u8_DataArray[i+j]!=start_data[j])
      {           
        break;
      }
    }
    if(j==20)
    {
      i += 20; 
      for(k = 0;k < 11;k++)
      {
        row_parity = 0; 
        temp = 0;
        for(j=0;j<5;j++)
        {
          temp <<= 1; 
          if((u8_DataArray[i] == 0) && (u8_DataArray[i+1] == 1)) 
          { 
            temp |= 0x01; 
            if(j < 4)  row_parity += 1; 
          }
          else if((u8_DataArray[i] == 1) && (u8_DataArray[i+1] == 0)) 
          temp &= 0xfe;
          else {
            u8_state=Waiting;
            u8_site=0;
            return;
          } 
          i+=2;
        }
        id_code[k] = (temp >> 1); 
        temp &= 0x01; 
        row_parity %= 2; 
        if(k<10)
        {
          if(row_parity != temp)  {
            u8_state=Waiting;
            u8_site=0;
            return;
          } 
        }
        else
        {
          if(temp!=0)  {
            u8_state=Waiting;
            u8_site=0;     
            return;
          } 
        }
      } 
      if (k==11)
      {
        for(j = 2;j < 10;j++) 
        { 
          u64_rfid += (((unsigned long)(id_code[j])) << (4 * (9 - j))); 
        }
        u8_state=Process;   
        return;
      }
    }
  }
  u8_state=Waiting;
  u8_site=0;  
}


void OutputData(void)
{
  digitalWrite(2,LOW);
  Serial.println(u64_rfid);
  u8_FirstTime=0;
  u64_rfid=0;
  u8_site=0;
  u8_state=Waiting;
  digitalWrite(2,HIGH);
}

void InitialSystem(void)
{
  pinMode(2,OUTPUT);
  digitalWrite(2,HIGH);
  u8_value=EEPROM.read(0);

  if(u8_value==0x03) Serial.begin(4800);
  else if(u8_value==0x04) Serial.begin(9600);
  else if(u8_value==0x05) Serial.begin(115200);
  else Serial.begin(9600);    
  
}

void InitialTimer(void)
{
  DDRD=0;
  DDRD|=0x20;

  TCCR0A = 0x12;
  TIMSK0 = 0x00;
  //OCR0B = 0x03;
  //OCR0A = 0x03;
  OCR0B = 0x07;
  OCR0A = 0x07;
  TCNT0=0;

  TCCR1B = 0x00; 
  TIMSK1|= 0x20;
  TCNT1H = 0x0FF; 
  TCNT1L = 0xF8; 
  TCCR1A = 0x00;

  ACSR|=0x04;

  TCCR1B = 0xC5; 
  TCCR0B = 0x02; 
}

