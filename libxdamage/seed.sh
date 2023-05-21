NAME="libxdamage"
DESC="X Damage Extension library"
VERSION="1.1.6"
SOURCE="https://www.x.org/archive//individual/lib/libXdamage-${VERSION}.tar.xz"
CHECKSUM="ca55d29fa0a8b5c4a89f609a7952ebf8"
DEPS="fontconfig libxcb elogind libx11 libxfixes"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXdamage-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
