NAME="bison"
DESC="Parser generator"
VERSION="3.8.2"
SOURCE="https://ftp.gnu.org/gnu/bison/bison-${VERSION}.tar.xz"
CHECKSUM="c28f119f405a2304ff0a7ccdcc629713"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --docdir=/usr/share/doc/bison-${VERSION}

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
