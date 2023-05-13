NAME="libxv"
DESC="Xlib-based library for the X Video (Xv) extension to the X Window System"
VERSION="1.0.12"
SOURCE="https://www.x.org/archive//individual/lib/libXv-${VERSION}.tar.xz"
CHECKSUM="70bfdd14ca1a563c218794413f0c1f42"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXv-${VERSION}
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
