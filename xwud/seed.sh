NAME="xwud"
DESC="Image displayer for X"
VERSION="1.0.6"
SOURCE="https://www.x.org/archive//individual/app/xwud-${VERSION}.tar.xz"
CHECKSUM="5ff5dc120e8e927dc3c331c7fee33fc3"
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
