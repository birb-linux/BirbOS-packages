NAME="gpgme"
DESC="C library that allows cryptography support to be added to a program"
VERSION="1.21.0"
SOURCE="https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-${VERSION}.tar.bz2"
CHECKSUM="3a83288e753a7da53a5626d29e4416fd"
DEPS="libassuan"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-gpg-test
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
