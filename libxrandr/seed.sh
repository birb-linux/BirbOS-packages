NAME="libxrandr"
DESC="X Resize and Rotate library"
VERSION="1.5.3"
SOURCE="https://www.x.org/archive//individual/lib/libXrandr-${VERSION}.tar.xz"
CHECKSUM="850cbc7c921c9d5d0135734b114ff6ac"
DEPS="fontconfig libxcb elogind libx11 libxext libxrender"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXrandr-${VERSION}
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
