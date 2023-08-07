NAME="libidn2"
DESC="Package designed for internationalized string handling based on standards from the Internet Engineering Task Force (IETF)'s IDN working group"
VERSION="2.3.4"
SOURCE="https://ftp.gnu.org/gnu/libidn/libidn2-${VERSION}.tar.gz"
CHECKSUM="a12109804fc9c5d7fb31f068c66655b8"
DEPS="libunistring"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	disable_lto

	./configure --prefix=/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS}
}
