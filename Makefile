CFLAGS=-g -std=c99 -O3 -m32 -Werror -Wall

main : prog.o func.o Makefile
	gcc $(CFLAGS) -o main func.o prog.o

%.o : $.c Makefile
	gcc $(CFLAGS) -MD -c $*.c

%.o : %.s Makefile
	gcc $(CFLAGS) -MD -c $*.s

test : Makefile main
	./main

clean :
	rm -f *.d
	rm -f *.o
	rm -f main

-include *.d
