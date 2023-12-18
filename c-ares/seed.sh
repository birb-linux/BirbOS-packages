NAME="c-ares"
DESC="C library for asynchronous DNS requests"
VERSION="1.19.1"
SOURCE="https://c-ares.haxx.se/download/c-ares-${VERSION}.tar.gz"
CHECKSUM="dafc5825a92dc907e144570e4e75a908"
DEPS="cmake"
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

	cmake  -DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr ..
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
