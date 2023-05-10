NAME="flac"
DESC="FLAC is an audio CODEC similar to MP3, but lossless"
VERSION="1.4.2"
SOURCE="https://downloads.xiph.org/releases/flac/flac-${VERSION}.tar.xz"
CHECKSUM="ca9140f37b286d2571e37d66aae50f92"
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
            --disable-thorough-tests \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/flac-${VERSION}

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	make check
}
