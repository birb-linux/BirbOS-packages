NAME="make"
DESC="Program for controlling the generation of executables and other non-source files of a package from source files"
VERSION="4.4.1"
SOURCE="https://ftp.gnu.org/gnu/make/make-${VERSION}.tar.gz"
CHECKSUM="c8469a3713cbbe04d955d4ae4be23eeb"
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
	chown -Rv tester .
	su tester -c "PATH=$PATH make check"
}
