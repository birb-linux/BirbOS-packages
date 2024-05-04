NAME="xz"
DESC="Compression and decompression utilities"
VERSION="5.4.6"
SOURCE="https://tukaani.org/xz/xz-${VERSION}.tar.xz"
CHECKSUM="7ade7bd1181a731328f875bec62a9377"
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

	make -j${BUILD_JOBS}
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

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
