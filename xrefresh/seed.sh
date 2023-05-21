NAME="xrefresh"
DESC="Refresh all or part of an X screen"
VERSION="1.0.7"
SOURCE="https://www.x.org/archive//individual/app/xrefresh-${VERSION}.tar.xz"
CHECKSUM="33b04489e417d73c90295bd2a0781cbb"
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
