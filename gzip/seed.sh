NAME="gzip"
DESC="Programs for compressing and decompressing files"
VERSION="1.12"
SOURCE="https://ftp.gnu.org/gnu/gzip/gzip-${VERSION}.tar.xz"
CHECKSUM="9608e4ac5f061b2a6479dc44e917a5db"
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
