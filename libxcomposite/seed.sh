NAME="libxcomposite"
DESC="Xlib-based client library for the Composite extension to the X11 protocol"
VERSION="0.4.6"
SOURCE="https://www.x.org/archive//individual/lib/libXcomposite-${VERSION}.tar.xz"
CHECKSUM="af0a5f0abb5b55f8411cd738cf0e5259"
DEPS="fontconfig libxcb elogind libx11 libxfixes"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXcomposite-${VERSION}
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
