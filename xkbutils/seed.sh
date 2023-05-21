NAME="xkbutils"
DESC="Collection of small XKB utilities"
VERSION="1.0.5"
SOURCE="https://www.x.org/archive//individual/app/xkbutils-${VERSION}.tar.xz"
CHECKSUM="cf65ca1aaf4c28772ca7993cfd122563"
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
