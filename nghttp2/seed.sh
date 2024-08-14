NAME="nghttp2"
DESC="Implementation of HTTP/2 and its header compression algorithm, HPACK"
VERSION="1.59.0"
SOURCE="https://github.com/nghttp2/nghttp2/releases/download/v${VERSION}/nghttp2-${VERSION}.tar.xz"
CHECKSUM="97c1931900eee69ac6dd1e1c09f22e30"
DEPS="libxml2"
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --disable-static  \
            --enable-lib-only \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/nghttp2-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
