CC = $(CROSS_COMPILE)gcc

all:	writer

writer:	writer.o
	$(CC) -g -Wall -I/ writer.o -o writer

clean:
	-rm -f *.o writer *.elf *.map
