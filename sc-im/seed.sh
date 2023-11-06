NAME="sc-im"
DESC="Spreadsheet Calculator Improvised"
VERSION="0.8.3"
SOURCE="https://github.com/andmarti1424/sc-im/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="7187030fc475323ac8899eb21c5585f6"
DEPS="ncurses bison which pkg-config"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -C src prefix=/usr -j${BUILD_JOBS}
}

_install()
{
	make -C src DESTDIR=$FAKEROOT/$NAME prefix=/usr install
}
