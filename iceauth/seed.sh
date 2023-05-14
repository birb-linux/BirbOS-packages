NAME="iceauth"
DESC="ICE authority file utility"
VERSION="1.0.9"
SOURCE="https://www.x.org/archive//individual/app/iceauth-${VERSION}.tar.xz"
CHECKSUM="5d3feaa898875484b6b340b3888d49d8"
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
