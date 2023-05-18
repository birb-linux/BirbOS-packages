NAME="libwebp"
DESC="Library and support programs to encode and decode images in WebP format"
VERSION="1.3.0"
SOURCE="http://downloads.webmproject.org/releases/webp/libwebp-${VERSION}.tar.gz"
CHECKSUM="994cf2efb664ef5140fa0b56b83fa721"
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

	make -j${MAKEOPTS}
}

_install()
{
	make install
}
