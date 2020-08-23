
C_FLAGS= -O0 -g -Wno-unused-result -no-pie -fno-pic
LD_FLAGS=-L.

bin = ex1

lib = libex2.a

all: lib $(bin)

$(bin): $(bin).o
	gcc $(C_FLAGS) $(LD_FLAGS) $(LDFLAGS) -O1 -m32 $^ -o $@ $(shell ls *.a -q | xargs -n 1 basename | sed "s/lib\(.*\)\.a/\-l\1/g" | tr '\n' ' ')

%.o : %.c
	gcc $(C_FLAGS) $(CFLAGS) -m32 -c $<

.PHONY: clean clean-all lib src

clean:
	rm -f *.o *.a *~ *\#
	rm $(bin)

lib : $(lib)

libex2.a : ex2.o
	ar rcs $(lib) $^

ex2.o : ex2.asm
	nasm -f elf32 $< -o $@

dist: clean
	cd .. && tar zcvf ex2.tgz ex2

install:
	cp *.a $(prefix)/usr/lib
	cp $(bin) $(prefix)/usr/bin

uninstall:
	rm $(prefix)/usr/lib/$(shell ls *.a -q) -f
	rm $(prefix)/usr/bin/$(bin)