NAME="xwd"
DESC="Dump an image of an X window"
VERSION="1.0.8"
SOURCE="https://www.x.org/archive//individual/app/xwd-${VERSION}.tar.bz2"
CHECKSUM="f783a209f2e3fa13253cedb65eaf9cdb"
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
