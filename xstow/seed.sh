NAME="xstow"
DESC="GNU Stow replacement written in C++"
VERSION="1.1.1"
SOURCE="https://github.com/majorkingleo/xstow/releases/download/${VERSION}/xstow-${VERSION}.tar.gz"
CHECKSUM="2fedf18c5f8bac34a160cc4c2ac0e423"
DEPS="ncurses"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --enable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
