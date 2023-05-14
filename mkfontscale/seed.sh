NAME="mkfontscale"
DESC="Create an index of scalable font files for X"
VERSION="1.2.2"
SOURCE="https://www.x.org/archive//individual/app/mkfontscale-${VERSION}.tar.xz"
CHECKSUM="fd2e6e5a297ac2bf3d7d54799bf69de0"
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
