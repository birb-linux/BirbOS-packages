NAME="libxi"
DESC="Xlib library for the X Input Extension"
VERSION="1.8"
SOURCE="https://www.x.org/archive//individual/lib/libXi-${VERSION}.tar.bz2"
CHECKSUM="74055672a111a98ce2841d2ec4057b05"
DEPS="fontconfig libxcb elogind libx11 libxext libxfixes"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXi-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION
	make -j${MAKEOPTS}
}

_install()
{
	make install
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
