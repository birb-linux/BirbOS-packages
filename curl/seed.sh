NAME="curl"
DESC="Utilities and a library for transferring files with URL syntax and lots of protocols"
VERSION="8.0.1"
SOURCE="https://curl.se/download/curl-${VERSION}.tar.xz"
CHECKSUM="f6c2fdeb30ad30234378a56c28350845"
DEPS="make-ca openssl"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr        \
            --disable-static                        \
            --with-openssl                          \
            --enable-threaded-resolver              \
            --with-ca-path=/etc/ssl/certs

	make
}

_install()
{
	make install &&

	rm -rf docs/examples/.deps

	find docs \( -name Makefile\* -o -name \*.1 -o -name \*.3 \) -exec rm {} \;

	install -v -d -m755 $FAKEROOT/$NAME/usr/share/doc/curl-${VERSION}
	cp -v -R docs/*     $FAKEROOT/$NAME/usr/share/doc/curl-${VERSION}
}

_test()
{
	export USER="$(whoami)"
	make -j${MAKEOPTS} test
}
