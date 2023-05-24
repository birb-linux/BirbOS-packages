NAME="lzo"
DESC="Data compression library which is suitable for data decompression and compression in real-time"
VERSION="2.10"
SOURCE="https://www.oberhumer.com/opensource/lzo/download/lzo-${VERSION}.tar.gz"
CHECKSUM="39d3f3f9c55c87b1e5d6888e1420f4b5"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --enable-shared   \
            --disable-static  \
            --docdir=/usr/share/doc/lzo-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} check
	make -j${BUILD_JOBS} test
}
