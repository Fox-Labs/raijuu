#include <avr/io.h>

int main() {
	DDRB = 0xFF;// 11111111
	PORTB = 255;// 11111111
	while(1) {
		PORTB = PIND;//Portanto, a porta B copia a situa��o da porta D.
	}
}
