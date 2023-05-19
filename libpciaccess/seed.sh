NAME="libpciaccess"
DESC="Generic PCI access library"
VERSION="0.17"
SOURCE="https://www.x.org/archive//individual/lib/libpciaccess-${VERSION}.tar.xz"
CHECKSUM="1466cf950c914ad2db1dbb76c9a724db"
DEPS="fontconfig libxcb elogind libx11"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libpciaccess-${VERSION}
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
