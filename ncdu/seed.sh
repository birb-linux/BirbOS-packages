NAME="ncdu"
DESC="Disk usage analyzer with an ncurses interface"
VERSION="1.18.1"
SOURCE="https://dev.yorhel.nl/download/ncdu-${VERSION}.tar.gz"
CHECKSUM="567df772ef0f2e28801009a90ab7b8e3"
DEPS="ncurses"
FLAGS=""

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
