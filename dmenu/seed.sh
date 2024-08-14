NAME="dmenu"
DESC="Dynamic menu for X"
VERSION="1.1.0"
SOURCE="https://github.com/Toasterbirb/dmenu/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="ded195aa7e4ae0214fdf640842e2d97d"
DEPS="xorg-libs fontconfig mononoki"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
