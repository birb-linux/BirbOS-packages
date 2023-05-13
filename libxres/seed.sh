NAME="libxres"
DESC="Xlib-based X-Resource extension client library"
VERSION="1.2.2"
SOURCE="https://www.x.org/archive//individual/lib/libXres-${VERSION}.tar.xz"
CHECKSUM="66c9e9e01b0b53052bb1d02ebf8d7040"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXres-${VERSION}
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
