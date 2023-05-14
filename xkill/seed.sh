NAME="xkill"
DESC="Kill a client by its X resource"
VERSION="1.0.6"
SOURCE="https://www.x.org/archive//individual/app/xkill-${VERSION}.tar.xz"
CHECKSUM="f62b99839249ce9a7a8bb71a5bab6f9d"
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
