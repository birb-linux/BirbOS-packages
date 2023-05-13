NAME="libxcursor"
DESC="Xlib-based Cursor management library"
VERSION="1.2.1"
SOURCE="https://www.x.org/archive//individual/lib/libXcursor-${VERSION}.tar.xz"
CHECKSUM="4cdd1886fe5cce6f68554296edb46db8"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXcursor-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
