NAME="xclock"
DESC="A simple clock application which is used in the default xinit configuration"
VERSION="1.1.1"
SOURCE="https://www.x.org/pub/individual/app/xclock-${VERSION}.tar.xz"
CHECKSUM="1273e3f4c85f1801be11a5247c382d07"
DEPS="xorg-libs"
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
