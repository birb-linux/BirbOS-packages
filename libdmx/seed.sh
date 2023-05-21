NAME="libdmx"
DESC="X.Org dmx library"
VERSION="1.1.4"
SOURCE="https://www.x.org/archive//individual/lib/libdmx-${VERSION}.tar.bz2"
CHECKSUM="d2f1f0ec68ac3932dd7f1d9aa0a7a11c"
DEPS="fontconfig libxcb elogind libx11 libxext"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libdmx-${VERSION}
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
