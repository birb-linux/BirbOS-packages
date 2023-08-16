NAME="libksba"
DESC="Library used to make X.509 certificates as well as making the CMS (Cryptographic Message Syntax) easily accessible by other applications"
VERSION="1.6.3"
SOURCE="https://www.gnupg.org/ftp/gcrypt/libksba/libksba-${VERSION}.tar.bz2"
CHECKSUM="65683abfe7175e3cb19fb6f40175fea8"
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
