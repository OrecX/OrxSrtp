package = liborxsrtp
version = 0.1
tarname = $(package)
distdir = $(tarname)-$(version)
MAJOR_VER=0


all:liborxsrtp.so.${version}

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
	-rm liborxsrtp.so.${version} $(distdir).tar.gz


liborxsrtp.so.${version}: srtp.c srtp.h
	gcc -shared -o liborxsrtp.so.${version} -lgcrypt -fPIC -O2 srtp.c

install:
	mkdir -p $(DESTDIR)/usr/lib64
	mkdir -p $(DESTDIR)/usr/share/liborxsrtp
	mkdir -p $(DESTDIR)/usr/include/srtp
	install -m 0755 liborxsrtp.so.${version} $(DESTDIR)/usr/lib64/liborxsrtp.so.${version}
	install -m 0755 COPYING $(DESTDIR)/usr/share/liborxsrtp/COPYING
	install -m 0755 srtp.h $(DESTDIR)/usr/include/srtp/
#	ln -s liborxsrtp.so.$(version) $(DESTDIR)/usr/lib64/liborxsrtp.so

.PHONY: all clean dist