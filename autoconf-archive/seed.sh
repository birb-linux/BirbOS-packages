NAME="autoconf-archive"
DESC="A collection of freely re-usable Autoconf macros"
VERSION="2023.02.20"
SOURCE="https://www.nic.funet.fi/pub/gnu/ftp.gnu.org/pub/gnu/autoconf-archive/autoconf-archive-${VERSION}.tar.xz"
CHECKSUM="1a9ee97d3503d134e16c87c4fa1119cf"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
		--bindir=/usr         \
		--sbindir=/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
