.PHONY: all module1 module2

all: module1 module2 main

module1:
	$(MAKE) -C module1

module2:
	$(MAKE) -C module2

main: main.cpp module1/add.o module2/sub.o
	g++ -std=c++98 -Wall main.cpp module1/add.o module2/sub.o -o main
