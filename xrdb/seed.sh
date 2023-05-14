NAME="xrdb"
DESC="X server resource database utility"
VERSION="1.2.1"
SOURCE="https://www.x.org/archive//individual/app/xrdb-${VERSION}.tar.bz2"
CHECKSUM="85f04a810e2fb6b41ab872b421dce1b1"
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
