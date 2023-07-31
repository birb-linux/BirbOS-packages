NAME="nghttp2"
DESC="Implementation of HTTP/2 and its header compression algorithm, HPACK"
VERSION="1.52.0"
SOURCE="https://github.com/nghttp2/nghttp2/releases/download/v${VERSION}/nghttp2-${VERSION}.tar.xz"
CHECKSUM="30cab20160abb7981c713544d31e2d60"
DEPS="libxml2"
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static  \
            --enable-lib-only \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/nghttp2-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
