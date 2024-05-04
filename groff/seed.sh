NAME="groff"
DESC="Programs for processing and formatting text and images"
VERSION="1.23.0"
SOURCE="https://ftp.gnu.org/gnu/groff/groff-${VERSION}.tar.gz"
CHECKSUM="5e4f40315a22bb8a158748e7d5094c7d"
DEPS=""
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	PAGE=A4 ./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
