NAME="libfs"
DESC="filesystem API written in ANSI C"
VERSION="1.0.9"
SOURCE="https://www.x.org/archive//individual/lib/libFS-${VERSION}.tar.xz"
CHECKSUM="742863a552ecd53cdb957b7b276213cc"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libFS-${VERSION}
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
