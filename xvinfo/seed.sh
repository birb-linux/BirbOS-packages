NAME="xvinfo"
DESC="Print out X-Video extension adaptor information"
VERSION="1.1.5"
SOURCE="https://www.x.org/archive//individual/app/xvinfo-${VERSION}.tar.xz"
CHECKSUM="d698862e9cad153c5fefca6eee964685"
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
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
