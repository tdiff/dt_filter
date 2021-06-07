lib1.o: lib1.c
	gcc -c -fPIC lib1.c -o $@

lib1.so: lib1.o
	gcc -shared lib1.o -o $@

lib2.o: lib2.c
	gcc -c -fPIC lib2.c -o $@

lib2.so: lib2.o
	gcc -O2 -shared lib2.o -o $@

lib2f.o: lib2f.c
	gcc -c -fPIC lib2f.c -o $@

lib2f.so: lib2f.o
	gcc -shared -Wl,--filter,lib2.so lib2f.o -o $@

main: lib1.so lib2.so main.c
	gcc main.c -L. -l2 -l1 -o $@

main-filter: lib1.so lib2.so lib2f.so main.c
	gcc main.c -L. -l2f -l1 -o $@

clean:
	rm *.o *.so main main-filter
