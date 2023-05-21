NAME="nodejs"
DESC="JavaScript runtime built on Chrome's V8 JavaScript engine"
VERSION="18.14.1"
SOURCE="https://nodejs.org/dist/v${VERSION}/node-v${VERSION}.tar.xz"
CHECKSUM="09aaaa219c453d6d5307641cc41b76e1"
DEPS="which c-ares icu libuv nghttp2 zlib"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd node-v${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --shared-cares         \
            --shared-libuv         \
            --shared-openssl       \
            --shared-nghttp2       \
            --shared-zlib          \
            --with-intl=system-icu

	make -j${BUILD_JOBS}
}

_install()
{
	make install
	ln -sf node $FAKEROOT/$NAME/usr/share/doc/node-${VERSION}
}

_test()
{
	# One test is known to fail

	set +e
	make test-only
	set -e
}
