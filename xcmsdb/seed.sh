NAME="xcmsdb"
DESC="Device Color Characterization utility for X Color Management System"
VERSION="1.0.6"
SOURCE="https://www.x.org/archive//individual/app/xcmsdb-${VERSION}.tar.xz"
CHECKSUM="82a90e2feaeab5c5e7610420930cc0f4"
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
