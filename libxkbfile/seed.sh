NAME="libxkbfile"
DESC="XKB file handling routines"
VERSION="1.1.2"
SOURCE="https://www.x.org/archive//individual/lib/libxkbfile-${VERSION}.tar.xz"
CHECKSUM="8af2275955d40166bb647b14e4896ab1"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libxkbfile-${VERSION}
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
