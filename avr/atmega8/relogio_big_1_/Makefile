#------------------------------------------------------------------------------------
#Arquivo Makefile
#Escrito por Márcio José Soares (Arne)
#------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------
#Configurações gerais para o microcontrolador
#------------------------------------------------------------------------------------

#Microcontrolador
MCU = ATMEGA8

#Frequencia da CPU
#F_CPU = 4000000


#------------------------------------------------------------------------------------
#Configurações gerais para o compilador
#------------------------------------------------------------------------------------

#Compilador
CC = avr-gcc

#Conversor de arquivos
OBJCOPY = avr-objcopy

#Gravador
AVRDUDE = avrdude

#Programa para mostrar o tamanho do arquivo final
CODESIZE = avr-size

#Nome do programa - arquivo principal
TARGET = relogio_big
SRC = $(TARGET).c

#Nivel de compilação
CSTANDARD = -std=gnu99

#Otimização
OPT = s

#Flags gerais de compilação para linguagem C
CFLAGS += -Wall -Wstrict-prototypes
CFLAGS += -O$(OPT)
CFLAGS += -mcall-prologues
CFLAGS += $(CSTANDARD)

#Flags gerais de link edição
LDFLAGS = Wl,-Map,$(TARGET).map

#------------------------------------------------------------------------------------
#Combina todos os flags necessários a compilação
ALL_CFLAGS = -g $(CFLAGS)

#------------------------------------------------------------------------------------
#Define as mensagens a serem usadas neste makefile
MSG_INICIO  = ---------------------- Inicio  -------------------------------
MSG_FINAL   = ------------------------ Fim --------------------------------
MSG_COMPILE = Compilando $(TARGET).c ...
MSG_PROGR   = Programando $(TARGET).hex ...
MSG_VER     = Vrificando $(TARGET).hex ...
MSG_TAM		= Tamanho final do arquivo $(TARGET).hex:
MSG_LIMPA   = Limpando arquivos $(TARGET).hex e $(TARGET).o
MSG_PRONTO  = ...pronto!

#------------------------------------------------------------------------------------
#Configurações para o gravador utilizado
AVRDUDE_PROGRAMMER = avr910
AVRDUDE_PORT = /dev/ttyUSB0
AVRDUDE_WRITE_FLASH = -U flash:w:$(TARGET).hex
AVRDUDE_VERIFY_FLASH = -U flash:v:$(TARGET).hex
AVRDUDE_TAXA = 115200

#------------------------------------------------------------------------------------
#Configurações dos flags do gravador utilizado
AVRDUDE_FLAGS = -p $(MCU) -P $(AVRDUDE_PORT) -b $(AVRDUDE_TAXA)
AVRDUDE_FLAGS += -c $(AVRDUDE_PROGRAMMER) 

#------------------------------------------------------------------------------------
#Açoes do arquivo makefile

#------------------------------------------------------------------------------------
#Opção all
all: apague inicio versaogcc mostrecomp compile mostretam tamanho mostrepronto final

#------------------------------------------------------------------------------------
#Opção help
help: apague inicio ajuda final
	
#------------------------------------------------------------------------------------
#Opção clean
clean: apague inicio limpa final

#------------------------------------------------------------------------------------
#Opção program
program: apague inicio mostreprog programa mostrepronto final

#------------------------------------------------------------------------------------
#Opção verify
verify: apague inicio mostrever verifica mostrepronto final


#------------------------------------------------------------------------------------
#Scripts gerais

apague:
	clear

ajuda:
	@echo
	@echo "Modo de usar: make all|help|program|verify|clean"

limpa:
	@echo
	@echo $(MSG_LIMPA)
	rm -f $(TARGET).hex
	rm -f $(TARGET).o

inicio:
	@echo
	@echo $(MSG_INICIO)

final:
	@echo
	@echo $(MSG_FINAL)
	@echo

versaogcc:
	@echo
	@$(CC) --version

mostrecomp:
	@echo $(MSG_COMPILE)
	@echo

mostreprog:
	@echo $(MSG_PROG)
	@echo

mostretam:
	@echo
	@echo $(MSG_TAM)
	
mostrever:
	@echo $(MSG_VER)
	@echo

mostrepronto:
#	@echo
	@echo $(MSG_PRONTO)

programa:
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)

verifica:
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_VERIFY_FLASH)

tamanho:
	$(CODESIZE) -A -d --target=ihex $(TARGET).hex

compile: relogio_big.hex

relogio_big.hex : relogio_big.o
	$(OBJCOPY) -O ihex -R .eeprom $(TARGET).o $(TARGET).hex

relogio_big.o : relogio_big.c
	$(CC) $(ALL_CFLAGS) -o $(TARGET).o $(TARGET).c