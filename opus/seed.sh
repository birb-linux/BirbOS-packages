NAME="opus"
DESC="Opus development library and headers"
VERSION="1.3.1"
SOURCE="https://archive.mozilla.org/pub/opus/opus-${VERSION}.tar.gz"
CHECKSUM="d7c07db796d21c9cf1861e0c2b0c0617"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/opus-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make check
}
