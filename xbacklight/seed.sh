NAME="xbacklight"
DESC="Adjust display and keyboard backlight using the /sys filesystem"
VERSION="1.2.3"
SOURCE="https://www.x.org/archive//individual/app/xbacklight-${VERSION}.tar.bz2"
CHECKSUM="5b6405973db69c0443be2fba8e1a8ab7"
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
