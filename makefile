all: main.o
	gcc -o main main.o
	./main

*.o: *.c
	gcc -c $<

clean:
	rm -f *.o main