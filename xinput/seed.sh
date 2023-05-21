NAME="xinput"
DESC="Utility to configure and test X input devices"
VERSION="1.6.3"
SOURCE="https://www.x.org/archive//individual/app/xinput-${VERSION}.tar.bz2"
CHECKSUM="ac6b7432726008b2f50eba82b0e2dbe4"
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
