#define Idle 0
#define ReveiveCOM 1
#define Action 2

#define Waiting 0
#define Decoding 1
#define Process 2

#define Time ICR1

#define StopTimer  {TCCR1B = 0;}
#define CleanTimer {TCNT1 = 0;}
#define TriggerEgde_High { TCCR1B=0xC5; u8_trgger=1;}
#define TriggerEgde_Low  { TCCR1B=0x85; u8_trgger=0;}

#define SetBit {u8_DataArray[u8_site]=0; u8_site++; if(u8_site>=255) u8_catchend=1;}
#define CleanBit {u8_DataArray[u8_site]=1; u8_site++; if(u8_site>=255) u8_catchend=1;}
