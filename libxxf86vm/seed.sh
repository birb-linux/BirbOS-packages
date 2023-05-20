NAME="libxxf86vm"
DESC="Xlib-based library for the XFree86-VidMode X extension"
VERSION="1.1.5"
SOURCE="https://www.x.org/archive//individual/lib/libXxf86vm-${VERSION}.tar.xz"
CHECKSUM="5b913dac587f2de17a02e17f9a44a75f"
DEPS="fontconfig libxcb elogind libx11 libxext"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXxf86vm-${VERSION}
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
