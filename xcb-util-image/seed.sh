NAME="xcb-util-image"
DESC="Additional extensions to the XCB library"
VERSION="0.4.1"
SOURCE="https://xcb.freedesktop.org/dist/xcb-util-image-${VERSION}.tar.xz"
CHECKSUM="a67bfac2eff696170259ef1f5ce1b611"
DEPS="xcb-util"
FLAGS="test"

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

_test()
{
	LD_LIBRARY_PATH=$XORG_PREFIX/lib make -j${BUILD_JOBS} check
}
