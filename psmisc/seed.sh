NAME="psmisc"
DESC="Programs for displaying information about running processes"
VERSION="23.7"
SOURCE="https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-${VERSION}.tar.xz"
CHECKSUM="53eae841735189a896d614cba440eb10"
DEPS=""
FLAGS="important"

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
