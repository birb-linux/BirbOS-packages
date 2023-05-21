NAME="xlsclients"
DESC="List client applications running on a display"
VERSION="1.1.5"
SOURCE="https://www.x.org/archive//individual/app/xlsclients-${VERSION}.tar.xz"
CHECKSUM="ab4b3c47e848ba8c3e47c021230ab23a"
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
