NAME="xpr"
DESC="Print an X window dump"
VERSION="1.1.0"
SOURCE="https://www.x.org/archive//individual/app/xpr-${VERSION}.tar.xz"
CHECKSUM="9cf272cba661f7acc35015f2be8077db"
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
