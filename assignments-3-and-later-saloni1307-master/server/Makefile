ifeq ($(CC),)
	CC = $(CROSS_COMPILE)gcc
endif
ifeq ($(CFLAGS),)
	CFLAGS=-g -Wall -Werror
endif
ifeq ($(LDFLAGS),)
	LDFLAGS = -pthread -lrt
endif

all: default

default: aesdsocket

aesdsocket: aesdsocket.o
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -f aesdsocket *.o

