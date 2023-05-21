NAME="speex"
DESC="Audio compression format designed specifically for speech"
VERSION="1.2.1"
SOURCE="https://downloads.xiph.org/releases/speex/speex-${VERSION}.tar.gz"
CHECKSUM="fe7bf610883ff202092b92c72fe0fe3e"
DEPS="libogg"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr    \
            --disable-static \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/speex-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
