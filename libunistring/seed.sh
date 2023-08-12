NAME="libunistring"
DESC="Library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard"
VERSION="1.1"
SOURCE="https://ftp.gnu.org/gnu/libunistring/libunistring-${VERSION}.tar.xz"
CHECKSUM="0dfba19989ae06b8e7a49a7cd18472a1"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	disable_lto

	./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/libunistring-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} check
}
