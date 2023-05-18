NAME="speexdsp"
DESC="Speech processing library that goes along with the Speex codec"
VERSION="1.2.1"
SOURCE="https://downloads.xiph.org/releases/speex/speexdsp-${VERSION}.tar.gz"
CHECKSUM="e6eb5ddef743a362c8018f260b91dca5"
DEPS="libogg"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/speexdsp-${VERSION}

	make -j${MAKEOPTS}
}

_install()
{
	make install
}
