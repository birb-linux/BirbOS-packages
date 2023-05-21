NAME="xdriinfo"
DESC="Query configuration information of DRI drivers"
VERSION="1.0.7"
SOURCE="https://www.x.org/archive//individual/app/xdriinfo-${VERSION}.tar.xz"
CHECKSUM="34aff1f93fa54d6a64cbe4fee079e077"
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
