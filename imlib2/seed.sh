NAME="imlib2"
DESC="Graphics library for fast file loading, saving, rendering and manipulation"
VERSION="1.9.1"
SOURCE="https://downloads.sourceforge.net/enlightenment/imlib2-${VERSION}.tar.xz"
CHECKSUM="596fd0664538adb7867aa609fb718147"
DEPS="xorg-libs giflib libpng"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
