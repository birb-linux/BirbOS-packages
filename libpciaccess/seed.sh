NAME="libpciaccess"
DESC="Generic PCI access library"
VERSION="0.17"
SOURCE="https://www.x.org/archive//individual/lib/libpciaccess-${VERSION}.tar.xz"
CHECKSUM="1466cf950c914ad2db1dbb76c9a724db"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libpciaccess-${VERSION}
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
