NAME="ncrack"
DESC="High-speed network authentication cracking tool"
VERSION="0.7"
SOURCE="https://nmap.org/ncrack/dist/ncrack-${VERSION}.tar.gz"
CHECKSUM="a6417241c994d8687dcfef1f40ac3f34"
DEPS="openssl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	disable_lto
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
