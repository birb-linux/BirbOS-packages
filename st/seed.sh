NAME="st"
DESC="Simple terminal for X"
VERSION="1.1.0"
SOURCE="https://github.com/Toasterbirb/st/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="ecd1446b56011ba180ec619f0ed5de1e"
DEPS="xorg-libs pkg-config fontconfig mononoki freetype harfbuzz graphite2 zlib glib pcre2"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make CC=gcc -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
