NAME="xcb-util-keysyms"
DESC="Library for handling standard X key constants and conversion to/from keycodes"
VERSION="0.4.1"
SOURCE="https://xcb.freedesktop.org/dist/xcb-util-keysyms-${VERSION}.tar.xz"
CHECKSUM="fbdc05f86f72f287ed71b162f1a9725a"
DEPS="libxcb"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
	make -j${BUILD_JOBS}
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

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
