NAME="xnotify"
DESC="Read notifications from stdin and pop them up on the screen"
VERSION="0.9.3"
SOURCE="https://github.com/phillbush/xnotify/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="d81524f5d88ebe2dc4a70d105ab05fc1"
DEPS="freetype fontconfig libxft libx11 libxinerama imlib2"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make all -j${BUILD_JOBS}
}

_install()
{
	make PREFIX=/usr DESTDIR=$FAKEROOT/$NAME install
}
