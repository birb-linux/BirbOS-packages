NAME="dmenu"
DESC="Dynamic menu for X"
VERSION="1.0.0"
SOURCE="https://github.com/Toasterbirb/dmenu/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="ea375a71ad8a78eeea26c3a50e2c05e7"
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
