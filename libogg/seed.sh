NAME="libogg"
DESC="Library for encoding and decoding Ogg files"
VERSION="1.3.5"
SOURCE="https://downloads.xiph.org/releases/ogg/libogg-${VERSION}.tar.xz"
CHECKSUM="3178c98341559657a15b185bf5d700a5"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr    \
            --disable-static \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/libogg-${VERSION}

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
