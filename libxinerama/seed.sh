NAME="libxinerama"
DESC="Xlib API for Xinerama extension to X11 Protocol"
VERSION="1.1.5"
SOURCE="https://www.x.org/archive//individual/lib/libXinerama-${VERSION}.tar.xz"
CHECKSUM="228c877558c265d2f63c56a03f7d3f21"
DEPS="fontconfig libxcb elogind libx11 libxext"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXinerama-${VERSION}
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
