NAME="xsetroot"
DESC="Root window parameter setting utility for X"
VERSION="1.1.3"
SOURCE="https://www.x.org/archive//individual/app/xsetroot-${VERSION}.tar.xz"
CHECKSUM="fa9a24fe5b1725c52a4566a62dd0a50d"
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
