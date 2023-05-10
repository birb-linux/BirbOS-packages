NAME="libxau"
DESC="Library that implements the X11 Authorization Protocol"
VERSION="1.0.11"
SOURCE="https://www.x.org/pub/individual/lib/libXau-${VERSION}.tar.xz"
CHECKSUM="7f14ba9c84a81a2b9dd023706febab38"
DEPS="xorgproto"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXau-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG

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
