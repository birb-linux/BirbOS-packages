NAME="diffutils"
DESC="Programs for finding differences between files and directories"
VERSION="3.10"
SOURCE="https://ftp.gnu.org/gnu/diffutils/diffutils-${VERSION}.tar.xz"
CHECKSUM="2745c50f6f4e395e7b7d52f902d075bf"
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
