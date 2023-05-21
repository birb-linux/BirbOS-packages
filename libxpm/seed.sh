NAME="libxpm"
DESC="X Pixmap (XPM) image file format library"
VERSION="3.5.15"
SOURCE="https://www.x.org/archive//individual/lib/libXpm-${VERSION}.tar.xz"
CHECKSUM="b3c58c94e284fd6940d3615e660a0007"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXpm-${VERSION}
}

_build()
{
	sed -i '/TestAll.*TRUE/s|^|//|' test/TestAllFiles.h

	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION \
		--disable-open-zfile

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
