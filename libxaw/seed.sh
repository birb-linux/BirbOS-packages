NAME="libxaw"
DESC="X Athena Widget Set, based on the X Toolkit Intrinsics (Xt) Library"
VERSION="1.0.14"
SOURCE="https://www.x.org/archive//individual/lib/libXaw-${VERSION}.tar.bz2"
CHECKSUM="c1ce21c296bbf3da3e30cf651649563e"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXaw-${VERSION}
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
