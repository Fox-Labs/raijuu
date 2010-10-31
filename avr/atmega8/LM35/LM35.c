#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay_basic.h>


#define SEVEN_SEGMENT_PORT PORTD
#define SEVEN_SEGMENT_DDR DDRD

uint8_t digits[3];	//Holds the digits for 3 displays
				

void SevenSegment(uint8_t n,uint8_t dp)
{
/*
This function writes a digits given by n to the display
the decimal point is displayed if dp=1

Note:
n must be less than 9
*/
	if(n<10)
	{
		switch (n)
		{
			case 0:
			SEVEN_SEGMENT_PORT=0b00000011;
			break;

			case 1:
			SEVEN_SEGMENT_PORT=0b10011111;
			break;

			case 2:
			SEVEN_SEGMENT_PORT=0b00100101;
			break;

			case 3:
			SEVEN_SEGMENT_PORT=0b00001101;
			break;

			case 4:
			SEVEN_SEGMENT_PORT=0b10011001;
			break;

			case 5:
			SEVEN_SEGMENT_PORT=0b01001001;
			break;

			case 6:
			SEVEN_SEGMENT_PORT=0b01000001;
			break;

			case 7:
			SEVEN_SEGMENT_PORT=0b00011111;
			break;

			case 8:
			SEVEN_SEGMENT_PORT=0b00000001;
			break;

			case 9:
			SEVEN_SEGMENT_PORT=0b00001001;
			break;
		}
		if(dp)
		{
			//if decimal point should be displayed
			//make 0th bit Low
			SEVEN_SEGMENT_PORT&=0b11111110;
		}
	}
	else
	{
		//This symbol on display tells that n was greater than 9
		//so display can't handle it
		SEVEN_SEGMENT_PORT=0b11111101;
	}
}

void Wait()
{
	uint8_t i;
	for(i=0;i<10;i++)
	{
		_delay_loop_2(0);
	}
}

void Print(uint16_t num)
{
	uint8_t i=0;
	uint8_t j;
	if(num>999) return;


	while(num)
	{
		digits[i]=num%10;
		i++;

		num=num/10;
	}
	for(j=i;j<3;j++) digits[j]=0;
}

void InitADC()
{
ADMUX=(1<<REFS0);// For Aref=AVcc;
ADCSRA=(1<<ADEN)|(7<<ADPS0);
}

uint16_t ReadADC(uint8_t ch)
{
	//Select ADC Channel ch must be 0-7
	ch=ch&0b00000111;
	ADMUX|=ch;
	
	//Start Single conversion
	ADCSRA|=(1<<ADSC);

	//Wait for conversion to complete
	while(!(ADCSRA & (1<<ADIF)));

	//Clear ADIF by writing one to it
	ADCSRA|=(1<<ADIF);

	return(ADC);
}
	 
	


void main()
{
	uint16_t adc_value;
	uint8_t t;
	// Prescaler = FCPU/1024
	TCCR0|=(1<<CS02);

	//Enable Overflow Interrupt Enable
	TIMSK|=(1<<TOIE0);

	//Initialize Counter
	TCNT0=0;

	//Port C[2,1,0] as out put
	DDRB|=0b00000111;

	PORTB=0b00000110;

	//Port D
	SEVEN_SEGMENT_DDR=0XFF;

	//Turn off all segments
	SEVEN_SEGMENT_PORT=0XFF;

	//Enable Global Interrupts
	sei();

	//Enable ADC
	InitADC();

	//Infinite loop
	while(1)
	{
		//Read ADC
		adc_value=ReadADC(0);

		//Convert to degree Centrigrade
		t=adc_value/2;

		//Print to display
		Print(t);	

		//Wait some time
		Wait();	

	}
}

ISR(TIMER0_OVF_vect)
{
	static uint8_t i=0;
	if(i==2)
	{
		i=0;
	}
	else
	{
		i++;
	}
	PORTB=~(1<<i);
	SevenSegment(digits[i],0);

}


	
