NAME="libxft"
DESC="X FreeType library"
VERSION="2.3.7"
SOURCE="https://www.x.org/archive//individual/lib/libXft-${VERSION}.tar.xz"
CHECKSUM="69dc24ba444a0f6bd99423dbf8fd0260"
DEPS="fontconfig libxcb elogind libx11 libxrender"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXft-${VERSION}
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
