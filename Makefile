.PHONY: all module1 module2

all: module1 module2 main

module1:
\t$(MAKE) -C module1

module2:
\t$(MAKE) -C module2

main: main.cpp module1/add.o module2/sub.o
\tg++ -std=c++98 -Wall main.cpp module1/add.o module2/sub.o -o main
