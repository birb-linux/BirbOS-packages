NAME="automake"
DESC="Programs for generating Makefiles for use with autoconf"
VERSION="1.16.5"
SOURCE="https://ftp.gnu.org/gnu/automake/automake-${VERSION}.tar.xz"
CHECKSUM="4017e96f89fca45ca946f1c5db6be714"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --docdir=/usr/share/doc/automake-${VERSION}

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	make -j${MAKEOPTS} check
}
