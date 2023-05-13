NAME="libxshmfence"
DESC="Shared memory 'SyncFence' synchronization primitive"
VERSION="1.3.2"
SOURCE="https://www.x.org/archive//individual/lib/libxshmfence-${VERSION}.tar.xz"
CHECKSUM="faa74f7483074ce7d4349e6bdc237497"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libxshmfence-${VERSION}
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
