lib1.so: lib1.c
	gcc -shared -fPIC $^ -o $@

lib2.so: lib2.c
	gcc -shared -fPIC $^ -o $@

lib2f.so: lib2f.c
	gcc -shared -fPIC -Wl,--filter,lib2.so $^ -o $@

main: lib1.so lib2.so lib2f.so main.c
	gcc main.c -L. -l2f -l1 -o $@

clean:
	rm *.o *.so main
