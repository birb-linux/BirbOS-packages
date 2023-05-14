NAME="xkbcomp"
DESC="Compile XKB keyboard description"
VERSION="1.4.6"
SOURCE="https://www.x.org/archive//individual/app/xkbcomp-${VERSION}.tar.xz"
CHECKSUM="a11d4d6eeda762f13818684c0670f89f"
DEPS="libpng mesa xbitmaps xcb-util"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
