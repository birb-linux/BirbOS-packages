NAME="psmisc"
DESC="Programs for displaying information about running processes"
VERSION="23.6"
SOURCE="https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-${VERSION}.tar.xz"
CHECKSUM="ed3206da1184ce9e82d607dc56c52633"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j$(nproc)
}

_install()
{
	make install
}
