NAME="gnutls"
DESC="Libraries and userspace tools which provide a secure layer over a reliable transport layer"
VERSION="3.8.0"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{ print $1 "." $2}')"
SOURCE="https://www.gnupg.org/ftp/gcrypt/gnutls/v${SHORT_VERSION}/gnutls-${VERSION}.tar.xz"
CHECKSUM="20a662caf20112b6b9ad1f4a64db3a97"
DEPS="nettle make-ca libunistring libtasn1 p11-kit"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	disable_lto

	./configure --prefix=/usr \
            --docdir=/usr/share/doc/gnutls-${VERSION} \
			--enable-openssl-compatibility \
            --with-default-trust-store-pkcs11="pkcs11:"

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
