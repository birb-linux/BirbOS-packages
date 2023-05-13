NAME="libxi"
DESC="Xlib library for the X Input Extension"
VERSION="1.8"
SOURCE="https://www.x.org/archive//individual/lib/libXi-${VERSION}.tar.bz2"
CHECKSUM="74055672a111a98ce2841d2ec4057b05"
DEPS="fontconfig libxcb elogind libx11 libxext libxfixes"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXi-${VERSION}
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
