NAME="libwebp"
DESC="Library and support programs to encode and decode images in WebP format"
VERSION="1.3.2"
SOURCE="http://downloads.webmproject.org/releases/webp/libwebp-${VERSION}.tar.gz"
CHECKSUM="34869086761c0e2da6361035f7b64771"
DEPS="libjpeg-turbo libpng libtiff"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --enable-libwebpmux     \
            --enable-libwebpdemux   \
            --enable-libwebpdecoder \
            --enable-libwebpextras  \
            --enable-swap-16bit-csp \
            --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
