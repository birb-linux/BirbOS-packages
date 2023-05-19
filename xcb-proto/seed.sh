NAME="xcb-proto"
DESC="XML-XCB protocol descriptions used by libxcb"
VERSION="1.15.2"
SOURCE="https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-${VERSION}.tar.xz"
CHECKSUM="d2251b01927c2fbe92dc540f9536b430"
DEPS=""
FLAGS="32bit test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	PYTHON=python3 ./configure $XORG_CONFIG
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

	PYTHON=python3 LDFLAGS="-L/usr/lib32" CC="gcc -m32" ./configure \
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
