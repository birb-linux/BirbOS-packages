NAME="xev"
DESC="Print contents of X events"
VERSION="1.2.5"
SOURCE="https://www.x.org/archive//individual/app/xev-${VERSION}.tar.xz"
CHECKSUM="61219e492511b3d78375da76defbdc97"
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
