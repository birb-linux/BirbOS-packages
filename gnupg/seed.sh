NAME="gnupg"
DESC="GNU's tool for secure communication and data storage"
VERSION="2.4.0"
SOURCE="https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-${VERSION}.tar.bz2"
CHECKSUM="1a9dd55be7a9d0a6ef34ec3ba0d674a5"
DEPS="libassuan libgcrypt libksba npth gnutls pinentry"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	../configure --prefix=/usr       \
             --localstatedir=/var    \
             --sysconfdir=/etc       \
             --docdir=/usr/share/doc/gnupg-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS}
}
