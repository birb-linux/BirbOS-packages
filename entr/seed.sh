NAME="entr"
DESC="Run arbitrary commands when files change"
VERSION="5.3"
SOURCE="https://eradman.com/entrproject/code/entr-${VERSION}.tar.gz"
CHECKSUM="824b606a63e7b7c50dd4fb26cf34214b"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure
	make -j${MAKEOPTS}
}

_install()
{
	PREFIX=$FAKEROOT/$NAME/usr make install
}
