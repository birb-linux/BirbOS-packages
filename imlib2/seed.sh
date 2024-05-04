NAME="imlib2"
DESC="Graphics library for fast file loading, saving, rendering and manipulation"
VERSION="1.12.2"
SOURCE="https://downloads.sourceforge.net/enlightenment/imlib2-${VERSION}.tar.xz"
CHECKSUM="046e7b2c918ae612dbf61dea8b59f37a"
DEPS="xorg-libs giflib libpng"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
