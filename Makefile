package = liborxsrtp
version = 0.1
tarname = $(package)
distdir = $(tarname)-$(version)

all:liborxsrtp.so

dist: $(distdir).tar.gz

$(distdir).tar.gz: $(distdir)
	tar chof - $(distdir) | gzip -9 -c > $@
	rm -rf $(distdir)

$(distdir):
	mkdir -p $(distdir)
	cp srtp.c $(distdir)
	cp srtp.h $(distdir)
	cp Makefile $(distdir)
	cp COPYING $(distdir)

clean:
	rm liborxsrtp.so


liborxsrtp.so: srtp.c srtp.h
	gcc -shared -o liborxsrtp.so -fPIC -O2 srtp.c

install:
	mkdir -p $(DESTDIR)/usr/lib
	mkdir -p $(DESTDIR)/usr/share/liborxsrtp
	install -m 0755 liborxsrtp.so $(DESTDIR)/usr/lib/liborxsrtp.so
	install -m 0755 COPYING $(DESTDIR)/usr/share/liborxsrtp/COPYING


.PHONY: all clean dist