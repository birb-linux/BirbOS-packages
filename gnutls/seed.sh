NAME="gnutls"
DESC="Libraries and userspace tools which provide a secure layer over a reliable transport layer"
VERSION="3.8.1"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://www.gnupg.org/ftp/gcrypt/gnutls/v${SHORT_VERSION}/gnutls-${VERSION}.tar.xz"
CHECKSUM="31a4b85586522c527b044597e86870a4"
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
