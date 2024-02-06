NAME="btop"
DESC="A monitor of resources"
VERSION="1.2.13"
SOURCE="https://github.com/aristocratos/btop/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="be23bfd87f885c0f606f467ccfebc5e3"
DEPS=""
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
	make DESTDIR=$FAKEROOT/$NAME install
}
