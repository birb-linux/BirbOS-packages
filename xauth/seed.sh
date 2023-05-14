NAME="xauth"
DESC="X authority file utility"
VERSION="1.1.2"
SOURCE="https://www.x.org/archive//individual/app/xauth-${VERSION}.tar.xz"
CHECKSUM="dbcf944eb59343b84799b2cc70aace16"
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
