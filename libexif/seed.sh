NAME="libexif"
DESC="A library for parsing, editing, and saving EXIF data"
VERSION="0.6.24"
SOURCE="https://github.com/libexif/libexif/releases/download/v${VERSION}/libexif-${VERSION}.tar.bz2"
CHECKSUM="00ea6e7ff62d3fd41ea9b2139746703c"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr    \
            --disable-static \
            --with-doc-dir=/usr/share/doc/libexif-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} check
}
