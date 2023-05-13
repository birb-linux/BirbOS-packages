NAME="libice"
DESC="Inter-Client Exchange Library"
VERSION="1.1.1"
SOURCE="https://www.x.org/archive//individual/lib/libICE-${VERSION}.tar.xz"
CHECKSUM="b444a0e4c2163d1bbc7b046c3653eb8d"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libICE-${VERSION}
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
