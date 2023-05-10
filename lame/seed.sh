NAME="lame"
DESC="MP3 encoder and an MP3 frame analyzer"
VERSION="3.100"
SOURCE="https://downloads.sourceforge.net/lame/lame-${VERSION}.tar.gz"
CHECKSUM="83e260acbe4389b54fe08e0bdbf7cddb"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --enable-mp3rtp --disable-static

	make -j$(nproc)
}

_install()
{
	make pkghtmldir=$FAKEROOT/$NAME/usr/share/doc/lame-${VERSION} install
}

_test()
{
	make test
}
