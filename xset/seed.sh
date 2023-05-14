NAME="xset"
DESC="User preference utility for X"
VERSION="1.2.5"
SOURCE="https://www.x.org/archive//individual/app/xset-${VERSION}.tar.xz"
CHECKSUM="18ff5cdff59015722431d568a5c0bad2"
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
