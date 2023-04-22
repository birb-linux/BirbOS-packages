NAME="freetype2"
DESC="TrueType font rendering library"
VERSION="2.13.0"
SOURCE="https://downloads.sourceforge.net/freetype/freetype-${VERSION}.tar.xz"
CHECKSUM="fe73327ebbf0b629f3ad24be656d59de"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg

	sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
		-i include/freetype/config/ftoption.h

	./configure --prefix=$FAKEROOT/$NAME/usr --enable-freetype-config --disable-static

	make -j$(nproc)
}

_install()
{
	make install
}
