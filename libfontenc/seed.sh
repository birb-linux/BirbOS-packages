NAME="libfontenc"
DESC="X font encoding library"
VERSION="1.1.7"
SOURCE="https://www.x.org/archive//individual/lib/libfontenc-${VERSION}.tar.xz"
CHECKSUM="6d3f1b15bb5b0bb71ae9f0a5103c1fc4"
DEPS="fontconfig libxcb elogind libx11"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
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
