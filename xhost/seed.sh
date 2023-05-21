NAME="xhost"
DESC="Server access control program for X"
VERSION="1.0.9"
SOURCE="https://www.x.org/archive//individual/app/xhost-${VERSION}.tar.xz"
CHECKSUM="48ac13856838d34f2e7fca8cdc1f1699"
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
