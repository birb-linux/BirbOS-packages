NAME="xwininfo"
DESC="Window information utility for X"
VERSION="1.1.5"
SOURCE="https://www.x.org/archive//individual/app/xwininfo-${VERSION}.tar.bz2"
CHECKSUM="26d46f7ef0588d3392da3ad5802be420"
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
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
