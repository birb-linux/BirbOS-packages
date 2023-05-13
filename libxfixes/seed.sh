NAME="libxfixes"
DESC="Xlib-based library for the XFIXES Extension"
VERSION="6.0.0"
SOURCE="https://www.x.org/archive//individual/lib/libXfixes-${VERSION}.tar.bz2"
CHECKSUM="86f182f487f4f54684ef6b142096bb0f"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXfixes-${VERSION}
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
