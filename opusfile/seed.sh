NAME="opusfile"
DESC="Stand-alone decoder library for .opus streams"
VERSION="0.12"
SOURCE="https://github.com/xiph/opusfile/releases/download/v${VERSION}/opusfile-${VERSION}.tar.gz"
CHECKSUM="45e8c62f6cd413395223c82f06bfa8ec"
DEPS="opus libogg"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
