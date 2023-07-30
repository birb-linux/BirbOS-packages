NAME="hexedit"
DESC="Full screen hex editor"
VERSION="0.9.7"
SOURCE="https://www.rogoyski.com/adam/programs/hexedit/hexedit-${VERSION}.tar.gz"
CHECKSUM="2658b81ab1bd0813c0117e9459071c13"
DEPS="ncurses"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
