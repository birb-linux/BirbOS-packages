NAME="libzip"
DESC="A C library for reading, creating, and modifying zip archives"
VERSION="1.10.0"
SOURCE="https://libzip.org/download/libzip-${VERSION}.tar.gz"
CHECKSUM="34998f4993320f8c930fda66405d32ff"
DEPS="cmake xz zstd"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	cmake .. -DCMAKE_INSTALL_PREFIX=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
