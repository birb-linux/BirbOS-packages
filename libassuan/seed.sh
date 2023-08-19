NAME="libassuan"
DESC="Inter process communication library used by some of the other GnuPG related packages"
VERSION="2.5.5"
SOURCE="https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-${VERSION}.tar.bz2"
CHECKSUM="7194453152bb67e3d45da698762b5d6f"
DEPS="libgpg-error"
FLAGS="test"

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

_test()
{
	make -j${BUILD_JOBS} check
}
