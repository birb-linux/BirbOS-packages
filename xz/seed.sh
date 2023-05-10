NAME="xz"
DESC="Compression and decompression utilities"
VERSION="5.4.2"
SOURCE="https://tukaani.org/xz/xz-${VERSION}.tar.xz"
CHECKSUM="1dcdf002d9a69f48ff67be84964af0d8"
DEPS=""
FLAGS="32bit important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-${VERSION}

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_build32()
{
	make distclean
	CC="gcc -m32" ./configure 	      \
		--host=i686-pc-linux-gnu      \
		--prefix=$FAKEROOT/$NAME/usr  \
		--libdir=/usr/lib32           \
		--disable-static

	make -j${MAKEOPTS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
