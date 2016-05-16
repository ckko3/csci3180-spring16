CC=g++
CFLAGS=-Wall
EXE=has

all: ${EXE}
${EXE}: *.o
	g++ -Wall *.o -o ${EXE}
*.o: *.cpp
	g++ -Wall -c *.cpp

clean:
	/bin/rm -f *.o ${EXE}
