NAME="libcurl-gnutls"
DESC="libcurl library with gnutls support"
VERSION="8.0.1"
LIB_VERSION="4.8.0"
SOURCE="https://curl.se/download/curl-${VERSION}.tar.xz"
CHECKSUM="f6c2fdeb30ad30234378a56c28350845"
DEPS="make-ca gnutls"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd curl-${VERSION}
}

_build()
{
	disable_lto

	./configure --prefix=/usr              \
            --disable-static               \
            --with-gnutls                  \
            --enable-threaded-resolver     \
            --with-ca-path=/etc/ssl/certs

	make -j${BUILD_JOBS}
}

_install()
{
	install -v -m755 "lib/.libs/libcurl.so.${LIB_VERSION}" "$FAKEROOT/$NAME/usr/lib/libcurl-gnutls.so.${LIB_VERSION}"
	ln -sr "$FAKEROOT/$NAME/usr/lib/libcurl-gnutls.so.${LIB_VERSION}" "$FAKEROOT/$NAME/usr/lib/libcurl-gnutls.so.$(major_version $LIB_VERSION)"
	ln -sr "$FAKEROOT/$NAME/usr/lib/libcurl-gnutls.so.${LIB_VERSION}" "$FAKEROOT/$NAME/usr/lib/libcurl-gnutls.so"
}
