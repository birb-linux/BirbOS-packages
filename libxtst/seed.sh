NAME="libxtst"
DESC="Xlib-based library for XTEST & RECORD extensions"
VERSION="1.2.4"
SOURCE="https://www.x.org/archive//individual/lib/libXtst-${VERSION}.tar.xz"
CHECKSUM="02f128fbf809aa9c50d6e54c8e57cb2e"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXtst-${VERSION}
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
