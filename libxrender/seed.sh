NAME="libxrender"
DESC="Xlib library for the Render Extension to the X11 protocol"
VERSION="0.9.11"
SOURCE="https://www.x.org/archive//individual/lib/libXrender-${VERSION}.tar.xz"
CHECKSUM="ebf7fb3241ec03e8a3b2af72f03b4631"
DEPS="fontconfig libxcb elogind libx11"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXrender-${VERSION}
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
