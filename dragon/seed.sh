NAME="dragon"
DESC="Drag and drop source/target for X"
VERSION="1.2.0"
SOURCE="https://github.com/mwh/dragon/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="1f57095f42e235c1a9ef4d6cf34b06ad"
DEPS="gtk+"
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
