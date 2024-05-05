NAME="xcb-proto"
DESC="XML-XCB protocol descriptions used by libxcb"
VERSION="1.16.0"
SOURCE="https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-${VERSION}.tar.xz"
CHECKSUM="92081b0faafd93f8262463c69829a482"
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

	# Make xcb-proto available for 32bit packages
	mkdir -p "$FAKEROOT/$NAME/usr/lib32/pkgconfig"
	cp -v "$FAKEROOT/$NAME/usr/share/pkgconfig/xcb-proto.pc" "$FAKEROOT/$NAME/usr/lib32/pkgconfig/"
}

_test()
{
	make -j${BUILD_JOBS} check
}
