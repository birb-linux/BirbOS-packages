NAME="xdpyinfo"
DESC="Display information utility for X"
VERSION="1.3.3"
SOURCE="https://www.x.org/archive//individual/app/xdpyinfo-${VERSION}.tar.xz"
CHECKSUM="f67116760888f2e06486ee3d179875d2"
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
