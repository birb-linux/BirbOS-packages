NAME="grep"
DESC="Programs for searching through the contents of a file"
VERSION="3.11"
SOURCE="https://ftp.gnu.org/gnu/grep/grep-${VERSION}.tar.xz"
CHECKSUM="7c9bbd74492131245f7cdb291fa142c0"
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
