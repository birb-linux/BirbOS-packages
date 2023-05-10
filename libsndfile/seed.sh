NAME="libsndfile"
DESC="Library of C routines for reading and writing files containing sampled audio data"
VERSION="1.2.0"
SOURCE="https://github.com/libsndfile/libsndfile/releases/download/${VERSION}/libsndfile-${VERSION}.tar.xz"
CHECKSUM="00fbf50ce1d7a67a8e6dc0a04f4d8d2e"
DEPS="flac opus libvorbis"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr    \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/libsndfile-${VERSION}

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
