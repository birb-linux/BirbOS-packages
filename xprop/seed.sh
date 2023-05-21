NAME="xprop"
DESC="Property displayer for X"
VERSION="1.2.6"
SOURCE="https://www.x.org/archive//individual/app/xprop-${VERSION}.tar.xz"
CHECKSUM="33c090d8632a300e63efbf36edd6a333"
DEPS="libpng mesa xbitmaps xcb-util"
FLAGS=""

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
