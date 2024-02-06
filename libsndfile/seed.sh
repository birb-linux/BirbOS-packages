NAME="libsndfile"
DESC="Library of C routines for reading and writing files containing sampled audio data"
VERSION="1.2.2"
SOURCE="https://github.com/libsndfile/libsndfile/releases/download/${VERSION}/libsndfile-${VERSION}.tar.xz"
CHECKSUM="04e2e6f726da7c5dc87f8cf72f250d04"
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

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} check
}
