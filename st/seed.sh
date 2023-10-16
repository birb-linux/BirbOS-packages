NAME="st"
DESC="Simple terminal for X"
VERSION="1.0.0"
SOURCE="https://github.com/Toasterbirb/st/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="2d07cf956aa8cf2f2c63925605c5aed7"
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
