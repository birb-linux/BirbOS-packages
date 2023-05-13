NAME="libx11"
DESC="Core X11 protocol client library"
VERSION="1.8.4"
SOURCE="https://www.x.org/archive//individual/lib/libX11-${VERSION}.tar.xz"
CHECKSUM="e932752126240f0846b35eef6b1f2c3d"
DEPS="fontconfig libxcb elogind"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libX11-${VERSION}
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
