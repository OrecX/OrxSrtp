all:liborxsrtp.so

clean:
	rm liborxsrtp.so

liborxsrtp.so: srtp.c srtp.h
	gcc -shared -o liborxsrtp.so -fPIC -O2 srtp.c

install:
	mkdir -p $(DESTDIR)/usr/lib
	mkdir -p $(DESTDIR)/usr/share/liborxsrtp
	install -m 0755 liborxsrtp.so $(DESTDIR)/usr/lib/liborxsrtp.so
	install -m 0755 COPYING $(DESTDIR)/usr/share/liborxsrtp/COPYING
