NAME="xcb-util"
DESC="Additional extensions to the XCB library"
VERSION="0.4.1"
SOURCE="https://xcb.freedesktop.org/dist/xcb-util-${VERSION}.tar.xz"
CHECKSUM="34d749eab0fd0ffd519ac64798d79847"
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
