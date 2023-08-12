NAME="xxhash"
DESC="Extremely fast non-cryptographic hash algorithm"
VERSION="0.8.2"
SOURCE="https://github.com/Cyan4973/xxHash/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="a7628d7a4fd608a7573c5a3e2c856ea5"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd xxHash-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME prefix=/usr install
}
