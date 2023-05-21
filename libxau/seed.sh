NAME="libxau"
DESC="Library that implements the X11 Authorization Protocol"
VERSION="1.0.11"
SOURCE="https://www.x.org/pub/individual/lib/libXau-${VERSION}.tar.xz"
CHECKSUM="7f14ba9c84a81a2b9dd023706febab38"
DEPS="xorgproto"
FLAGS="32bit test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXau-${VERSION}
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

_test()
{
	make -j${BUILD_JOBS} check
}

_build32()
{
	make distclean

	CC="gcc -m32" ./configure \
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
