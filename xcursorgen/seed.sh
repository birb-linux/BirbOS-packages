NAME="xcursorgen"
DESC="Create an X cursor file from a collection of PNG images"
VERSION="1.0.8"
SOURCE="https://www.x.org/archive//individual/app/xcursorgen-${VERSION}.tar.xz"
CHECKSUM="89e81a1c31e4a1fbd0e431425cd733d7"
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
