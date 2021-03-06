package = liborxsrtp
version = 0.2
tarname = $(package)
distdir = $(tarname)-$(version)
MAJOR_VER=0
LIBDIR=/usr/lib64


all:liborxsrtp.so.${version}

dist: $(distdir).tar.gz

distclean:
	-rm $(distdir).tar.gz

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
	-rm liborxsrtp.so.${version} $(distdir).tar.gz


srtp.o: srtp.c srtp.h Makefile
	gcc -c -o srtp.o -fPIC -O2 -DUSE_PTHREAD -g srtp.c

liborxsrtp.so.${version}: srtp.o
	gcc -shared -o liborxsrtp.so.${version}  srtp.o -lgcrypt

install:
	mkdir -p $(DESTDIR)$(LIBDIR)
	mkdir -p $(DESTDIR)/usr/share/liborxsrtp
	mkdir -p $(DESTDIR)/usr/include/srtp
	install -m 0755 liborxsrtp.so.${version} $(DESTDIR)$(LIBDIR)/liborxsrtp.so.${version}
	install -m 0644 COPYING $(DESTDIR)/usr/share/liborxsrtp/COPYING
	install -m 0644 srtp.h $(DESTDIR)/usr/include/srtp/
	ln -sf liborxsrtp.so.$(version) $(DESTDIR)$(LIBDIR)/liborxsrtp.so

.PHONY: all clean dist distclean
