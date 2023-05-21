NAME="xcb-proto"
DESC="XML-XCB protocol descriptions used by libxcb"
VERSION="1.15.2"
SOURCE="https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-${VERSION}.tar.xz"
CHECKSUM="d2251b01927c2fbe92dc540f9536b430"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	PYTHON=python3 ./configure $XORG_CONFIG
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} check
}
