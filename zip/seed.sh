NAME="zip"
DESC="Zip utilities useful for compressing files into ZIP archives"
VERSION="30"
SOURCE="https://downloads.sourceforge.net/infozip/zip${VERSION}.tar.gz"
CHECKSUM="7b74551e63f8ee6aab6fbc86676c0d37"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}${VERSION}
}

_build()
{
	make -f unix/Makefile generic_gcc
}

_install()
{
	make prefix=$FAKEROOT/$NAME/usr MANDIR=$FAKEROOT/$NAME/usr/share/man/man1 -f unix/Makefile install
}
