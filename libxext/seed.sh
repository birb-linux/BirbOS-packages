NAME="libxext"
DESC="Xlib-based library for common extensions to the X11 protocol"
VERSION="1.3.5"
SOURCE="https://www.x.org/archive//individual/lib/libXext-${VERSION}.tar.xz"
CHECKSUM="964942427fcc5a9fa0539661421857c8"
DEPS="fontconfig libxcb elogind"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXext-${VERSION}
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
