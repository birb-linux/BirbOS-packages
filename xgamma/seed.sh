NAME="xgamma"
DESC="Alter a monitor's gamma correction through the X server"
VERSION="1.0.7"
SOURCE="https://www.x.org/archive//individual/app/xgamma-${VERSION}.tar.xz"
CHECKSUM="41afaa5a68cdd0de7e7ece4805a37f11"
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
