NAME="freetype"
DESC="TrueType font rendering library"
VERSION="2.13.2"
SOURCE="https://downloads.sourceforge.net/freetype/freetype-${VERSION}.tar.xz"
CHECKSUM="d41d8cd98f00b204e9800998ecf8427e"
DEPS=""
FLAGS="important"

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

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
