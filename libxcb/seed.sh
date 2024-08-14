NAME="libxcb"
DESC="Interface to the X Window System protocol"
VERSION="1.16"
SOURCE="https://xorg.freedesktop.org/archive/individual/lib/libxcb-${VERSION}.tar.xz"
CHECKSUM="c769f93c254263077df62404661b710d"
DEPS="libxau xcb-proto libxdmcp"
FLAGS="32bit test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	PYTHON=python3                \
	./configure $XORG_CONFIG      \
				--without-doxygen \
				--docdir='${datadir}'/doc/libxcb-${VERSION}

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

	LDFLAGS="-L/usr/lib32" CC="gcc -m32" ./configure \
		$XORG_CONFIG \
		--without-doxygen \
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
