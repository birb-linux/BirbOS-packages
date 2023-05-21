NAME="faac"
DESC="Encoder for a lossy sound compression scheme and known as Advanced Audio Coding (AAC)"
VERSION="1_30"
SOURCE="https://github.com/knik0/faac/archive/${VERSION}/faac-${VERSION}.tar.gz"
CHECKSUM="8d61e6d55088e599aa91532d5e6995b0"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./bootstrap
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
