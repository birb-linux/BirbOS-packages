NAME="grep"
DESC="Programs for searching through the contents of a file"
VERSION="3.10"
SOURCE="https://ftp.gnu.org/gnu/grep/grep-${VERSION}.tar.xz"
CHECKSUM="ab3f063ad4596b7d094fb5f66cf327d6"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Remove some warnings about using egrep and fgrep, because these make
	# some tests fail
	sed -i "s/echo/#echo/" src/egrep.sh

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
