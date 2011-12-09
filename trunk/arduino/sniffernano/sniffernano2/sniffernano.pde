/******************* Sniffer Nano *************************
This is the first vesion source code of Sniffer Nano.It' basic 
on the source code that written by Rainbow Chen.
It implements the use of a microcontroller to read the RFID Tag
and output the card ID.
                                  iteadstudio.com  7/30/2010

* Cleaned up the code a bit
* Corrected some spelling.
* Converted to using a bit array to save 7/8 of the RAM. 
           Flemming Frandsen <http://dren.dk/> 15 August 2010

************************************************************/

#include "EEPROM.h"

unsigned char catchend=0;
unsigned char trigger=1;
unsigned char firstTime=0;
unsigned char value;
unsigned long rfid = 0; 
unsigned char command[5];
unsigned char p=0;


unsigned char comState=0;
#define COM_IDLE 0
#define COM_REC 1
#define COM_ACTION 2

unsigned char state=0;
#define STATE_WAITING 0
#define STATE_DECODING 1
#define STATE_PROCESS 2

unsigned char dataArrayInUse=0;
unsigned char dataArray[256/8];
#define PUSH_ONE  { dataArray[dataArrayInUse>>3] |=   1<<(dataArrayInUse & 7);   if (dataArrayInUse>=255) {catchend=1;Serial.println("Catched");}  }
#define PUSH_ZERO { dataArray[dataArrayInUse>>3] &= ~(1<<(dataArrayInUse & 7)) ; if (dataArrayInUse>=255) {catchend=1;Serial.println("Catched");}  }
#define GET_BIT(x)  (dataArray[(x)>>3] &= 1<<((x) & 7))   


// This interrupt is fired on either rising or falling edge of the analog comparator output
// The value of the TCNT1 register at the time of the edge is captured in the ICR1 register.
ISR(TIMER1_CAPT_vect) {
  TCCR1B = 0; // Stop timer while we work.
  TCNT1 = 0;  // Reset counter to 0
  if (state==STATE_WAITING) {
    if (ICR1>1000) {
      dataArrayInUse = 0;
      firstTime=1;
    } 
    
    if (!catchend) {
      if (trigger) { // Not sure if this is needed, can there be two rising edges in a row? Perhaps leftovers from PCINT?
        PUSH_ONE;
	if (ICR1>=6) {
	  PUSH_ONE; 
	}	
	TCCR1B=0x85; // Falling edge triggered + Input capture noice canceler=on + clock=clkio/1024 
	trigger=0;
      } 
      else {
        PUSH_ZERO;
	if (ICR1>=6) {
          PUSH_ZERO;
        }
	TCCR1B=0xC5; // Rising edge triggered + Input capture noice canceler=on + clock=clkio/1024 
	trigger=1;
      }
    }
  }
}

void setup() {
  setupSystem();
  setupTimer();
  Serial.println("Sniffer Nano F/W v1.1");
}

void loop() {   
  
  switch(state) {
    case STATE_WAITING:
      if (catchend) {
        Serial.println("Trying to decode...");
	catchend=0;
	if (firstTime) {
	  state=STATE_DECODING;
	}
      }
      
      switch(comState) {
        case COM_IDLE:
	  if (Serial.available()>0)  comState=COM_REC;
	  break;

        case COM_REC:
	  command[p]=Serial.read();
	  if ((p==0)&&(command[p]=='A')) {
	    p++;
	    comState=COM_IDLE;

	  } else if ((p==1)&&(command[p]=='T')) {
	    p++;
	    comState=COM_IDLE;

	  } else if ((p==2)&&(command[p]=='+')) {
	    p++;
	    comState=COM_IDLE;

	  } else if ((p==3)&&(command[p]=='B')) {
	    p++;
	    comState=COM_IDLE;

	  } else if (p==4) {
	    comState=COM_ACTION;  

	  } else { 
	    p=0 ; 
	    comState=COM_IDLE;
	  }          
	  break;

        case COM_ACTION:
	  value=command[4];
	  if (value<0x03) {                    
	    EEPROM.write(0, value); 
	    Serial.print("OK");                 
	  } else {
	    EEPROM.write(0, 0x04); 
	    Serial.print("ERROR");   
	  }
	  p=0;
	  comState=COM_IDLE;
	  break;

        default:
	  comState=COM_IDLE;
	  p=0;
	  break;
      }       
      break;

    case STATE_DECODING:
      decode();
      break;

    case STATE_PROCESS:
      OutputData();
      firstTime=0;
      break;

    default:
      state=0;
      break;
  }
}


void decode(void) {
  unsigned char start_data[21] = { 1,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1 };
  unsigned char id_code[11]    = { 0,0,0,0,0,0,0,0,0,0,0 }; 

  unsigned char j=0,i=0;
  
  Serial.println("Decoding...");
  for (unsigned char i=0;i<200;i++) {
    for (j=0;j<20;j++) {        
      if ((GET_BIT(i+j)?1:0) != start_data[j])            
        break;
      }
    }

    if (j==20) {
      i += 20; 
      for (unsigned char k = 0;k < 11;k++) {
        unsigned char row_parity = 0; 
        unsigned char temp = 0;
        for (unsigned char foo=0; foo<5; foo++) {
          temp <<= 1; 
          if ((!GET_BIT(i)) && GET_BIT(i+1)) { 
            temp |= 0x01; 
            if (foo < 4) {
	      row_parity += 1; 
	    }

          } else if (GET_BIT(i) && !GET_BIT(i+1)) {
	    temp &= 0xfe;

	  } else {
            state=STATE_WAITING;
            dataArrayInUse=0;
            return;
          } 
          i+=2;
        }

        id_code[k] = (temp >> 1); 
        temp &= 0x01; 
        row_parity %= 2; 

        if (k<10) {
          if (row_parity != temp) {
            state=STATE_WAITING;
            dataArrayInUse=0;
            return;
          } 

        } else {
          if (temp!=0)  {
            state=STATE_WAITING;
            dataArrayInUse=0;     
            return;
          } 
        }
      } 

      for (unsigned char foo = 2;foo < 10;j++) { 
	rfid += (((unsigned long)(id_code[foo])) << (4 * (9 - foo))); 
      }
      state=STATE_PROCESS;   
      return;      
    }

  state=STATE_WAITING;
  dataArrayInUse=0;  
}


void OutputData(void) {
  digitalWrite(2,LOW);
  Serial.println(rfid);
  firstTime=0;
  rfid=0;
  dataArrayInUse=0;
  state=STATE_WAITING;
  digitalWrite(2,HIGH);
}

void setupSystem(void) {
  pinMode(2,OUTPUT);
  digitalWrite(2,HIGH);
  value=EEPROM.read(0);

  if (value==0x03) Serial.begin(4800);
  else if (value==0x04) Serial.begin(9600);
  else if (value==0x05) Serial.begin(115200);
  else Serial.begin(9600);
}

void setupTimer(void) {
  DDRD=0;
  DDRD|=0x20; // 0b0010.0000 //PD5 is output

  TCCR0A = 0x12;
  // TCCR0A = (0<<COM0A1)|(0<<COM0A0)|(0<<COM0B1)|(1<<COM0B0) | (1<<WGM01)|(0<<WGM00);
  // OC0A disconnected , Toggle OC0B on Compare Match, non-PWM Mode
  // CTC mode, top on OCRA
  TIMSK0 = 0x00;
  // TIMSKO = (0<<OCIE0B)|(0<<OCIE0A)|(0<<TOIE0);
  // Disable interrupts
  //OCR0B = 0x03;
  OCR0B = 0x07;
  // Top timer0B on 3
  //OCR0A = 0x03;
  OCR0A = 0x07;
  // Top timer0A on 3
  TCNT0 = 0;
  // Reseting the timer counter

  TCCR1A = 0x00;
  // TCCR1B = (0<<COM1A1)|(0<<COM1A0)|(0<<COM1B1)|(0<<COM1B0) | (0<<WGM11)|(0<<WGM10);
  TCCR1B = 0x00;
  // TCCR1B = (0<<ICNC1)|(0<<ICES1) | (0<<WGM13)|(0<<WGM12) | (0<<CS12)|(0<<CS11)|(0<<CS10);
  //OC1A and OC1B disconnected
  
  TIMSK1|= 0x20;
  // TIMSK1 |= (1<<ICIE1) | (0<<OCIE1B)|(0<<OCIE1A) | (0<<TOIE1);
  // Interrupt on Timer1 enable
  
  TCNT1H = 0x0FF;
  TCNT1L = 0xF8;
  // Counter for Timer1 = FFF8

  ACSR |= 0x04;
  // ACSR |= (1<<ACIC);
  // Analog Comparator Input Capture Enable

  TCCR1B = 0xC5;
  // TCCR1B = (1<<ICNC1)|(1<<ICES1) | (0<<WGM13)|(0<<WGM12) | (1<<CS12)|(0<<CS11)|(1<<CS10);
  // clk/1024 (From prescaler)
  TCCR0B = 0x02;
  // TCCR0B = (0<<WGM02) | (0<<CS02)|(1<<CS01)|(0<<CS00);
  // clk/8 (From prescaler)
}
