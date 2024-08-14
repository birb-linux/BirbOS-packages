NAME="curl"
DESC="Utilities and a library for transferring files with URL syntax and lots of protocols"
VERSION="8.6.0"
SOURCE="https://curl.se/download/curl-${VERSION}.tar.xz"
CHECKSUM="8f28f7e08c91cc679a45fccf66184fbc"
DEPS="make-ca openssl libpsl"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	disable_lto

	./configure --prefix=/usr              \
            --disable-static               \
            --with-openssl                 \
            --enable-threaded-resolver     \
            --with-ca-path=/etc/ssl/certs

	make
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME make install

	rm -rf docs/examples/.deps

	find docs \( -name Makefile\* -o -name \*.1 -o -name \*.3 \) -exec rm {} \;

	install -v -d -m755 $FAKEROOT/$NAME/usr/share/doc/curl-${VERSION}
	cp -v -R docs/*     $FAKEROOT/$NAME/usr/share/doc/curl-${VERSION}
}

_test()
{
	export USER="$(whoami)"
	make -j${BUILD_JOBS} test
}
