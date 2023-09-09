NAME="msgpack-c"
DESC="MessagePack implementation for C"
VERSION="6.0.0"
SOURCE="https://github.com/msgpack/msgpack-c/releases/download/c-${VERSION}/msgpack-c-${VERSION}.tar.gz"
CHECKSUM="adc08f48550ce772fe24c0b41166b0de"
DEPS="json-c"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build
	cmake .. -DMSGPACK_BUILD_TESTS=Off
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
