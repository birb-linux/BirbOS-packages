NAME="libsm"
DESC="X Session Management Library"
VERSION="1.2.4"
SOURCE="https://www.x.org/archive//individual/lib/libSM-${VERSION}.tar.xz"
CHECKSUM="ffa434ed96ccae45533b3d653300730e"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libSM-${VERSION}
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
