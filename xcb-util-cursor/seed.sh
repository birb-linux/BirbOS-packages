NAME="xcb-util-cursor"
DESC="A module that implements the XCB cursor library (XCB replacement for libXcursor)"
VERSION="0.1.4"
SOURCE="https://xcb.freedesktop.org/dist/xcb-util-cursor-${VERSION}.tar.xz"
CHECKSUM="0d244518ad54b886413fe782235d6210"
DEPS="xcb-util-image xcb-util-renderutil"
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
