NAME="diffutils"
DESC="Programs for finding differences between files and directories"
VERSION="3.9"
SOURCE="https://ftp.gnu.org/gnu/diffutils/diffutils-${VERSION}.tar.xz"
CHECKSUM="cf0a65266058bf22fe3feb69e57ffc5b"
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
