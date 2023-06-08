NAME="jq"
DESC="Command-line JSON processor"
VERSION="1.6"
SOURCE="https://github.com/jqlang/jq/releases/download/jq-${VERSION}/jq-${VERSION}.tar.gz"
CHECKSUM="e68fbd6a992e36f1ac48c99bbf825d6b"
DEPS="oniguruma"
FLAGS="test"

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

_test()
{
	make -j${BUILD_JOBS} check
}
