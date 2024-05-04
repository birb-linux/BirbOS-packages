NAME="gzip"
DESC="Programs for compressing and decompressing files"
VERSION="1.13"
SOURCE="https://ftp.gnu.org/gnu/gzip/gzip-${VERSION}.tar.xz"
CHECKSUM="d5c9fc9441288817a4a0be2da0249e29"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} check
}
