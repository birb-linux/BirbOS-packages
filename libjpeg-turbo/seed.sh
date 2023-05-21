NAME="libjpeg-turbo"
DESC="Fork of the original IJG libjpeg which uses SIMD to accelerate baseline JPEG compression and decompression"
VERSION="2.1.5.1"
SOURCE="https://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-${VERSION}.tar.gz"
CHECKSUM="aed60d4d776dd5cf00b5a01c609d50f7"
DEPS="cmake nasm"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	cmake -DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr \
		  -DCMAKE_BUILD_TYPE=RELEASE  \
		  -DENABLE_STATIC=FALSE       \
		  -DCMAKE_INSTALL_DOCDIR=$FAKEROOT/$NAME/usr/share/doc/libjpeg-turbo-${VERSION} \
		  -DCMAKE_INSTALL_DEFAULT_LIBDIR=lib  \
		  ..

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} test
}
