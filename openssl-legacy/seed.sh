NAME="openssl-legacy"
DESC="Contains 1.1.1 versions of libcrypto and libssl required by some software"
VERSION="1.1.1"
SOURCE="https://www.openssl.org/source/openssl-${VERSION}v.tar.gz"
CHECKSUM="9edcfdd9b96523df82b312c404f4b169"
DEPS="zlib perl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd openssl-${VERSION}v
}

_build()
{
	./config --prefix=/usr \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic

	make -j${BUILD_JOBS}
}

_install()
{
	# Only install libcrypto and libssl
	install -v -m755 ./{libssl,libcrypto}.so.1.1 $FAKEROOT/$NAME/usr/lib
}
