NAME="libxdmcp"
DESC="Library implementing the X Display Manager Control Protocol"
VERSION="1.1.4"
SOURCE="https://www.x.org/pub/individual/lib/libXdmcp-${VERSION}.tar.xz"
CHECKSUM="0b4056a282c1e14323d5daef8fb5345d"
DEPS="xorgproto"
FLAGS="32bit test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXdmcp-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$FAKEROOT/$NAME/usr/share/doc/libXdmcp-${VERSION}

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	make -j${MAKEOPTS} check
}

_build32()
{
	make distclean

	LDFLAGS="-L/usr/lib32" CC="gcc -m32" ./configure \
		$XORG_CONFIG \
		--host=i686-pc-linux-gnu \
		--libdir=/usr/lib32

	make -j${MAKEOPTS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
