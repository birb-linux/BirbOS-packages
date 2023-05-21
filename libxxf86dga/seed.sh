NAME="libxxf86dga"
DESC="Xlib-based library for the XFree86-DGA extension"
VERSION="1.1.6"
SOURCE="https://www.x.org/archive//individual/lib/libXxf86dga-${VERSION}.tar.xz"
CHECKSUM="74d1acf93b83abeb0954824da0ec400b"
DEPS="fontconfig libxcb elogind libx11 libxext"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXxf86dga-${VERSION}
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
