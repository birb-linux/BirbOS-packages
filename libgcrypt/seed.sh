NAME="libgcrypt"
DESC="General purpose crypto library based on the code used in GnuPG"
VERSION="1.10.1"
SOURCE="https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${VERSION}.tar.bz2"
CHECKSUM="8fadbe1fddafa341dce5ef3869f70e25"
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
