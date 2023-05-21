NAME="xcb-util-renderutil"
DESC="Additional extensions to the XCB library"
VERSION="0.3.10"
SOURCE="https://xcb.freedesktop.org/dist/xcb-util-renderutil-${VERSION}.tar.xz"
CHECKSUM="193b890e2a89a53c31e2ece3afcbd55f"
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
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
