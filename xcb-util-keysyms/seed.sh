NAME="xcb-util-keysyms"
DESC="Library for handling standard X key constants and conversion to/from keycodes"
VERSION="0.4.1"
SOURCE="https://xcb.freedesktop.org/dist/xcb-util-keysyms-${VERSION}.tar.xz"
CHECKSUM="fbdc05f86f72f287ed71b162f1a9725a"
DEPS="libxcb"
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
