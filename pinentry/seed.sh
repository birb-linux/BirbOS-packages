NAME="pinentry"
DESC="A collection of simple PIN or pass-phrase entry dialogs which utilize the Assuan protocol"
VERSION="1.2.1"
SOURCE="https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-${VERSION}.tar.bz2"
CHECKSUM="be9b0d4bb493a139d2ec20e9b6872d37"
DEPS="libassuan libgpg-error"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --enable-pinentry-tty
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
