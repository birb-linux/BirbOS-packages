NAME="snappy"
DESC="A fast compressor/decompressor"
VERSION="1.1.10"
SOURCE="https://github.com/google/snappy/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="70153395ebe6d72febe2cf2e40026a44"
DEPS="cmake"
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

	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DSNAPPY_BUILD_TESTS=Off -DSNAPPY_BUILD_BENCHMARKS=Off -DBUILD_SHARED_LIBS=On
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
