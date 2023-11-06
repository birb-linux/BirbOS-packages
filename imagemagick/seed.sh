NAME="imagemagick"
DESC="A collection of tools and libraries to read, write, and manipulate an image in various image formats"
VERSION="7.1.0-61"
SOURCE="https://www.imagemagick.org/archive/releases/ImageMagick-${VERSION}.tar.xz"
CHECKSUM="f9973657738b5c970325e97f198b9977"
DEPS="xorg-libs jasper little-cms libjpeg-turbo libpng libraw librsvg libtiff libwebp openjpeg pango"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ImageMagick-${VERSION}
}

_build()
{
	./configure --prefix=/usr     \
				--sysconfdir=/etc \
				--enable-hdri     \
				--with-modules    \
				--with-rsvg       \
				--disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME DOCUMENTATION_PATH=/usr/share/doc/imagemagick-${VERSION} install
}
