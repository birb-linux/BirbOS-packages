NAME="libxmu"
DESC="Collection of miscellaneous utility functions that have been useful in building various applications and widgets"
VERSION="1.1.4"
SOURCE="https://www.x.org/archive//individual/lib/libXmu-${VERSION}.tar.xz"
CHECKSUM="ed52d396115fbc4d05300762aab79685"
DEPS="fontconfig libxcb elogind libx11 libxt libxext"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXmu-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
