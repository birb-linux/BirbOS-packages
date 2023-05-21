NAME="x11perf"
DESC="X11 server performance test program"
VERSION="1.6.1"
SOURCE="https://www.x.org/archive//individual/app/x11perf-${VERSION}.tar.bz2"
CHECKSUM="e96b56756990c56c24d2d02c2964456b"
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
